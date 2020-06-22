class User < ApplicationRecord
  belongs_to :dealer
  has_secure_password
end
