class Chatbot::ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    # record is chatbot. As long as user has chats with chatbot, they can create a review
    user.user.chats.where(chatbot: record).any?
  end
end
