class CsvFineTunePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(chatbot: :account).where(accounts: { id: user.account_id })
    end
  end

  def create?
    # record is chatbot and user must be a member of chatbot's account
    record.account == account
  end

  def destroy?
    # record is csv_fine_tune and user must be a member of csv_fine_tune's account
    record.account == account
  end
end
