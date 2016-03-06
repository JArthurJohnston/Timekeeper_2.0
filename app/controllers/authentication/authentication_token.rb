class AuthenticationToken

  @@key =  Rails.application.secrets.secrete_key_base

  def self.for(payload)
    JWT.encode(payload, @@key)
  end

  def self.from(token)
    # returns an array with two hashes
    #   the first is the payload (ie: the one we care about)
    #   the second is metadata about the token
    JWT.decode(token, @@key)[0]
  end

end
