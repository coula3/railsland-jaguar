class Dealer < ApplicationRecord
    has_many :users
    has_many :services
    has_many :customers
end
