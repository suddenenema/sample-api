module Client::KeyGenerator
  extend ActiveSupport::Concern

  included do
    validates :token, :private_key, :secret_key, presence: true, uniqueness: true

    after_initialize :generate_keys, if: :new_record?
  end

  private

  def generate_keys
    loop do
      self.token       = SecureRandom.urlsafe_base64(64)
      self.private_key = SecureRandom.urlsafe_base64(128)
      # blowfish key length must be a multiple of 8 and no longer than 56
      # SecureRandom.urlsafe_base64(base).length == base * 4/3
      # so for base = 42 key.length = 56
      self.secret_key  = SecureRandom.urlsafe_base64(42)
      break if valid?
    end
  end
end
