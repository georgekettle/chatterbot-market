class Dashboard::FeedbackController < ApplicationController
  # GET /dashboard/chatbots/:chatbot_id/feedback
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    # @feedback_list = @chatbot.feedback.order(created_at: :desc)
    @pagy, @feedback_list = pagy(
      policy_scope(Feedback).where(chatbots: @chatbot).order(created_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
