class Dealer < ApplicationRecord
    has_many :users
    has_many :services
    has_many :customers
    has_many :appointments, through: :services
end
