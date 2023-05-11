class Chatbots::ReviewsController < ApplicationController
  # GET /chatbots/1/reviews
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @reviews = pagy(policy_scope(@chatbot.reviews, policy_scope_class: Chatbot::ReviewPolicy::Scope).order(created_at: :desc))
    authorize @chatbot, :show?
  end
end
