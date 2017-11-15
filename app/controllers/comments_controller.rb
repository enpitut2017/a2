class CommentsController < ApplicationController



  def create
    @comment = Comment.new(comment_body: params[:comment_body], item_id: params[:item_id])

    respond_to do |format|
      if @comment.save
        format.html { render :create, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def comment_params
      params.require(:comment).permit( :item_id, :comment_body)
  end



  def new
  end
end
