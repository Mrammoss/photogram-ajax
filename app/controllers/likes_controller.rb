class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]

  # POST /likes
  def create
  @photo = Photo.find(like_params[:photo_id])
  @like = @photo.likes.build(fan: current_user)

  respond_to do |format|
    if @like.save
      format.js   # triggers create.js.erb
      format.html { redirect_back fallback_location: @photo }  # fallback
    else
      format.js { render js: "alert('Could not like.');" }
      format.html { redirect_back fallback_location: @photo, alert: "Could not like." }
    end
  end
end

  # DELETE /likes/:id
  def destroy
    @photo = @like.photo
    @like.destroy

    respond_to do |format|
      format.js   # triggers destroy.js.erb
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:photo_id)
  end
end
