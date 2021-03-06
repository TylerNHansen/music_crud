class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # GET /login
  def login
    @user = User.new
  end

  # POST /login
  def do_login
    @user = User.authenticate(user_params)
    if @user
      login!(@user)
      redirect_to root_url
    else
      flash[:errors] = 'incorrect username or password'
      redirect_to root_url
    end

  end

  def logout
    super
    redirect_to root_url
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.make_session_token!

    respond_to do |format|
      if @user.save
        login!(@user)
        UserMailer.activate_email(@user).deliver!
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def verify
    User.activate(params[:activate_token])
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.from_session(session[:session_token])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
