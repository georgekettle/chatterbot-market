class Dashboard::TrainingMaterialsController < ApplicationController
  layout 'dashboard'

  # GET /dashboard/chatbots/:chatbot_id/training_materials
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @training_materials = pagy(
      policy_scope(TrainingMaterial).where(chatbot: @chatbot).order(created_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
