class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Where account is owner of chatbot or account is owner of conversation
      scope.joins(:chatbot).where(chatbot: { account: account }).or(scope.where(creator: user.user))
    end
  end

  def show?
    record.creator == user.user || record.chatbot.account == account
  end

  def create?
    # Change this when subscriptions are implemented
    true
  end
end
