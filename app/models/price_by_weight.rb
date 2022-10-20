class PriceByWeight < ApplicationRecord
  has_one :order_of_service

  validates :starting_weight, :final_weight, :price_per_km, presence: true
  validates :starting_weight, :final_weight, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_km, numericality: { greater_than: 0 }
  validate :starting_value
  validate :different_initial_value_create, on: :create
  validate :different_final_value_create, on: :create
  validate :different_initial_value_edit, on: :update
  validate :different_final_value_edit, on: :update

  private

  def starting_value
    if !starting_weight.nil? && !final_weight.nil? && (starting_weight > final_weight)
      errors.add(:starting_weight, 'deve ser menor que o Peso Final')
    end
  end

  def different_initial_value_create
    if !starting_weight.nil? && !final_weight.nil?
      @price_by_weight = PriceByWeight.all
      unless @price_by_weight.nil?
        @price_by_weight.each do |pw|
          if starting_weight >= pw.starting_weight && starting_weight <= pw.final_weight
            errors.add(:starting_weight, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_create
    if !starting_weight.nil? && !final_weight.nil?
      @price_by_weight = PriceByWeight.all
      unless @price_by_weight.nil?
        @price_by_weight.each do |pw|
          if final_weight >= pw.starting_weight && final_weight <= pw.final_weight
            errors.add(:final_weight, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_initial_value_edit
    if !starting_weight.nil? && !final_weight.nil?
      @price_by_weight = PriceByWeight.all
      unless @price_by_weight.nil?
        @price_by_weight.each do |pw|
          if starting_weight > pw.starting_weight && starting_weight < pw.final_weight
            errors.add(:starting_weight, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

  def different_final_value_edit
    if !starting_weight.nil? && !final_weight.nil?
      @price_by_weight = PriceByWeight.all
      unless @price_by_weight.nil?
        @price_by_weight.each do |pw|
          if final_weight > pw.starting_weight && final_weight < pw.final_weight
            errors.add(:final_weight, 'não pode já estar incluido na tabela')
          end
        end
      end
    end
  end

end
