class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
    @trains = Train.all
    @unique_departure_stations = Train.distinct.pluck(:departure_station)
    @unique_arrival_stations = Train.distinct.pluck(:termination_station)
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @train = Train.find_by(params[:train_id])
    @user = User.find_by(params[:user_id])
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    print("DEBUG for ticket confirmation",params[:ticket][:confirmation_number])
    @ticket.confirmation_number = params[:ticket][:confirmation_number]
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
