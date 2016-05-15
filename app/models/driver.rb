class Driver < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_many :vehicles, dependent: :destroy
  has_many :rides, dependent: :destroy

  validates :user_id, presence: true
end
