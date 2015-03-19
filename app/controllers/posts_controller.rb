class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: "Post created successfully."
    else
      flash.now[:notice] = "There were some errors with your post."
      render :new
    end
  end

  def new
    @post = Post.new
  end

  protected

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
