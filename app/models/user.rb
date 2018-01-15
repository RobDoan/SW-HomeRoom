class User < ApplicationRecord
  has_many :bookings, inverse_of: :user, dependent: :destroy
end
