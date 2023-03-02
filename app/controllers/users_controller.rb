class UsersController < ApplicationController
  def index

    if params[:search].present?
      @users = User.where("email LIKE ?", "#{params[:search]}%").where.not(id: current_user.id)
    else
      @users = User.where.not(id: current_user.id)
    end
  end

  def chat
    @user = User.find(params[:id])
    @messages = current_user.sent_messages.where(receiver_id: @user.id).or(current_user.received_messages.where(sender_id: @user.id)).order(created_at: :asc)
    @message = Message.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
