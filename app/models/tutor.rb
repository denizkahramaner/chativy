class Tutor < ActiveRecord::Base
    has_many :photos
  	has_many :comments

  	validates :first_name, :presence => true
  	validates :last_name, :presence => true
  	validates :password, :presence => true
  	validates :login, :presence => true
  	validates :login, :uniqueness => true
  	validates :password_confirmation, :presence => true
  	validates_confirmation_of :password, :message => "should match confirmation"


  	def password_valid? (input_password)
  		input_password_digest = Digest::SHA1.hexdigest (input_password + self.salt.to_s)
  		if input_password_digest.eql?(self.password_digest) then
  			return true
  		else
  			return false
  		end
  	end

    def full_name
      [first_name, last_name].join(' ')
    end

    def full_name=(name)
      split = name.split(' ', 2)
      self.first_name = split.first
      self.last_name = split.last
    end

  	def password 
  		@password
  	end

  	def password=(input_password)
  		@password = input_password
  		salt = Random.rand.to_s
  		self.password_digest = Digest::SHA1.hexdigest (input_password + salt)
  		self.salt = salt
  	end
end
