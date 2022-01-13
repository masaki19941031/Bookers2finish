class UsersController < ApplicationController

  def index
    
    if current_user.nil?
    redirect_to user_session_path
    end
   
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  
  def show
    
    if current_user.nil?
    redirect_to user_session_path
    end
  
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end
  
  def edit
    
    @user = User.find(params[:id])
    if current_user.nil?
      redirect_to user_session_path
      
    elsif @user != current_user
     redirect_to user_path(current_user)
     
    end
    
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
    flash[:success] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render  :edit
    end
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def book_params 
    params.permit(:title, :body, :user_id) 
  end
  
end
