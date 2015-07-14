class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
  end

  def create
    @crr = CatRentalRequest.new(crr_params)
    if @crr.save
      redirect_to cat_rental_request_url(@crr)
    else
      flash[:errors] = @crr.errors.full_messages
      redirect_to new_cat_url
    end
  end

  def show
    @crr = CatRentalRequest.find(params[:id])
  end

  private
  def crr_params
    params.require(:crr)
          .permit(:cat_id, :start_date, :end_date, :status)
  end

end
