class Chatbots::FavoritesController < ApplicationController
  before_action :set_chatbot, only: [:create, :destroy]

  # POST /chatbots/:chatbot_id/favorites
  def create
    current_user.favorite(@chatbot)
    redirect_back(fallback_location: chatbot_path(@chatbot))
  end

  # DELETE /chatbots/:chatbot_id/favorites
  def destroy
    current_user.unfavorite(@chatbot)
    redirect_back(fallback_location: chatbot_path(@chatbot))
  end

  private

  def set_chatbot
    @chatbot = Chatbot.find(params[:chatbot_id])
    authorize @chatbot, policy_class: Chatbot::FavoritePolicy
  end
end
