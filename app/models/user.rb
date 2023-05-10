class User < ApplicationRecord
  include UserAccounts
  acts_as_favoritor

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  has_many :connected_accounts, class_name: "Account", foreign_key: "owner_id", dependent: :destroy
  has_many :chats, class_name: "Chat", foreign_key: "creator_id",dependent: :destroy
  has_many :messages, through: :chats

  validates :name, presence: true
end
