class Dashboard::CorrectionsController < ApplicationController
  layout "dashboard_chatbot", only: [:index]

  # GET /dashboard/chatbots/:chatbot_id/corrections
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @corrections = pagy(
      policy_scope(Correction).where(chatbots: @chatbot).order(updated_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
