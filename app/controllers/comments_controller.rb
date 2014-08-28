class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @recents = Article.recent(10)
    @post = Article.friendly.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save 
        format.html { redirect_to post_path(@post), notice: 'Comments was successfully created.' }
        format.json { render :show, status: :created, location: post_path(@post) }
      else
        format.html { render 'posts/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) , notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :email, :website, :body)
    end
end
