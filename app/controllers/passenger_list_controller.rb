class PassengerListController < ApplicationController
  def new
    @trains_number = Train.all.pluck(:train_number)

    if params[:train_number].present?
      @passengers = Train.find_by(train_number: params[:train_number] ).tickets.includes(:user).map(&:user)
    end


  end
end
