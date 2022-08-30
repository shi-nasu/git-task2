class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])  
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  #updateが成功した時
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully update.'
      redirect_to book_path(@book.id)
  #失敗した時
    else
      render :edit
    end
  end
  
  #削除機能
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:danger] = "Book was successfully destroyed."
    redirect_to '/books'
  end
  
  #createが成功した時
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Book was successfully created.'
      redirect_to book_path(@book.id)
  #失敗した時
    else
      @books = Book.all
      render :index
    end
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
