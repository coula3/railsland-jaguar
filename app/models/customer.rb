class Customer < ApplicationRecord
  belongs_to :dealer
  has_many :appointments, dependent: :destroy
  validates :first_name, :last_name, presence: true
  validates :email, email: true
  validates :email, uniqueness: true
  validates :telephone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "uses 555-555-5555 format" }

  scope :with_service_insurance, -> { where(service_insurance: true) }
  
  def has_service_insurance?
    self.service_insurance ? "Yes" : "No"
  end

end
