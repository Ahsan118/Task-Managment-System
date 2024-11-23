class TaskPolicy < ApplicationPolicy
  def edit?
    record.user == user
  end
  
  alias_method :update?, :edit?
  alias_method :destroy?, :edit?
  alias_method :show?, :edit?
  alias_method :mark_as_completed?, :edit?
end
