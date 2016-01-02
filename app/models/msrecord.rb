class Msrecord < ActiveRecord::Base
  validates :reading_at, presence: true
  validates :received_stock, :actual_stock, :opening_meter, :testing_meter, presence: true, numericality: true
  validates :purchase_rate, :sale_rate, presence: true, numericality: true


  def prev_closing_meter previous_record
    return previous_record unless previous_record
    previous_record.closing_meter = self.opening_meter
    previous_record
  end

  def prev_actual_sale previous_record
    return previous_record unless previous_record
    previous_record.actual_sale = self.opening_meter - previous_record.opening_meter - previous_record.testing_meter
    previous_record
  end

  def prev_closing_stock previous_record
    return previous_record unless previous_record
    previous_record.closing_stock = previous_record.total_stock - previous_record.actual_sale
    previous_record
  end

  def current_total_stock previous_record
    previous_record.nil? ? self.total_stock = self.received_stock  : self.total_stock = previous_record.closing_stock + self.received_stock
  end

  def current_opening_stock previous_record
    previous_record.nil? ? self.opening_stock = 0 : self.opening_stock = previous_record.closing_stock
  end

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end

  def self.search(start_date, end_date)
    where("reading_at >= ? and reading_at <= ?", start_date, end_date)
  end

  def self.to_csv()
    column_names  = ["Date", "Opening Stock", "Received Stock", "Actual Stock", "Total Stock", "Closing Stock", "Opening Meter",
                     "Testing Meter", "Closing Meter", "Actual Sale", "Purchase Rate", "Sale Rate"]
    attributes    = %w{reading_at opening_stock received_stock actual_stock total_stock closing_stock opening_meter
                    testing_meter closing_meter actual_sale purchase_rate sale_rate}

    CSV.generate(headers: true) do |csv|
      csv << column_names
      all.each do |msrecord|
        #csv << msrecord.attributes.values_at(*attributes)
        csv << attributes.map{ |attr| msrecord.send(attr) }
      end
    end
  end
end
