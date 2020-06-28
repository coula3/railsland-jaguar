class Dealer < ApplicationRecord
    has_many :users
    has_many :services
    has_many :customers
    has_many :appointments, through: :services

    validates :name, :address, :city, :state, :zip, presence: true
    validates :telephone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "uses 555-555-5555 format" }
    validates :zip, length: { is: 5 }
    validates :zip, numericality: { only_integer:  true}
end
