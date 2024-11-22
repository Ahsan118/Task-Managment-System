class Category < ApplicationRecord
  include PgSearch::Model
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  pg_search_scope :search_by_keyword, against: :name, using: { tsearch: { prefix: true } }
end
