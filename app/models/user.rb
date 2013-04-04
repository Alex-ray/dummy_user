class User < ActiveRecord::Base
  validates :user_name, :uniqueness => true
  validates :email, :uniqueness => true
end
