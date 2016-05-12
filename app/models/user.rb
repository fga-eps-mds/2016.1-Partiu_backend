class User < ActiveRecord::Base
  has_one :driver, dependent: :destroy
  has_one :passenger, dependent: :destroy
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => { with: valid_email_regex }
  validates :email, :uniqueness => true
end
