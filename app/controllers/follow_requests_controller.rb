class FollowRequestsController < ApplicationController
  before_action :set_follow_request, only: %i[ update destroy ]

  # POST /follow_requests or /follow_requests.json
  def create
    @follow_request = current_user.sent_follow_requests.build(follow_request_params)

    respond_to do |format|
      if @follow_request.save
        format.html { redirect_back fallback_location: root_url, notice: "Follow request created." }
        format.json { render :show, status: :created }
        format.js
      else
        format.html { redirect_back fallback_location: root_url, alert: "Error creating follow request." }
        format.json { render json: @follow_request.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /follow_requests/1 or /follow_requests/1.json
  def update
    respond_to do |format|
      if @follow_request.update(follow_request_params)
        format.html { redirect_back fallback_location: root_url, notice: "Follow request was successfully updated." }
        format.json { render :show, status: :ok, location: @follow_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @follow_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follow_requests/1 or /follow_requests/1.json
  def destroy
    recipient = @follow_request.recipient
    @follow_request.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Follow request destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_follow_request
    @follow_request = FollowRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def follow_request_params
    params.require(:follow_request).permit(:recipient_id, :status)
  end
end
