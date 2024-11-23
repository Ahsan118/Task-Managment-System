require 'rails_helper'

RSpec.feature "Task Management", type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:task) { create(:task, user: user, category: category, status: 'pending') }

  before do
    login_as(user)
  end

  scenario "User creates a new task" do
    visit new_task_path

    select category.name, from: 'Category'
    fill_in 'Name*', with: 'New Task'
    select 'Pending', from: 'Status'
    fill_in 'Due Date*', with: '2024-12-31'
    fill_in 'Description', with: 'This is a new task description.'
    click_button 'Save'

    expect(page).to have_content("Task created successfully")
    expect(page).to have_content("New Task")
    expect(page).to have_content("Pending")
  end

  scenario "User updates an existing task" do
    visit edit_task_path(task)

    fill_in 'Name*', with: 'Updated Task Title'
    select 'Completed', from: 'Status'
    fill_in 'Due Date*', with: '2024-12-25'
    fill_in 'Description', with: 'Updated task description.'

    click_button 'Save'
    expect(page).to have_content("Task updated successfully")
    expect(page).to have_content("Updated Task Title")
    expect(page).to have_content("Completed")
  end

  scenario "User cannot create task without required fields" do
    visit new_task_path

    click_button 'Save'
    expect(page).to have_content("Title can't be blank")
  end

  scenario "User deletes a task" do
    visit tasks_path

    find("button[id='action-#{task.id}']").click
    find("button[data-id='#{task.id}']").click
    within("#deleteModal-task_#{task.id}") do
      click_button "Delete"
    end
    expect(page).to have_content("Task deleted successfully")
    expect(page).not_to have_content(task.title)
  end

  scenario "User marks a task as completed" do
    visit tasks_path
    within("tr", text: task.title) do
      click_button "Mark as Completed"
    end
    expect(page).to have_content("Completed")
  end
end
