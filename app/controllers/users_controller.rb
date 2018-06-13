class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    if current_user != @user
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was sucessfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "user was failed to update"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
