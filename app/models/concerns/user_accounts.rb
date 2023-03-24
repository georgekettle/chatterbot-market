module UserAccounts
  extend ActiveSupport::Concern

  included do
    has_many :account_users, dependent: :destroy
    has_many :accounts, through: :account_users
    has_many :owned_accounts, class_name: "Account", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
    has_one :personal_account, -> { where(personal: true) }, class_name: "Account", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy

    # Regular users should get their account created immediately
    after_create :create_default_account, unless: :skip_default_account?

    accepts_nested_attributes_for :owned_accounts, reject_if: :all_blank

    # Used for skipping a default account on create
    attribute :skip_default_account, :boolean, default: false
  end

  def create_default_account
    # Invited users don't have a name immediately, so we will run this method twice for them
    # once on create where no name is present and again on accepting the invitation
    return unless name.present?
    return accounts.first if accounts.any?

    account = accounts.new(owner: self, name: name, personal: true)
    account.account_users.new(user: self, admin: true)
    debugger
    account.save!
    account
  end
end