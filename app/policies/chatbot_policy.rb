class ChatbotPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(account: user)
    end
  end

  def show?
    record.account == account || is_admin?
  end

  def update?
    record.account == account || is_admin?
  end

  def create?
    true
  end

  def destroy?
    record.account == account || is_admin?
  end
end
