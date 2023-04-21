class Dashboard::FeedbackController < ApplicationController
  layout "dashboard_chatbot", only: %i[index]

  # GET /dashboard/chatbots/:chatbot_id/feedback
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    if params[:marked_read] == "true"
      @pagy, @feedback_list = pagy(
        policy_scope(Feedback).where(chatbots: @chatbot).where.not(marked_read_at: nil).order(created_at: :desc)
      )
    else
      @pagy, @feedback_list = pagy(
        policy_scope(Feedback).where(chatbots: @chatbot, marked_read_at: nil).order(created_at: :desc)
      )
    end

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
