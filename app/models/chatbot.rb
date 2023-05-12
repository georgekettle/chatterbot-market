class Chatbot < ApplicationRecord
  include PgSearch::Model
  acts_as_favoritable
  
  # Write a search functionality with pg_search gem to search by name and description and message content
  pg_search_scope :search_by_chatbot_and_messages,
    against: [ :name, :description, :system_prompt ],
    associated_against: {
      messages: [ :content ],
      account: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  STATUS_DESCRIPTIONS = {
    draft: "Your chatbot will be accessible only to you",
    published: "Your chatbot will be accessible to anyone with the link",
    marketplace: "Your chatbot will be published on the marketplace and accessible to anyone"
  }

  belongs_to :account
  belongs_to :base_model
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats
  has_many :feedback, through: :messages
  has_many :reviews, as: :reviewable, dependent: :destroy
  
  has_one_attached :avatar

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }

  before_validation :ensure_base_model
  before_save :update_default_flag

  enum status: { draft: 0, published: 1, marketplace: 2 }
  
  def avg_rating
    reviews.average(:rating).to_f.round(1)
  end

  def self.default
    Chatbot.find_by(default: true)
  end
  
  private
  
  def ensure_base_model
    self.base_model ||= BaseModel.first
  end

  def validate_single_default_chatbot
    if default? && Chatbot.where(default: true).where.not(id: id).exists?
      errors.add(:default, "Only one chatbot can be set as default")
    end
  end

  def update_default_flag
    if default_changed? && default?
      Chatbot.where.not(id: id).update_all(default: false)
    end
  end
end
