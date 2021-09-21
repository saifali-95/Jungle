require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) { User.new(first_name: "Saif", last_name: "Ali", email: "saifali@gmail.com", password: "123", password_confirmation: "123") }

    it "should NOT pass if first Name is not present" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "should NOT pass if last Name is not present" do
      user.last_name = nil
      expect(user).to_not be_valid
    end
    
    it "should NOT pass if email is not present" do
      user.email = nil
      expect(user).to_not be_valid
    end
    
    it "should pass when passwords are matching" do
      expect(user).to be_valid
    end

    it "should NOT pass when passwords are not matching" do
      user.password = "456"
      expect(user).to_not be_valid
    end
    it "should NOT pass when passwords is too short" do
      user.password = "3"
      user.password_confirmation = "3"
      expect(user).to_not be_valid
    end
    it "should NOT pass if password confirmation is not present" do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end

  end

  describe '.authenicate_with_credentials' do
    let(:user) { User.new(first_name: "Saif", last_name: "Ali", email: "saifali@gmail.com", password: "123", password_confirmation: "123") }
    

    it "should return truthy if password and email are authenticate" do
      user.save!
      @new_login = User.authenticate_with_credentials("saifali@gmail.com", "123")
      expect(@new_login).to be_truthy
    end

    it "should return truthy even if the email address is lower/upper case" do
      user.save!
      @new_login = User.authenticate_with_credentials("SAIfali@gmail.com", "123")
      expect(@new_login).to be_truthy
    end

    it "should return truthy even if the email contains whitespaces in the beginning or end" do
      user.save!
      @new_login = User.authenticate_with_credentials(" saifali@gmail.com    ", "123")
      expect(@new_login).to be_truthy
    end

    it "should return nil if email and password not found in database" do
      user.save!
      @new_login = User.authenticate_with_credentials("saifali@yahoo.com", "123")
      expect(@new_login).to be_nil
    end
  end

end
