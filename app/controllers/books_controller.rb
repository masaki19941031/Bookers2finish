class BooksController < ApplicationController
  
  def index
    
    if current_user.nil?
    redirect_to user_session_path
    end
    
    @user = current_user
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      
    if current_user.nil?
    redirect_to user_session_path
    end
    
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render "books/index"
    end
    
  end
  
  
  def show
    
    if current_user.nil?
    redirect_to user_session_path
    end
    
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end
  
  def edit
    
   @book = Book.find(params[:id])
    
   if current_user.nil?
     redirect_to user_session_path
     
   elsif @book.user != current_user
     redirect_to books_path
     
   end
    
  end
  
  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params 
    params.require(:book).permit(:title, :body) 
  end
 
end