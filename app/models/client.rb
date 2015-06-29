class Client < ActiveRecord::Base
  include AuthVerifier
  include KeyGenerator
end
