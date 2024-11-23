# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "associations" do
    it { should have_many(:tasks).dependent(:destroy) }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a duplicate email" do
      create(:user, email: user.email)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a password shorter than 6 characters" do
      user.password = "12345"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end


  describe "dependent destroy" do
    it "deletes associated tasks when the user is deleted" do
      user = create(:user)
      create_list(:task, 3, user: user)
      expect { user.destroy }.to change(Task, :count).by(-3)
    end
  end
end
