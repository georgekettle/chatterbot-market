class FeedbackPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(:chatbot).where(chatbots: account.chatbots)
    end
  end

  def create?
    record.message.conversation.creator == user.user
  end

  def update?
    record.message.conversation.creator == user.user
  end
end
