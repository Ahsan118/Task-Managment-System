require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:other_user) { create(:user) }
  let(:other_category) { create(:category, name: "Another Category", user: other_user) }
  describe "validations" do
    it "is valid with valid attributes" do
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category.name = nil
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name for the same user" do
      duplicate_category = build(:category, name: category.name, user: category.user)
      expect(duplicate_category).not_to be_valid
      expect(duplicate_category.errors[:name]).to include("has already been taken for this user")
    end

    it "is valid with a duplicate name for a different user" do
      duplicate_category = build(:category, name: category.name, user: other_user)
      expect(duplicate_category).to be_valid
    end
  end

  describe "associations" do
    it "has many tasks" do
      association = described_class.reflect_on_association(:tasks)
      expect(association.macro).to eq(:has_many)
    end

    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "scopes" do
    let!(:user_category) { create(:category, user: user, name: "User Category") }
    let!(:other_user_category) { create(:category, user: other_user, name: "Other User Category") }

    it "returns categories for a specific user with for_user scope" do
      result = Category.for_user(user)
      expect(result).to include(user_category)
      expect(result).not_to include(other_user_category)
    end

    it "includes user in the result with with_user scope" do
      result = Category.with_user
      expect(result).to include(user_category, other_user_category)
    end
  end

  describe "pg_search_scope" do
    before do
      category.update(name: "Test Category")
      other_category.update(name: "Another Example")
    end

    it "returns categories matching the search keyword" do
      result = Category.search_by_keyword("Test")
      expect(result).to include(category)
      expect(result).not_to include(other_category)
    end

    it "returns categories matching partial search terms" do
      result = Category.search_by_keyword("Exam")
      expect(result).to include(other_category)
      expect(result).not_to include(category)
    end
  end
end
