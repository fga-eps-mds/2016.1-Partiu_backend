require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it { expect(@user).to respond_to(:name, :email) }

  it { expect(@user).to be_valid }

end
