class User < ActiveRecord::Base
  after_create :initialize_associations

  def initialize_associations
    self.driver = Driver.new(user_id: self.id)
    self.passenger = Passenger.new(user_id: self.id)
    self.driver.save
    self.passenger.save
  end

  has_one :driver, dependent: :destroy
  has_one :passenger, dependent: :destroy
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => { with: valid_email_regex }
  validates :email, :uniqueness => true
  validates :name, presence: true
  validates :facebook_id, presence: true
  validates :photo_url, presence: true

  def fetch_auth_token!
    self.auth_token = SecureRandom.base64(50)
    self.save!
    self.auth_token
  end
end
