class TrainingMaterialPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(:account).where(accounts: { id: user.account_id })
    end
  end
end
