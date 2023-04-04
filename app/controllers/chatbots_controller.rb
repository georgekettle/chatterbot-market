class ChatbotsController < ApplicationController
  before_action :set_chatbot, only: %i[ show edit update destroy ]

  # GET /chatbots
  def index
    @chatbots = policy_scope(Chatbot).where(account: current_account)
  end

  # GET /chatbots/1
  def show
    @conversations = @chatbot.conversations.where("created_at > ?", 7.days.ago).order(created_at: :desc).first(5)

    breadcrumb "Marketplace", chatbots_path
    breadcrumb @chatbot.name, request.path
  end

  # GET /chatbots/new
  def new
    @chatbot = Chatbot.new
    authorize @chatbot
  end

  # POST /chatbots
  def create
    @chatbot = Chatbot.new(chatbot_params)
    @chatbot.account = Current.account
    authorize @chatbot

    respond_to do |format|
      if @chatbot.save
        format.html { redirect_to dashboard_chatbot_url(@chatbot), notice: "Chatbot was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatbots/1
  def update
    respond_to do |format|
      if @chatbot.update(chatbot_params)
        format.html { redirect_back fallback_location: dashboard_chatbot_url(@chatbot), notice: "Chatbot was successfully updated." }
      else
        format.html { render :settings, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatbots/1
  def destroy
    @chatbot.destroy

    respond_to do |format|
      format.html { redirect_to chatbots_url, notice: "Chatbot was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatbot
      @chatbot = Chatbot.find(params[:id])
      authorize @chatbot
    end

    # Only allow a list of trusted parameters through.
    def chatbot_params
      params.require(:chatbot).permit(:name)
    end
end
