class Client < ActiveRecord::Base
  include AuthVerifier
  include Cryptor
  include KeyGenerator
end
