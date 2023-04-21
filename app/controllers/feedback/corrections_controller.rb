class Feedback::CorrectionsController < ApplicationController
  layout 'without_navbar', only: [:new, :create]

  # GET /feedback/:feedback_id/corrections/new
  def new
    @feedback = Feedback.find(params[:feedback_id])
    @conversation = @feedback.conversation
    @correction = Correction.new
    authorize @feedback.chatbot, policy_class: CorrectionPolicy
  end

  # POST /feedback/:feedback_id/corrections
  def create
    @feedback = Feedback.find(params[:feedback_id])
    @conversation = @feedback.conversation
    @chatbot = @feedback.chatbot
    @correction = Correction.new(correction_params)
    @correction.message = @feedback.message
    @correction.prompt = @feedback.message.content
    authorize @chatbot, policy_class: CorrectionPolicy
    if @correction.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: "Correction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def correction_params
    params.require(:correction).permit(:response)
  end
end
