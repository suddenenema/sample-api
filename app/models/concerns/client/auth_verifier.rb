module Client::AuthVerifier
  extend ActiveSupport::Concern

  def sig_correct?(params)
    params[:sig] == gage_sig(params.except(:sig))
  end

  private

  def gage_sig(params)
    Digest::MD5.hexdigest(Hash[params.sort].to_query + private_key)
  end

  module ClassMethods

    def authorized?(params)
      client = find_by(token: params[:token])
      client && client.sig_correct?(params)
    end

  end

end
