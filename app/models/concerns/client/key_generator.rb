module Client::KeyGenerator
  extend ActiveSupport::Concern

  included do
    validates :token, :private_key, presence: true, uniqueness: true

    after_initialize :generate_keys
  end

  private

  def generate_keys
    loop do
      self.token       = SecureRandom.urlsafe_base64(64)
      self.private_key = SecureRandom.urlsafe_base64(128)
      break if valid?
    end
  end
end
