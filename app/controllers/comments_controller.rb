class CommentsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "#123", only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
