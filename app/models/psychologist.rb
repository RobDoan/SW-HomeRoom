class Psychologist < ApplicationRecord
  has_many :bookings, inverse_of: :psycologist, dependent: :destroy
end
