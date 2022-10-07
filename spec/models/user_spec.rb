require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'O nome deve ser obrigatório' do
      user = User.new(name: nil)
      user.valid?

      expect(user.errors.include?(:name)).to be true
    end
  end
end
