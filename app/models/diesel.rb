class Diesel < ActiveRecord::Base
  validates :reading_at, presence: true
  validates :current_stock, presence: true, numericality: true
end
