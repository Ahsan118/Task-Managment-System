class Task < ApplicationRecord
  include PgSearch::Model
  belongs_to :category
  belongs_to :user

  validates :title, :due_date, presence: true
  validates_comparison_of :due_date, greater_than_or_equal_to: -> { Date.today }, message: "must be greater than or equal to today"

  scope :with_user_and_category, -> { joins(:user, :category) }
  scope :for_user, ->(user) { where(user: user) }
  scope :by_category_id, ->(category_id) {where(category_id: category_id)}
  scope :by_status, ->(status) {where(status: status)}
  scope :by_date_range, ->(start_date,end_date) {where(due_date: start_date..end_date)}

  enum status: {
    pending: 0,
    in_progress: 1,
    completed: 2,
    incomplete: 3
  }
  pg_search_scope :search_by_keyword, against: :title, using: { tsearch: { prefix: true } }
end
