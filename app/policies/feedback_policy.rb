class FeedbackPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(:chatbot).where(chatbots: account.chatbots)
    end
  end

  def create?
    record.message.chat.creator == user.user
  end

  def update?
    record.message.chat.creator == user.user
  end

  def toggle_marked_read_at?
    record.chatbot.account == account
  end
end
