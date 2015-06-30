module Client::AuthVerifier
  extend ActiveSupport::Concern

  module ClassMethods

    def authorize(params)
      client = find_by(token: params[:token])
      client && client.sig_correct?(params) && client
    end

  end

  def sig_correct?(params)
    decrypted_params = decrypt_params(params) || {}
    decrypted_params[:sig] == gage_sig(decrypted_params.except(:sig))
  end

  private

  def gage_sig(params)
    Digest::MD5.hexdigest(Hash[params.sort].to_query + private_key)
  end

end
