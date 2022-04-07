class User < ApplicationRecord
validates :name,{presence:true}
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
validates :password, length: { minimum: 4, maximum: 10 }
end
