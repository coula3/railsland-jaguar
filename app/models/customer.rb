class Customer < ApplicationRecord
  belongs_to :dealer
  has_many :appointments
end