class UserToken < AuthenticationToken

  def self.for(user)
    super(user.as_json)
  end

  def self.from(token)
    user_id = super(token)['id']
    User.find(user_id)
  end
end