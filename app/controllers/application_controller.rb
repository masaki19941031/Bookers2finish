class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller? 
   
  def application
    @user = User.find(params[:id])
    @book = Book.new
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
end

