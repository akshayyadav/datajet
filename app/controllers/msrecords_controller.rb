class MsrecordsController < ApplicationController

  include ApplicationHelper

  around_filter :catch_not_found

  # index, show, new, edit, create, update and destroy

  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    if params[:start_date].blank? or params[:end_date].blank?
      @msrecords   = Msrecord.all
    else
      start_date = params[:start_date].to_date
      end_date   = params[:end_date].to_date
      @msrecords   = Msrecord.search(start_date, end_date)
    end

    respond_to do |format|
      format.html
      format.csv { send_data @msrecords.to_csv, filename: "msrecord-#{Time.now.strftime("%d-%m-%Y-%R")}.csv" }
      format.xlsx { render xlsx: 'excel', filename: "msrecord-#{Date.today}.xlsx" }
    end
  end

  def show
    @msrecord = Msrecord.find(params[:id])
  end

  def new
    @msrecord = Msrecord.new
  end

  def edit
    @msrecord = Msrecord.find(params[:id])
  end

  def create
    @msrecord = Msrecord.new(msrecord_params)

    @previous_record = Msrecord.last
    @previous_record = @msrecord.prev_closing_meter @previous_record
    @previous_record = @msrecord.prev_actual_sale @previous_record
    @previous_record = @msrecord.prev_closing_stock @previous_record

    @msrecord.current_total_stock @previous_record
    @msrecord.current_opening_stock @previous_record

    if @msrecord.save
      @previous_record.save unless @previous_record.nil?
      redirect_to @msrecord
    else
      render 'new'
    end
  end

  def update
    @msrecord = Msrecord.find(params[:id])

    @previous_record = @msrecord.previous
    @previous_record = @msrecord.prev_closing_meter @previous_record
    @previous_record = @msrecord.prev_actual_sale @previous_record
    @previous_record = @msrecord.prev_closing_stock @previous_record

    @msrecord.current_total_stock @previous_record
    @msrecord.current_opening_stock @previous_record

    if @msrecord.update(msrecord_params)
      @previous_record.save unless @previous_record.nil?
      redirect_to @msrecord
    else
      render 'edit'
    end
  end

  def destroy
    @msrecord = Msrecord.find(params[:id])
    @msrecord.destroy

    redirect_to msrecords_path
  end

  private
  def msrecord_params
    params.require(:msrecord).permit(:reading_at,
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
    redirect_to msrecords_path, :flash => { :error => "Record not found." }
  end
end
