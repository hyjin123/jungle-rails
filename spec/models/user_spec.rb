require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do

    before(:each) do
      @old_user = User.new(first_name: "Sean", 
        last_name: "Jin", 
        email: "unique@email.com",
        password: "password",
        password_confirmation: "password"
        )
      @old_user.save
    end

    let(:user) {User.new(first_name: "Sean", 
      last_name: "Jin", 
      email: "seanjin@email.com",
      password: "password",
      password_confirmation: "password"
      )}

      it 'password is required' do
        user.password = nil
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq ["Password can't be blank"]
      end
    
      it 'password confirmation is required' do
        user.password_confirmation = nil
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq ["Password confirmation can't be blank"]
      end

      it 'password and password confirmation matchs' do
        expect(user).to be_valid
      end

      it 'password and password confirmation does not match' do
        user.password = "wrongpassword"
        expect(user).to_not be_valid
      end
    
      it 'email is required' do
        user.email = nil
        expect(user).to_not be_valid
      end

      it 'first name is required' do
        user.first_name = nil
        expect(user).to_not be_valid
      end

      it 'last name is required' do
        user.last_name = nil
        expect(user).to_not be_valid
      end

      it 'password length must exceed 6 characters' do
        user.password = "pass"
        user.password_confirmation = "pass"
        expect(user).to_not be_valid
      end

      it 'email must be unique' do
        user.email = "uNiqUe@email.com"
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq ["Email has already been taken"]
      end

  end

  describe '.authenticate_with_credentials' do

    it 'returns user if successfully authenticated' do
      user1 = User.authenticate_with_credentials("unique@email.com", "password")
      user = User.find_by_email("unique@email.com")
      expect(user1).to eq user
    end

    it 'returns nil if not successfully authenticated' do
      user1 = User.authenticate_with_credentials("unique@email.com", "wrongpassword")
      expect(user1).to be nil
    end

    it 'returns user even if there are spaces around email' do
      user1 = User.authenticate_with_credentials(" unique@email.com ", "password")
      user = User.find_by_email("unique@email.com")
      expect(user1).to eq user
    end

    it 'returns user even if the cases do not match in email' do
      user1 = User.authenticate_with_credentials("uniQUe@email.COM", "password")
      user = User.find_by_email("unique@email.com")
      expect(user1).to eq user
    end

  end

end
