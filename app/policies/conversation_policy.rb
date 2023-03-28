class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Where account is owner of chatbot or account is owner of conversation
      scope.joins(:chatbot).where(chatbot: { account: account }).or(scope.where(account: account))
    end
  end

  def show?
    record.account == account || record.chatbot.account == account
  end
end
