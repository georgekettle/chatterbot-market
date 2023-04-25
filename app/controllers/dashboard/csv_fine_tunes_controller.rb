class Dashboard::CsvFineTunesController < ApplicationController
  layout "dashboard_chatbot", only: [:index]

  # GET /dashboard/chatbots/:chatbot_id/csv_fine_tunes
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @csv_fine_tunes = pagy(
      policy_scope(CsvFineTune).where(chatbots: @chatbot).order(updated_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
