class ExampleResponsesController < ApplicationController
  layout 'without_navbar', only: [:new, :create]

  # GET /chatbots/:chatbot_id/example_responses/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @example_response = ExampleResponse.new
    authorize @chatbot, policy_class: ExampleResponsePolicy
  end

  # POST /chatbots/:chatbot_id/example_responses
  def create
    @chatbot = Chatbot.find(params[:chatbot_id])
    @example_response = ExampleResponse.new(example_response_params)
    authorize @chatbot, policy_class: ExampleResponsePolicy
    if @example_response.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /example_responses/:id/edit
  def edit
    @example_response = ExampleResponse.find(params[:id])
    @chatbot = @example_response.chatbot
    authorize @chatbot, policy_class: ExampleResponsePolicy
  end

  # PATCH/PUT /example_responses/:id
  def update
    @example_response = ExampleResponse.find(params[:id])
    @chatbot = @example_response.chatbot
    authorize @example_response.chatbot, policy_class: ExampleResponsePolicy
    if @example_response.update(example_response_params)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /example_responses/:id
  def destroy
    @example_response = ExampleResponse.find(params[:id])
    @chatbot = @example_response.chatbot
    authorize @example_response.chatbot, policy_class: ExampleResponsePolicy
    @example_response.destroy
    redirect_back fallback_location: dashboard_chatbot_training_materials_path(@chatbot), notice: 'Example response was successfully destroyed'
  end

  private

  # Only allow a list of trusted parameters through.
  def example_response_params
    params.require(:example_response).permit(:prompt, :response)
  end
end
