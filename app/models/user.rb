class User < ApplicationRecord
  belongs_to :dealer
  has_secure_password

  def full_name
    self.first_name + " " + self.last_name
  end
  
  def admin?
    self.admin ? "Yes" : "No"
  end

  def sys_role
    self.admin ? "Admin" : "User"
  end

end
