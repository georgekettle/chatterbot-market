class Feedback::ExampleResponsesController < ApplicationController
  layout 'without_navbar', only: [:new, :create]

  # GET /feedback/:feedback_id/example_responses/new
  def new
    @feedback = Feedback.find(params[:feedback_id])
    @conversation = @feedback.conversation
    @example_response = ExampleResponse.new
    authorize @feedback.chatbot, policy_class: ExampleResponsePolicy
  end

  # POST /feedback/:feedback_id/example_responses
  def create
    @feedback = Feedback.find(params[:feedback_id])
    @conversation = @feedback.conversation
    @chatbot = @feedback.chatbot
    @example_response = ExampleResponse.new(example_response_params)
    @example_response.message = @feedback.message
    @example_response.prompt = @feedback.message.content
    authorize @chatbot, policy_class: ExampleResponsePolicy
    if @example_response.save_and_connect_to_chatbot(@chatbot)
      redirect_to dashboard_chatbot_training_materials_path(@chatbot), notice: "Correction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def example_response_params
    params.require(:example_response).permit(:response)
  end
end
