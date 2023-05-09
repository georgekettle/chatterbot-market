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
        format.html { redirect_to @message.chat, notice: "Thank you for your feedback" }
        format.turbo_stream
      else
        format.html { redirect_to @message.chat, alert: "Something went wrong when creating your feedback" }
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
        format.html { redirect_to @feedback.message.chat, notice: "Feedback was successfully updated" }
        format.turbo_stream
      else
        format.html { redirect_to @feedback.message.chat, notice: "Something went wrong when creating your feedback" }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /feedback/1/toggle_marked_read_at
  def toggle_marked_read_at
    @feedback = Feedback.find(params[:id])
    authorize @feedback
    @chatbot = @feedback.chatbot
    @feedback.marked_read_at = @feedback.marked_read_at.present? ? nil : DateTime.now
    respond_to do |format|
      if @feedback.save
        if @feedback.marked_read_at.present?
          format.html { redirect_to dashboard_chatbot_feedback_index_path(@chatbot), notice: "Feedback marked as read" }
        else
          format.html { redirect_to dashboard_chatbot_feedback_index_path(@chatbot, marked_read: true), notice: "Feedback marked as unread" }
        end
      else
        format.html { redirect_to dashboard_chatbot_feedback_index_path(@chatbot), alert: "Something went wrong updating feedback" }
      end
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating, :content)
  end
end
