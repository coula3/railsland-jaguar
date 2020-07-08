class Service < ApplicationRecord
  belongs_to :dealer
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :name, uniqueness: { case_sensitive: false }
end
