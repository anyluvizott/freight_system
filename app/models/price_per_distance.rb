class PricePerDistance < ApplicationRecord
  has_one :order_of_service

  validates :starting_km, :final_km, :fixed_price, presence: true
  validates :starting_km, :final_km, numericality: { only_integer: true, greater_than: 0 }
  validates :fixed_price, numericality: { greater_than: 0 }
  validate :starting_value
  validate :different_initial_value_create, on: :create
  validate :different_final_value_create, on: :create
  validate :different_initial_value_edit, on: :update
  validate :different_final_value_edit, on: :update

  private

  def starting_value
    if !starting_km.nil? && !final_km.nil? && (starting_km > final_km)
      errors.add(:starting_km, 'deve ser menor que a Distância Final')
    end
  end

  def different_initial_value_create
    if !starting_km.nil? && !final_km.nil?
      @price_per_distance = PricePerDistance.all
      unless @price_per_distance.nil?
        @price_per_distance.each do |pd|
          if starting_km >= pd.starting_km && starting_km <= pd.final_km
            errors.add(:starting_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_create
    if !starting_km.nil? && !final_km.nil?
      @price_per_distance = PricePerDistance.all
      unless @price_per_distance.nil?
        @price_per_distance.each do |pd|
          if final_km >= pd.starting_km && final_km <= pd.final_km
            errors.add(:final_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_initial_value_edit
    if !starting_km.nil? && !final_km.nil?
      @price_per_distance = PricePerDistance.all
      unless @price_per_distance.nil?
        @price_per_distance.each do |pd|
          if starting_km > pd.starting_km && starting_km < pd.final_km
            errors.add(:starting_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_edit
    if !starting_km.nil? && !final_km.nil?
      @price_per_distance = PricePerDistance.all
      unless @price_per_distance.nil?
        @price_per_distance.each do |pd|
          if final_km > pd.starting_km && final_km < pd.final_km
            errors.add(:final_km, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end
end
