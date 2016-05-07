class Vehicle < ActiveRecord::Base
  has_many :rides, dependent: :destroy
  belongs_to :driver
end
