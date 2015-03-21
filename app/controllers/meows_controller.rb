class MeowsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    meow = current_user.meows.build(post: post)

    respond_to do |format|
      if meow.save
        format.html { redirect_to :back, notice: "We heard your Meow!" }
        format.json { render json: meow }
      else
        format.html { redirect_to :back }
        format.json { render json: meow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.meows.destroy(params[:id])
    respond_to do |format|
      # Respond the same way we were before if the request format is html
      format.html do
        flash[:notice] = "All evidence of your meowing has been destroyed!"
        redirect_to :back
      end
      # Respond with a "204 no content" to signify that the request has been
      # Fullfilled
      format.json { head :no_content }
    end
  end
end
