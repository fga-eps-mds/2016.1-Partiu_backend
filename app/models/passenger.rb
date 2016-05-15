class Passenger < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_and_belongs_to_many :rides, dependent: :destroy

  def user
    super || build_user
  end

  delegate_associations to: :user
  delegate_attributes to: :user
end
