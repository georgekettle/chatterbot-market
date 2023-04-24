class Messages::CorrectionsController < ApplicationController
  layout 'without_navbar', only: [:new, :create]
  before_action :set_message, only: [:new, :create]

  # GET /message/:message_id/corrections/new
  def new
    @conversation = @message.conversation
    @correction = Correction.new
    authorize @message.chatbot, policy_class: CorrectionPolicy
  end

  # POST /message/:message_id/corrections
  def create
    @conversation = @message.conversation
    @chatbot = @message.chatbot
    @correction = Correction.new(correction_params)
    @correction.message = @message
    @correction.prompt = @message.content
    authorize @chatbot, policy_class: CorrectionPolicy
    respond_to do |format|
      if @correction.save_and_connect_to_chatbot(@chatbot)
        flash[:notice] = 'Correction was successfully created'
        format.html { redirect_to edit_correction_path(@correction) }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def correction_params
    params.require(:correction).permit(:response)
  end

  def set_message
    @message = Message.find(params[:message_id])
  end
end
