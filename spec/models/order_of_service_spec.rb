require 'rails_helper'

RSpec.describe OrderOfService, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'o endereço de saída é obrigatório' do
        order = OrderOfService.new(full_sender_address: nil)
        order.valid?
        expect(order.errors.include?(:full_sender_address)).to be true
      end

      it 'a altura do produto é obrigatório' do
        order = OrderOfService.new(product_height: nil)
        order.valid?
        expect(order.errors.include?(:product_height)).to be true
      end

      it 'falso quando a altura do produto é zero' do
        order = OrderOfService.new(product_height: 0)
        order.valid?
        expect(order.errors.include?(:product_height)).to be true
      end

      it 'falso quando a altura do produto é menor do que zero' do
        order = OrderOfService.new(product_height: -1)
        order.valid?
        expect(order.errors.include?(:product_height)).to be true
      end

      it 'a largura do produto é obrigatório' do
        order = OrderOfService.new(product_width: nil)
        order.valid?
        expect(order.errors.include?(:product_width)).to be true
      end

      it 'falso quando a largura do produto é zero' do
        order = OrderOfService.new(product_width: 0)
        order.valid?
        expect(order.errors.include?(:product_width)).to be true
      end

      it 'falso quando a largura do produto é menor do que zero' do
        order = OrderOfService.new(product_width: -1)
        order.valid?
        expect(order.errors.include?(:product_width)).to be true
      end

      it 'o comprimento do produto é obrigatório' do
        order = OrderOfService.new(product_length: nil)
        order.valid?
        expect(order.errors.include?(:product_length)).to be true
      end

      it 'falso quando o comprimento do produto é zero' do
        order = OrderOfService.new(product_length: 0)
        order.valid?
        expect(order.errors.include?(:product_length)).to be true
      end

      it 'falso quando o comprimento do produto é menor do que zero' do
        order = OrderOfService.new(product_length: -1)
        order.valid?
        expect(order.errors.include?(:product_length)).to be true
      end

      it 'o peso do produto é obrigatório' do
        order = OrderOfService.new(product_weight: nil)
        order.valid?
        expect(order.errors.include?(:product_weight)).to be true
      end

      it 'falso quando o peso do produto é zero' do
        order = OrderOfService.new(product_weight: 0)
        order.valid?
        expect(order.errors.include?(:product_weight)).to be true
      end

      it 'falso quando o peso do produto é menor do que zero' do
        order = OrderOfService.new(product_weight: -1)
        order.valid?
        expect(order.errors.include?(:product_weight)).to be true
      end

      it 'o endereço do destinatário é obrigatório' do
        order = OrderOfService.new(recipient_full_address: nil)
        order.valid?
        expect(order.errors.include?(:recipient_full_address)).to be true
      end

      it 'o nome do destinatário é obrigatório' do
        order = OrderOfService.new(recipients_name: nil)
        order.valid?
        expect(order.errors.include?(:recipients_name)).to be true
      end

      it 'a distância da entrega é obrigatório' do
        order = OrderOfService.new(distance: nil)
        order.valid?
        expect(order.errors.include?(:distance)).to be true
      end

      it 'falso quando a distância da entrega é zero' do
        order = OrderOfService.new(distance: 0)
        order.valid?
        expect(order.errors.include?(:distance)).to be true
      end

      it 'falso quando a distância da entrega é menor do que zero' do
        order = OrderOfService.new(distance: -1)
        order.valid?
        expect(order.errors.include?(:distance)).to be true
      end
    end
  end
end

describe 'Ordem de Serviço gera um código' do
  it 'unico e aleatório para a ordem de serviço' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    expect(order.order_service_code.length).to eq 15
  end

  it 'e o código não é alterado depois de criado' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    original_order_service_code = order.order_service_code

    order.update!(recipients_name: 'Joana da Silva')

    expect(order.order_service_code).to eq original_order_service_code
  end
end

describe 'Ordem de Serviço gera um código' do
  it 'unico e aleatório para o produto da carga' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    expect(order.product_code.length).to eq 5
  end

  it 'e o código não é alterado depois de criado' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: 'password', name: 'Administrador',
                         status: :admin)

    order = OrderOfService.create!(full_sender_address: 'Galpão das Frutas Tropicais - Rua das Maçãs, 150 - Curitiba PR',
                                   product_length: 25, product_width: 17, product_height: 8,
                                   recipient_full_address: 'Rua das Laranjas, 253 - Curitiba PR', recipients_name: 'Flora Mendes',
                                   distance: 15, product_weight: 5)

    original_product_code = order.product_code

    order.update!(product_height: 10)

    expect(order.product_code).to eq original_product_code
  end
end
