class Passenger < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_and_belongs_to_many :rides, dependent: :destroy

  validates :user_id, presence: true
end
