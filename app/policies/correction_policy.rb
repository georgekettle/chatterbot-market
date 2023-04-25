class CorrectionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(chatbot: :account).where(accounts: { id: user.account_id })
    end
  end

  def create?
    member_of_chatbot_account?
  end

  def update?
    member_of_chatbot_account?
  end

  def destroy?
    member_of_chatbot_account?
  end

  private

  def member_of_chatbot_account?
    # Chatbot is the record **
    record.account.account_users.include?(user)
  end
end
