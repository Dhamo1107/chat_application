class UsersController < ApplicationController
  def index
    if params[:search].present?
      @users = User.where("email LIKE ?", "#{params[:search]}%").where.not(id: current_user.id).order(:email)
    else
      @users = User.where.not(id: current_user.id).order(:email)
    end
    @users = @users.paginate(page: params[:page], per_page: 8)
  end

  def chat
    @user = User.find(params[:id])
    @messages = current_user.sent_messages
                            .where(receiver_id: @user.id)
                            .or(current_user.received_messages.where(sender_id: @user.id))
                            .includes(:sender)
                            .order(created_at: :asc)
    @message = Message.new
  end
end
