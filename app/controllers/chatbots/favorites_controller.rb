class Chatbots::FavoritesController < ApplicationController
  before_action :set_chatbot, only: [:create, :destroy]

  # GET /chatbots/favorites
  def index
    @pagy, @chatbots = pagy(
      policy_scope(Chatbot, policy_scope_class: Chatbot::FavoritePolicy::Scope)
    )
  end


  # POST /chatbots/:chatbot_id/favorites
  def create
    current_user.favorite(@chatbot)
    redirect_to chatbot_path(@chatbot), notice: "Chatbot was successfully favorited."
  end

  # DELETE /chatbots/:chatbot_id/favorites
  def destroy
    current_user.unfavorite(@chatbot)
    redirect_to chatbot_path(@chatbot), notice: "Chatbot was successfully unfavorited."
  end

  private

  def set_chatbot
    @chatbot = Chatbot.find(params[:chatbot_id])
    authorize @chatbot, policy_class: Chatbot::FavoritePolicy
  end
end
