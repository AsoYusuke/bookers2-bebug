class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @book }
        format.js { render :index }
      else
        format.html { redirect_to @book }
      end
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    respond_to do |format|
      if BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
        format.html { redirect_to @book }
        format.js { render :index }
      else
        format.html { redirect_to @book }
      end
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
