# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default(""), not null
#  name                   :string
#  last_name              :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  cover_file_name        :string
#  cover_content_type     :string
#  cover_file_size        :integer
#  cover_updated_at       :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  #has_many :friendships

  # Se le indica al modelo que tiene un archivo adjunto de Paperclip
  #has_attached_file :avatar,styles: {thumb:"100x100",medium:"300x300"},default_url:"/images/:style/minion.jpg"
  #validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  #has_attached_file :cover,styles: {thumb:"400x300",medium:"800x600"},default_url:"/images/:style/missing_cover.jpg"
  #validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, uniqueness: true, length: {in: 3..12}
  validate :validate_username_regex

  # Método de clase
  def self.from_omniauth(auth)
  	# BUscar si existe un usuario con las credenciales que nos pasaron
  	where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
  		if auth[:info]
  			user.email = auth[:info][:email]
  			user.name = auth[:info][:name]
  		end
  		# friendly_token crea una cadena que contiene caracteres aleatorios
  		user.password = Devise.friendly_token[0,20]
  	end
  end


  private
    def validate_username_regex
      # =~ valida que username tenga el patrón de la expresión regular
      unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
        errors.add(:username,"El username debe iniciar con una letra")
        errors.add(:username,"El username sólo puede contener guión bajo, letras y números")
      end
    end
end
