class CsvFineTunePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(chatbot: :account).where(accounts: { id: user.account_id })
    end
  end
end
