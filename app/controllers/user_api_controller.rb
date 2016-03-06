module Api
  class UserApiController < ApiController

    def login

    end
  end
end


=begin
  user logs in.
  a web token is made with that user's id.
  authenticate that user whenever a request again.
  so long as all models come through a user, there souldnt be a security problem
  otherwise, each model will need a can_be_accessed_by(user) method
    and Ill have to call it whenever I try to access something.
=end
