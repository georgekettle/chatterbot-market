class CorrectionsController < ApplicationController
  layout 'without_navbar', only: [:edit, :update]

  # GET /corrections/:id/edit
  def edit
    @correction = Correction.find(params[:id])
    @message = @correction.message
    @conversation = @message.conversation
    @chatbot = @message.chatbot
    authorize @chatbot, policy_class: CorrectionPolicy
  end

  # PATCH/PUT /corrections/:id
  def update
    @correction = Correction.find(params[:id])
    @message = @correction.message
    @conversation = @message.conversation
    @chatbot = @message.chatbot
    authorize @chatbot, policy_class: CorrectionPolicy
    if @correction.update(correction_params)
      redirect_to edit_correction_path(@correction), notice: "Correction was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def correction_params
    params.require(:correction).permit(:response)
  end
end
