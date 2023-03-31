class FeedbackController < ApplicationController
  # POST /messages/:message_id/feedback
  def create
    @message = Message.find(params[:message_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.message = @message
    @feedback.user = current_user
    authorize @feedback

    # respond to the request as html and turbostreams
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @message.conversation, notice: "Thank you for your feedback" }
        format.turbo_stream
      else
        format.html { redirect_to @message.conversation, alert: "Something went wrong when creating your feedback" }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /feedback/1
  def update
    @feedback = Feedback.find(params[:id])
    authorize @feedback
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback.message.conversation, notice: "Feedback was successfully updated" }
        format.turbo_stream
      else
        format.html { redirect_to @feedback.message.conversation, notice: "Something went wrong when creating your feedback" }
        format.turbo_stream
      end
    end
  end


  private

  def feedback_params
    params.require(:feedback).permit(:rating, :content)
  end
end
