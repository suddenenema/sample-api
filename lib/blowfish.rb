class Blowfish < Struct.new(:key, :data)

  CIPHER = 'bf-ecb'

  def method_missing(mode)
    begin
      cipher(mode)
    rescue OpenSSL::Cipher::CipherError
    end
  end

  private

  def cipher(mode)
    cipher = OpenSSL::Cipher::Cipher.new(CIPHER)

    cipher.send(mode)
    cipher.key = key
    cipher.update(data) << cipher.final
   end

end
