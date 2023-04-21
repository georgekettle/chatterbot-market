class CorrectionsController < ApplicationController
  layout 'without_navbar', only: [:new, :create]

  # GET /chatbots/:chatbot_id/corrections/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @correction = Correction.new
    authorize @chatbot, policy_class: CorrectionPolicy
  end

  # POST /chatbots/:chatbot_id/corrections
  def create
    @chatbot = Chatbot.find(params[:chatbot_id])
    @correction = Correction.new(correction_params)
    authorize @chatbot, policy_class: CorrectionPolicy
    if @correction.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /corrections/:id/edit
  def edit
    @correction = Correction.find(params[:id])
    @chatbot = @correction.chatbot
    authorize @chatbot, policy_class: CorrectionPolicy
  end

  # PATCH/PUT /corrections/:id
  def update
    @correction = Correction.find(params[:id])
    @chatbot = @correction.chatbot
    authorize @correction.chatbot, policy_class: CorrectionPolicy
    if @correction.update(correction_params)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /corrections/:id
  def destroy
    @correction = Correction.find(params[:id])
    @chatbot = @correction.chatbot
    authorize @correction.chatbot, policy_class: CorrectionPolicy
    @correction.destroy
    redirect_back fallback_location: dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully destroyed'
  end

  private

  # Only allow a list of trusted parameters through.
  def correction_params
    params.require(:correction).permit(:prompt, :response)
  end
end
