require 'rails_helper'

describe 'Validations' do
  before(:each) do
    @user = User.new(first_name: 'Alice', last_name: 'Smith', email: 'alice@example.com', password: 'password123', password_confirmation: 'password123')
    @user2 = User.new(first_name: 'Bob', last_name: 'Johnson', email: 'bob@example.com', password: 'password456', password_confirmation: 'password456')
    @user3 = User.new(first_name: 'Charlie', last_name: 'Davis', email: 'charlie@example.com', password: 'password123', password_confirmation: 'password123')
    expect(@user.save).to eq(true)
  end

  it 'Validates with valid attributes' do
    expect(@user).to be_valid
  end

  context 'Name Validation' do
    it 'Is not valid without a first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it 'Is not valid without a last name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  end

  context 'Email Validation' do
    it 'Is not valid without an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'Is not valid if user signs up with email that already exists' do
      @user2.email = 'alice@example.com'
      expect(@user2).to_not be_valid
    end
  end

  context 'Password Validation' do
    it 'Is not valid without a password' do
      @user.password = nil
      expect(@user).to_not be_valid
    end

    it 'Is not valid without password confirmation' do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it 'Is not valid if password and password confirmation do not match' do
      @user.password_confirmation = 'not matching'
      expect(@user).to_not be_valid
    end

    it 'Is not valid if password does not meet minimum length of 5 characters' do
      @user3.password = '1234'
      expect(@user3).to_not be_valid
    end
  end
end

describe '.authenticate_with_credentials' do
  before(:each) do
    @user = User.new(first_name: 'Jim', last_name: 'Bob', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    expect(@user.save).to eq(true)
  end

  context 'Username Validation' do
    it 'authenticates with valid credentials' do
      authenticated_user = User.authenticate_with_credentials('test@test.com', '12345678')
      expect(authenticated_user).to eq(@user)
    end

    it 'email is case insensitive' do
      authenticated_user = User.authenticate_with_credentials('TEST@TEST.com', '12345678')
      expect(authenticated_user).to eq(@user)
    end

    it 'strips whitespace from email' do
      authenticated_user = User.authenticate_with_credentials(' test@test.com ', '12345678')
      expect(authenticated_user).to eq(@user)
    end
  end
end
