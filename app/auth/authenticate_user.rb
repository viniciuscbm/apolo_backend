class AuthenticateUser
  include ActiveModel::Model

  validate :authentication

  def initialize(params)
    @email    = params.fetch('email')
    @password = params.fetch('password')
  end

  def payload
    {
      "access_token": create_token
    }
  end

  private

  attr_reader :email, :password

  def create_token
    Api::JsonWebToken.encode(user_id: user.id)
  end

  def authentication
    return errors.add(:auth, 'invalid credentials') unless credentials?
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def credentials?
    user&.authenticate(password) ? true : false
  end
end
