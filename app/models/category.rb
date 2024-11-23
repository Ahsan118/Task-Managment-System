class Category < ApplicationRecord
  include PgSearch::Model
  has_many :tasks
  belongs_to :user
  
  scope :with_user, -> { joins(:user) }
  scope :for_user, ->(user) { where(user: user) }

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "has already been taken for this user" }
  pg_search_scope :search_by_keyword, against: :name, using: { tsearch: { prefix: true } }
end
