class ChatbotsController < ApplicationController
  layout 'dashboard_chatbot', only: [:update]
  before_action :set_chatbot, only: %i[ edit update destroy ]
  skip_before_action :authenticate_user!, only: [:show, :trending, :search]
  skip_after_action :verify_authorized, only: [:show, :trending, :search]
  after_action :verify_policy_scoped, only: [:trending, :search]

  # GET /chatbots
  def index
    @chatbots = policy_scope(Chatbot).where(status: :marketplace)
  end

  # GET /chatbots/1
  def show
    @chatbot = Chatbot.find(params[:id])
    @reviews = @chatbot.reviews.order(created_at: :desc).first(5)
  end

  # GET /chatbots/new
  def new
    @chatbot = Chatbot.new
    authorize @chatbot

    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb "New Chatbot", request.path
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
    params[:chatbot][:status] = params[:chatbot][:status].to_i if params[:chatbot][:status]
    respond_to do |format|
      p chatbot_params
      if @chatbot.update(chatbot_params)
        format.html { redirect_back fallback_location: dashboard_chatbot_url(@chatbot), notice: "Chatbot was successfully updated." }
      else
        format.html { render 'dashboard/chatbots/settings', status: :unprocessable_entity }
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
  

  def trending
    # chatbots with most chats in the last 7 days
    @pagy, @chatbots = pagy(
      policy_scope(Chatbot)
        .joins(:chats)
        .where("chats.created_at > ?", 7.days.ago)
        .group(:id)
        .order("COUNT(chats.id) DESC")
    )
  end

  def search
    @query = params[:query] || ""
    @pagy, @chatbots = pagy(
      policy_scope(Chatbot).search_by_chatbot_and_messages(@query)
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatbot
      @chatbot = Chatbot.find(params[:id])
      authorize @chatbot
    end

    # Only allow a list of trusted parameters through.
    def chatbot_params
      params.require(:chatbot).permit(:name, :status, :description, :system_prompt, :avatar, :base_model_id)
    end
end
