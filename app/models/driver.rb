class Driver < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_many :vehicles, dependent: :destroy
  has_many :rides, dependent: :destroy

  def user
    super || build_user
  end

  delegate_associations to: :user
  delegate_attributes to: :user
end
