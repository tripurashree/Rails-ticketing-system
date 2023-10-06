class TicketsController < ApplicationController
  # load_and_authorize_resource
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /tickets or /tickets.json
  def index
    if current_user.id == 1
      @tickets = Ticket.all
    else

      @upcoming_tickets = Ticket.includes(:train).joins(:train).where('trains.departure_date > ?', Date.current).where(:user_id => current_user.id)
      @past_tickets = Ticket.includes(:train).joins(:train).where('trains.departure_date <= ?', Date.current).where(:user_id => current_user.id)
    end
  end


  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @trains = Train.all
    @unique_departure_stations = Train.distinct.pluck(:departure_station).map(&:downcase).uniq
    @unique_arrival_stations = Train.distinct.pluck(:termination_station).map(&:downcase).uniq

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
    @ticket.user_id = params[:user_id]
    @ticket.confirmation_number = view_context.generate_confirmation_number
    print("DEBUG for ticket confirmation",@ticket)
    print(" DEBUG for ticket to seats link  ",@ticket.train.seats_left)
    if @ticket.train.seats_left >= 0
      respond_to do |format|
        if @ticket.save
          @ticket.train.decrement(:seats_left, 1)
          @ticket.train.save
          format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
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
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:confirmation_number, :train_id, :user_id)
  end
end
