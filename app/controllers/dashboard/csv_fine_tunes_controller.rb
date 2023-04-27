require 'open-uri'

class Dashboard::CsvFineTunesController < ApplicationController
  layout "dashboard_chatbot", only: [:index, :show, :new, :create, :edit, :update]

  # GET /dashboard/chatbots/:chatbot_id/csv_fine_tunes
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @csv_fine_tunes = pagy(
      policy_scope(CsvFineTune).where(chatbots: @chatbot).order(updated_at: :desc)
    )
    set_breadcrumbs
  end

  # GET /csv_fine_tunes/:id
  def show
    @csv_fine_tune = CsvFineTune.find(params[:id])
    @chatbot = @csv_fine_tune.chatbot
    csv_file = URI.open(@csv_fine_tune.csv_file.url, 'r')
    @csv_file = SmarterCSV.process(csv_file)
    authorize @csv_fine_tune
    set_breadcrumbs
  end

  # GET /dashboard/chatbots/:chatbot_id/csv_fine_tunes/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @csv_fine_tune = CsvFineTune.new
    authorize @chatbot, policy_class: CsvFineTunePolicy
    set_breadcrumbs
  end

  # POST /dashboard/chatbots/:chatbot_id/csv_fine_tunes
  def create
    @chatbot = Chatbot.find(params[:chatbot_id])
    @csv_fine_tune = CsvFineTune.new(csv_fine_tune_params)
    authorize @chatbot, policy_class: CsvFineTunePolicy
    set_breadcrumbs

    if @csv_fine_tune.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_csv_fine_tunes_path(@chatbot),
        notice: "CSV fine tune was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /csv_fine_tunes/:id/edit
  def edit
    @csv_fine_tune = CsvFineTune.find(params[:id])
    @chatbot = @csv_fine_tune.chatbot
    authorize @csv_fine_tune
    set_breadcrumbs
  end

  # PATCH/PUT /csv_fine_tunes/:id
  def update
    @csv_fine_tune = CsvFineTune.find(params[:id])
    @chatbot = @csv_fine_tune.chatbot
    authorize @csv_fine_tune
    set_breadcrumbs
    if @csv_fine_tune.update(csv_fine_tune_params)
      redirect_to csv_fine_tune_path(@csv_fine_tune), notice: "CSV fine tune was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /csv_fine_tunes/:id
  def destroy
    @csv_fine_tune = CsvFineTune.find(params[:id])
    @chatbot = @csv_fine_tune.chatbot
    authorize @csv_fine_tune
    @csv_fine_tune.destroy
    respond_to do |format|
      flash[:notice] = "CSV Upload was successfully deleted"
      format.html { redirect_to dashboard_chatbot_csv_fine_tunes_path(@chatbot) }
      format.turbo_stream
    end
  end

  private

  def csv_fine_tune_params
    params.require(:csv_fine_tune).permit(:description, :csv_file)
  end

  def set_breadcrumbs
    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
