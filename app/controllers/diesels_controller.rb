class DieselsController < ApplicationController

  # index, show, new, edit, create, update and destroy

  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    @diesels = Diesel.all
  end

  def show
    @diesel = Diesel.find(params[:id])
  end

  def new
    @diesel = Diesel.new
  end

  def edit
    @diesel = Diesel.find(params[:id])
  end

  def create
    @diesel = Diesel.new(diesel_params)


    if @diesel.save
      redirect_to @diesel
    else
      render 'new'
    end
  end

  def update
    @diesel = Diesel.find(params[:id])

    if @diesel.update(diesel_params)
      redirect_to @diesel
    else
      render 'edit'
    end
  end

  def destroy
    @diesel = Diesel.find(params[:id])
    @diesel.destroy

    redirect_to diesels_path
  end

  private
  def diesel_params
    params.require(:diesel).permit(:reading_at, :current_stock)
  end
end
