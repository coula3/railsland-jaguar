class User < ApplicationRecord
  belongs_to :dealer
  has_secure_password

  def full_name
    self.first_name + " " + self.last_name
  end
end
