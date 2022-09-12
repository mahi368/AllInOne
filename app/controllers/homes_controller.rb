class HomesController < ApplicationController
  def index
    # byebug
    if current_user.has_role? :admin
      @user = User.all 
      @category = Category.all    
    end 
    @category = Category.all
  end
end
