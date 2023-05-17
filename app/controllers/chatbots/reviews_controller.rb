class Chatbots::ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  skip_after_action :verify_policy_scoped, only: [:index]

  # GET /chatbots/1/reviews
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @reviews = pagy(@chatbot.reviews.order(created_at: :desc))
  end

  # GET /chatbots/1/reviews/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @review = Review.new
    authorize @chatbot, policy_class: Chatbot::ReviewPolicy
  end

  # POST /chatbots/1/reviews
  def create
    @chatbot = Chatbot.find(params[:chatbot_id])
    @review = @chatbot.reviews.new(review_params)
    @review.user = current_user
    @review.rating = params[:rating].to_i # Set rating to integer
    authorize @chatbot, policy_class: Chatbot::ReviewPolicy
    if @review.save
      redirect_to chatbot_path(@chatbot), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
