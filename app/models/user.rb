class User < ApplicationRecord
  belongs_to :dealer
  has_secure_password
  validates :first_name, :last_name, presence: true, on: :update
  validates :email, presence: true
  validates :email, uniqueness: true

  include FullName::InstanceMethods

  def admin?
    self.admin ? "Yes" : "No"
  end

  def sys_role
    self.admin ? "Admin" : "User"
  end

  def admin_deletable?
    User.count { |u| u.admin == true && u.status == "active"} > 2 ? true : false
  end
end
