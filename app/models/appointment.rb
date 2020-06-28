class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :service

  validates :date, :time, :veh_model, :model_year, presence: true
end
