class Chatbot::FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.user.favorited_by_type('Chatbot')
    end
  end

  def create?
    true
  end

  def destroy?
    true
  end
end
