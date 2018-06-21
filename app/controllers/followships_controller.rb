class FollowshipsController < ApplicationController
  def create
    # @followship = Followship.new
    # @followship.following_id = params[:following_id]
    # @followship.user_id = current_user.id
    # puts "[Debug] current user is #{@followship.user_id} / followed user is #{@followship.following_id}"
    # if @followship.save
    #   flash[:notice] = "user was successfully followed"
    # else
    #   flash[:alert] = "users cannot be followed twice"
    # end
    # redirect_to users_path

    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy

  end

end
