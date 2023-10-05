class TravellersController < ApplicationController

  before_action :set_user, only: %i[ show edit update destroy ]
  def index
    @users = User.all.reject {|user| user.id ==1}

  end

  def show
  end


  def new
    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to traveller_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to traveller_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if current_user.id !=1
      @user.destroy!
      redirect_to destroy_user_session_path
    else
      @user.destroy!
      respond_to do |format|
        format.html { redirect_to travellers_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :password, :email, :phone_number, :address, :credit_card_info)
  end

end
