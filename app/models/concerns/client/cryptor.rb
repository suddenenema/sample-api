module Client::Cryptor
  extend ActiveSupport::Concern

  def decrypt_params(params)
    data = params[:data].presence
    if data
      string = Blowfish.new(secret_key, data).decrypt
      Rack::Utils.parse_nested_query(string).with_indifferent_access
    end
  end

  def encrypt_params(params)
    Blowfish.new(secret_key, params.to_query).encrypt
  end

end

