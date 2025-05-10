class PostPolicy < ApplicationPolicy
  def update?
    user && record.user == user
  end

  def edit?
    update?
  end
  
  def destroy?
    user && record.user == user
  end
end