require 'rails_helper'

RSpec.feature "Category Management", type: :feature do
  let(:user) { create(:user, email: "test@example.com", password: "password") }
  let!(:category1) { create(:category, name: "Work", user: user) }
  let!(:category2) { create(:category, name: "Personal", user: user) }

  before do
    login_as(user)
    visit categories_path
  end

  scenario "User views a list of categories" do
    visit categories_path
    expect(page).to have_content("Work")
    expect(page).to have_content("Personal")
  end

  scenario "User creates a new category" do
    find('button', text: '+ Create').click
    within("#addCategoryModal") do
      fill_in "category_name", with: "Shopping"
      click_button "Confirm"
    end
    expect(page).to have_content("Category created successfully")
    expect(page).to have_content("Shopping")
  end

  scenario "User updates an existing category" do
    find("button[id='action-#{category1.id}']").click
    find("button[id='edit-action-#{category1.id}']").click
    within("#editCategoryModal-#{category1.id}") do
      fill_in "category_name", with: "Updated Work"
      click_button "Confirm"
    end
    expect(page).to have_content("Category updated successfully")
    expect(page).to have_content("Updated Work")
  end

  scenario "User deletes a category" do
    find("button[id='action-#{category1.id}']").click
    find("button[data-id='#{category1.id}']").click

    within("#deleteModal-category_#{category1.id}") do
      click_button "Delete"
    end

    expect(page).to have_content("Category deleted successfully")
    expect(page).not_to have_content("Work")
  end

  scenario "User cannot delete a category with associated tasks" do
    create(:task, category: category1, user: user, title: "Sample Task")
    find("button[id='action-#{category1.id}']").click
    find("button[data-id='#{category1.id}']").click

    within("#deleteModal-category_#{category1.id}") do
      click_button "Delete"
    end
    expect(page).to have_content("Cannot delete category with associated tasks")
    expect(page).to have_content("Work")
  end
end
