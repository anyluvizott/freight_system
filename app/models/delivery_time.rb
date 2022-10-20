class DeliveryTime < ApplicationRecord
  has_one :order_of_service

  validates :starting_km, :final_km, :deadline, presence: true
  validates :starting_km, :final_km, :deadline, numericality: { only_integer: true, greater_than: 0 }
  validate :starting_value
  validate :different_initial_value_create, on: :create
  validate :different_final_value_create, on: :create
  validate :different_initial_value_edit, on: :update
  validate :different_final_value_edit, on: :update

  private

  def starting_value
    if !starting_km.nil? && !final_km.nil? && (starting_km > final_km)
      errors.add(:starting_km, 'deve ser menor que o Km Final')
    end
  end

  def different_initial_value_create
    if !starting_km.nil? && !final_km.nil?
      @delivery_time = DeliveryTime.all
      unless @delivery_time.nil?
        @delivery_time.each do |dt|
          if starting_km >= dt.starting_km && starting_km <= dt.final_km
            errors.add(:starting_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_create
    if !starting_km.nil? && !final_km.nil?
      @delivery_time = DeliveryTime.all
      unless @delivery_time.nil?
        @delivery_time.each do |dt|
          if final_km >= dt.starting_km && final_km <= dt.final_km
            errors.add(:final_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_initial_value_edit
    if !starting_km.nil? && !final_km.nil?
      @delivery_time = DeliveryTime.all
      unless @delivery_time.nil?
        @delivery_time.each do |dt|
          if starting_km > dt.starting_km && starting_km < dt.final_km
            errors.add(:starting_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_edit
    if !starting_km.nil? && !final_km.nil?
      @delivery_time = DeliveryTime.all
      unless @delivery_time.nil?
        @delivery_time.each do |dt|
          if final_km > dt.starting_km && final_km < dt.final_km
            errors.add(:final_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end
end
