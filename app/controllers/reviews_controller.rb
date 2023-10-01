class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  #before_action :authenticate_user!
  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @trains_list = Train.all.map {|train| train.train_number}.uniq
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
    respond_to do |format|
      if @review.update(review_params)
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
    params.require(:review).permit(:feedback,:rating)
  end
end
