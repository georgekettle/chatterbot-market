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
    respond_to do |format|
      if @correction.update(correction_params)
        flash[:notice] = 'Correction was successfully updated.'
        format.html { redirect_to edit_correction_path(@correction) }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def correction_params
    params.require(:correction).permit(:response)
  end
end
