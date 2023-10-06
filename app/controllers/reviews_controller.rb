class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all

    if params[:filter_applied]
      user_name = params[:user_name]
      train_number = params[:train_number]
      unless user_name.blank?
        user = User.where("name COLLATE NOCASE = ?", user_name)
        if user
          user_ids = user.pluck(:id)
          @reviews = @reviews.where(user_id: user_ids)
        end
        # @reviews = @reviews.where("user_id in :user_ids", user_ids: users.id)
      end
      unless train_number.blank?
        train = Train.find_by(train_number: train_number)
        if train
          @reviews = @reviews.where(:train_id => train.id)
        end
      end
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    # @trains_list = Train.all.map {|train| train.train_number}.uniq
    tickets = Ticket.where("user_id = :userId",userId: current_user.id)
    train_ids = tickets.pluck(:train_id)
    @trains_list = Train.where(id: train_ids).pluck(:train_number)
    print('DEBUG BEINGS:::::::::::::::::::::',@trains_list)
    #@user = User.find(params[:user_id])
    #@train = Train.find(params[:train_id])
    @review = Review.new
    #@review = @train.reviews.build
    @review.user_id = current_user.id

  end

  # GET /reviews/1/edit
  def edit
    @trains_list = Train.all.map {|train| train.train_number}.uniq
    print('DEBUG BEINGS:::::::::::::::::::::',@trains_list)
    @train = @review.train_id
    @user = @review.user_id
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.train_id = Train.find_by(train_number: params[:review][:train_number]).id

    respond_to do |format|
      if @review.save
        train_rating = @review.train.reviews.average(:rating)
        @review.train.update(:ratings => train_rating)
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @train = @review.train_id
    @user = @review.user_id
    respond_to do |format|
      if @review.update(review_params)
        train_rating = @review.train.reviews.average(:rating)
        @review.train.update(:ratings => train_rating)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!
    train_rating = @review.train.reviews.average(:rating)
    @review.train.update(:ratings => train_rating)
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:feedback,:rating, :train_id, :user_id)
  end
end
