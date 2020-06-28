class Customer < ApplicationRecord
  belongs_to :dealer
  has_many :appointments, dependent: :destroy
  
  include FullName::InstanceMethods

  def has_service_insurance?
    self.service_insurance ? "Yes" : "No"
  end

  scope :with_service_insurance, -> { where(service_insurance: true) }
end
