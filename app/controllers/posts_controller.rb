class PostsController < ApplicationController
  http_basic_authenticate_with name: "a", password: "#123", except: [:index, :show,:updateLike]

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.likes = 1

    if @post.save
    redirect_to @post
    else
    render :new, status: :unprocessable_entity
    end
  end

  def updateLike
    @post = Post.find(params[:id])
    if @post.likes != nil
      @post.likes = @post.likes + 1
    else
      @post.likes = 1
    end

    @post.save

    redirect_to action: "index"
    # render :index
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to action: "show"
    # redirect_to root_path, status: :see_other
  end

  def show
    @post = Post.find(params[:id])

  end

  private
    def post_params
        params.require(:post).permit(:title, :body,:author)
    end
end
