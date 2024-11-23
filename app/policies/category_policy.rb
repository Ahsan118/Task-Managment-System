class CategoryPolicy < ApplicationPolicy
  def update?
    record.user == user
  end
  
  alias_method :destroy?, :update?
end
