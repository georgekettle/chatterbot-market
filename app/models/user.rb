class User < ApplicationRecord
  include UserAccounts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  has_many :connected_accounts, as: :owner, dependent: :destroy

  validates :name, presence: true
end
