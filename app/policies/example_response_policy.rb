class ExampleResponsePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    # Chatbot is the record
    record.account.account_users.include?(user)
  end
end
