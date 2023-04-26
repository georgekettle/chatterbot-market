class Dashboard::CsvFineTunesController < ApplicationController
  layout "dashboard_chatbot", only: [:index, :new, :create]

  # GET /dashboard/chatbots/:chatbot_id/csv_fine_tunes
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @csv_fine_tunes = pagy(
      policy_scope(CsvFineTune).where(chatbots: @chatbot).order(updated_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # GET /dashboard/chatbots/:chatbot_id/csv_fine_tunes/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @csv_fine_tune = CsvFineTune.new
    authorize @chatbot, policy_class: CsvFineTunePolicy

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # POST /dashboard/chatbots/:chatbot_id/csv_fine_tunes
  def create
    @chatbot = Chatbot.find(params[:chatbot_id])
    @csv_fine_tune = CsvFineTune.new(csv_fine_tune_params)
    authorize @chatbot, policy_class: CsvFineTunePolicy

    if @csv_fine_tune.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_csv_fine_tunes_path(@chatbot),
        notice: "CSV fine tune was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def csv_fine_tune_params
    params.require(:csv_fine_tune).permit(:name, :description, :csv_file)
  end
end
