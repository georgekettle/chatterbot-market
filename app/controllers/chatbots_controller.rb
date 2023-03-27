class ChatbotsController < ApplicationController
  before_action :set_chatbot, only: %i[ show edit update destroy ]

  # GET /chatbots or /chatbots.json
  def index
    @chatbots = Chatbot.where(account: Current.account)
  end

  # GET /chatbots/1 or /chatbots/1.json
  def show
  end

  # GET /chatbots/new
  def new
    @chatbot = Chatbot.new
  end

  # GET /chatbots/1/edit
  def edit
  end

  # POST /chatbots or /chatbots.json
  def create
    @chatbot = Chatbot.new(chatbot_params)
    @chatbot.account = Current.account

    respond_to do |format|
      if @chatbot.save
        format.html { redirect_to chatbot_url(@chatbot), notice: "Chatbot was successfully created." }
        format.json { render :show, status: :created, location: @chatbot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chatbot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatbots/1 or /chatbots/1.json
  def update
    respond_to do |format|
      if @chatbot.update(chatbot_params)
        format.html { redirect_to chatbot_url(@chatbot), notice: "Chatbot was successfully updated." }
        format.json { render :show, status: :ok, location: @chatbot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatbot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatbots/1 or /chatbots/1.json
  def destroy
    @chatbot.destroy

    respond_to do |format|
      format.html { redirect_to chatbots_url, notice: "Chatbot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatbot
      @chatbot = Chatbot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chatbot_params
      params.require(:chatbot).permit(:name)
    end
end
