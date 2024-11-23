require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:task) { create(:task, user: user, category: category) }
  describe "validations" do
    it "is valid with valid attributes" do
      expect(task).to be_valid
    end

    it "is invalid without a title" do
      task.title = nil
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a due date" do
      task.due_date = nil
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("can't be blank")
    end

    it "is invalid with a past due date" do
      task.due_date = 1.day.ago
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("must be greater than or equal to today")
    end

    it "is invalid with an invalid status" do
      expect { task.status = "invalid_status" }.to raise_error(ArgumentError)
    end
  end

  describe "scopes" do
    let!(:task1) { create(:task, user: user, category: category, due_date: 1.day.from_now, status: :pending) }
    let!(:task2) { create(:task, user: user, category: category, due_date: 5.days.from_now, status: :completed) }
    let!(:other_user_task) { create(:task, user: create(:user), category: category) }

    it "filters tasks by status" do
      expect(Task.by_status(:pending)).to include(task1)
      expect(Task.by_status(:pending)).not_to include(task2)
    end

    it "filters tasks by due date range" do
      start_date = Date.today
      end_date = 3.days.from_now
      tasks = Task.by_date_range(start_date, end_date)

      expect(tasks).to include(task1)
      expect(tasks).not_to include(task2)
    end

    it "filters tasks by category" do
      expect(Task.by_category_id(category.id)).to include(task1, task2)
    end

    it "filters tasks by user" do
      expect(Task.for_user(user)).to include(task1, task2)
      expect(Task.for_user(user)).not_to include(other_user_task)
    end
  end

  describe "pg_search_scope" do
    before do
      create(:task, title: "Shopping groceries", user: user, category: category)
      create(:task, title: "Complete work project", user: user, category: category)
    end

    it "searches tasks by keyword" do
      results = Task.search_by_keyword("Shopping")
      expect(results.count).to eq(1)
      expect(results.first.title).to eq("Shopping groceries")
    end
  end
end
