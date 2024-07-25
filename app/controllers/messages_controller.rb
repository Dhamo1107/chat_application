class MessagesController < ApplicationController
  def create
    @message = current_user.sent_messages.build(message_params)
    @user = User.find(params[:message][:receiver_id])
    @messages = current_user.sent_messages
                            .where(receiver_id: @user.id)
                            .or(current_user.received_messages.where(sender_id: @user.id))
                            .includes(:sender)
                            .order(created_at: :asc)
    if @message.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render 'update_chat', status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :content)
  end
end
