# app/models/user.rb

class User < ApplicationRecord
  # Devise modules. Add others if needed.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { user: 'user', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  has_many :proposals, dependent: :destroy
  has_many :comments, dependent: :destroy

  def set_default_role
    self.role ||= 'user'
  end
end
