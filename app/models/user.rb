class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  #validates :email, format: {with: \^[a-z0-9.]+@sistemadefrete+\.com+\.(br)/}

  enum status: { regular: 0, admin: 5 }

  def user
    "Usuário: #{name}"
  end
  
end
