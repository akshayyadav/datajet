class DieselsController < ApplicationController

  include ApplicationHelper

  around_filter :catch_not_found

  # index, show, new, edit, create, update and destroy

  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    if params[:start_date].blank? or params[:end_date].blank?
      @diesels   = Diesel.all
    else
      start_date = params[:start_date].to_date
      end_date   = params[:end_date].to_date
      @diesels   = Diesel.search(start_date, end_date)
    end
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

    @previous_record = Diesel.last
    @previous_record = @diesel.prev_closing_meter @previous_record
    @previous_record = @diesel.prev_actual_sale @previous_record
    @previous_record = @diesel.prev_closing_stock @previous_record

    @diesel.current_total_stock @previous_record
    @diesel.current_opening_stock @previous_record

    if @diesel.save
      @previous_record.save unless @previous_record.nil?
      redirect_to @diesel
    else
      render 'new'
    end
  end

  def update
    @diesel = Diesel.find(params[:id])

    @previous_record = @diesel.previous
    @previous_record = @diesel.prev_closing_meter @previous_record
    @previous_record = @diesel.prev_actual_sale @previous_record
    @previous_record = @diesel.prev_closing_stock @previous_record

    @diesel.current_total_stock @previous_record
    @diesel.current_opening_stock @previous_record

    if @diesel.update(diesel_params)
      @previous_record.save unless @previous_record.nil?
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
    params.require(:diesel).permit(:reading_at,
                                   :received_stock,
                                   :actual_stock,
                                   :opening_meter,
                                   :testing_meter,
                                   :purchase_rate,
                                   :sale_rate)
  end

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to diesels_path, :flash => { :error => "Record not found." }
  end
end
