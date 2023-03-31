class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def account_settings?
    record == account
  end

  def update?
    record == account
  end
end
