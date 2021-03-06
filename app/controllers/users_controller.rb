class UsersController < ApplicationController
  before_action :check_if_logged_out, only: [:new, :create]
  before_action :check_if_logged_in, only: [:index]

  def index
    @users = User.all.order('balance DESC')
  end

  # GET /users/new
  # GET /register
  def new
    @user = User.new
    @user.is_admin = false

    if params[:name] != nil
      @user.username = params[:name]
    end

    if params[:gender] != nil
      @user.gender = params[:gender]
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.is_admin = false
    @user.username.downcase!
    @user.email.downcase!

    if @user.save
      redirect_to login_path, notice: 'Successfully registered. You can log in now.'
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :gender, :college)
    end
end
