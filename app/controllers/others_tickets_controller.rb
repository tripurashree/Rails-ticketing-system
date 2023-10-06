class OthersTicketsController < ApplicationController

  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @past_tickets = Ticket.where(:booked_by => current_user.id)
  end


  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @trains = Train.all
    print('GOOOOOOOOOOOOOOOOOOOOOOOOOOOO',@trains)
    @unique_departure_stations = Train.distinct.pluck(:departure_station).map(&:downcase).uniq
    @unique_arrival_stations =  Train.distinct.pluck(:termination_station).map(&:downcase).uniq
    @user_mail_ids =User.distinct.pluck(:email).reject { |email| email == current_user.email || email == User.find_by(id:1).email }
    if params[:departure_station].present? || params[:arrival_station].present? || params[:review_rating].present?

      if params[:departure_station].present?
        @trains = Train.where("departure_station COLLATE NOCASE = ?", params[:departure_station])
      end
      if params[:arrival_station].present?

        if @trains
          @trains = @trains.where("termination_station COLLATE NOCASE = ?", params[:arrival_station]) ? @trains.where("termination_station COLLATE NOCASE = ?", params[:arrival_station]) : @trains
        else
          @trains = Train.where("termination_station COLLATE NOCASE = ?", params[:arrival_station])

        end
      end
      if params[:review_rating].present?
        if @trains
          @trains = @trains.where( 'ratings >= ?', params[:review_rating]) ? @trains.where( 'ratings >= ?', params[:review_rating]) : @trains
        else
          @trains = Train.where( 'ratings >= ?', params[:review_rating])
        end
      end
      if @trains
        @trains = @trains.where('departure_date > ?', Date.current).where( 'seats_left > ?', 0 )
      end
    else
      @trains = Train.where('departure_date > ?', Date.current).where( 'seats_left > ?', 0 )
      #   if current_user.id !=1
      #     @trains = Train.where('departure_date > ?', Date.current).where( 'seats_left > ?', 0 )
      #   else
      #     @trains = Train.all
      #   end
    end

    print("DEBUG   trains      $#$#$#",@trains)
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    print("DEBUG for params %%%%%%%%%%% confirmation",params)
    @train = Train.find(params[:train_id])
    @ticket = @train.tickets.build
    print(User.find_by(email: params[:user_mail_id]),'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD')
    @ticket.user_id = User.find_by(email: params[:user_mail_id]).id
    @ticket.booked_by = current_user.id
    @ticket.confirmation_number = view_context.generate_confirmation_number
    print("DEBUG for ticket confirmation",@ticket)
    print(" DEBUG for ticket to seats link  ",@ticket.train.seats_left)
    if @ticket.train.seats_left >= 0
      respond_to do |format|
        if @ticket.save
          print(" Got saved  ")
          @ticket.train.decrement(:seats_left, 1)
          @ticket.train.save
          format.html { redirect_to others_tickets_url, notice: "Ticket was successfully created." }
          format.json { render :show, status: :created, location: @ticket }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy

    @ticket.train.increment(:seats_left, 1)
    @ticket.train.save
    @ticket.destroy!
    respond_to do |format|
      format.html { redirect_to others_tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def others_tickets_params
    params.require(:ticket).permit(:confirmation_number, :train_id, :user_id, :booked_by)
  end
end
