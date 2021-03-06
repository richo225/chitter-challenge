require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,               Serial
  property :email,            String
  property :password_digest,  String, length: 60
  property :name,             String
  property :username,         String

  has n, :peeps, through: Resource

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end
