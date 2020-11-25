class AuthorizeRequest
  include ActiveModel::Model

  validate :authorization

  def initialize(headers = {})
    @headers = headers
  end

  def user
    User.find_by(id: decoded_auth_token[:user_id]) if decoded_auth_token
  end

  private

  attr_reader :headers

  def authorization
    return errors.add(:auth, 'missing token') unless http_auth_header
    return errors.add(:auth, 'invalid token') unless decoded_auth_token
    return errors.add(:auth, 'invalid token') unless user
  end

  def decoded_auth_token
    Api::JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    headers['Authorization'].split(' ').last if headers['Authorization'].present?
  end
end
