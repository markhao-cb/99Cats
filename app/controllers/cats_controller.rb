class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)

    redirect_to cat_url(@cat)
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy!

    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date,:color,:name,:sex,:description)
  end
end
