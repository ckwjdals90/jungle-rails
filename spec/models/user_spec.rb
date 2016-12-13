require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should have a valid test subject' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: '007@sis.gov.uk', password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user).to be_valid
    end

    it 'should not be valid if first_name is nil' do
      @user = User.new(first_name: nil, last_name: 'Bond', email: '007@sis.gov.uk', password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user).to_not be_valid
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'should not be valid if last_name is nil' do
      @user = User.new(first_name: 'James', last_name: nil, email: '007@sis.gov.uk', password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user).to_not be_valid
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it 'should not be valid if email is nil' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should be valid even if email is in capitals' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: '007@MI6.CO.UK', password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user).to be_valid
    end

    it 'should not be valid if password is nil' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: nil, password_confirmation: 'amdb5')
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should not be valid if password_confirmation is nil' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: 'amdb5', password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'should be valid if password matches password_confirmation' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: 'amdb5', password_confirmation: 'amdb5')
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'should not be valid if password does not match password_confirmation' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: 'amdb5', password_confirmation: 'asdf')
      expect(@user.password).to_not eq(@user.password_confirmation)
    end

    it 'should not be valid if password is shorter than 5' do
      @user = User.new(first_name: 'James', last_name: 'Bond', email: nil, password: 'db5', password_confirmation: 'db5')
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    before :each do
      @bond = User.create(first_name: 'James', last_name: 'Bond', email: '007@sis.gov.uk', password: 'amdb5', password_confirmation: 'amdb5')
      @BOURNE = User.create(first_name: 'Jason', last_name: 'Bourne', email: 'BOURNE@CIA.GOV', password: 'whoami', password_confirmation: 'whoami')
    end

    it 'should authenticate the user with right values' do
      user = User.authenticate_with_credentials('007@sis.gov.uk', 'amdb5')
      expect(user).to eq(@bond)
    end

    it 'should authenticate the user signed up with case_sensitive wrong' do
      userLow = User.authenticate_with_credentials('bourne@cia.gov', 'whoami')
      expect(userLow).to eq(@BOURNE)
    end

    it 'should authenticate the user signing in with case_sensitive wrong' do
      userUp = User.authenticate_with_credentials('007@SIS.GOV.UK', 'amdb5')
      expect(userUp).to eq(@bond)
    end

    it 'should authenticate the user signing in with a space in email' do
      userUp = User.authenticate_with_credentials(' 007@sis.gov.uk', 'amdb5')
      expect(userUp).to eq(@bond)
    end

  end
end
