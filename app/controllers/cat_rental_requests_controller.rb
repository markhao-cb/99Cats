class CatRentalRequestsController < ApplicationController
  def index
    @crrs = CatRentalRequest.all
  end

  def new
    @cat = Cat.find(params[:cat_id])
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

  def approve
    @crr = CatRentalRequest.find(params[:id])
    @crr.approve!
  rescue
    flash[:overlap] = "Overlapping approval"
  ensure
    redirect_to :back
  end

  def deny
    @crr = CatRentalRequest.find(params[:id])
    @crr.deny!

    redirect_to cat_url(@crr.cat_id)
  end

  private
  def crr_params
    params.require(:crr)
          .permit(:cat_id, :start_date, :end_date, :status)
  end

end
