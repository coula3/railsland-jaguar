class User < ApplicationRecord
  belongs_to :dealer
  validates :first_name, :last_name, presence: true, on: :update
  validates :position, length: {maximum: 24}
  validates :email, email: true
  validates :email, uniqueness: true
  has_secure_password

  def admin?
    self.admin ? "Yes" : "No"
  end

  def sys_role
    self.admin ? "Admin" : "User"
  end

  def admin_deletable?
    User.count { |u| u.admin == true && u.status == "active"} > 2 ? true : false
  end

  def full_name
    ["#{self.first_name}", "#{self.last_name}"].join(" ")
  end

  def new_inactive_user
    self if (self.created_at == self.updated_at) && (self.first_name.blank? || self.last_name.blank?)
  end
end
