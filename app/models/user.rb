class User < ApplicationRecord
  include UserAccounts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  has_many :connected_accounts, class_name: "Account", foreign_key: "owner_id", dependent: :destroy
  has_many :conversations, class_name: "Conversation", foreign_key: "creator_id",dependent: :destroy
  has_many :messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy

  validates :name, presence: true
end
