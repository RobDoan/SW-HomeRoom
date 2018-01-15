class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/search'
    end
  end

  def register
    @user = User.new(role: params[:role])
    render 'register'
  end

  alias_method :teacher, :register
  alias_method :parent_register, :register


  private
  def user_params
    params.require(:user).permit(:age, :emotional_problem, :symptom, :other_info, :role)
  end
end
