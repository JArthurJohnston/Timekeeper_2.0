module Api

  class UserController < ApiController

    @@user_not_found = User.new

    def login
      if @user == User::NULL
        head :unauthorized
      elsif @user == @@user_not_found
        head 404
      else
        render json: UserToken.for(@user)
      end
    end

    private

      def login_params
        params.require(:credentials)
      end

      def login_credentials
        JSON.parse(login_params)
      end

      def find_user
        creds = login_credentials
        unverified_user = User.find_by(username: creds['username'])
        if unverified_user.nil?
          @user = @@user_not_found
        elsif is_user(unverified_user.authenticate(creds['password']))
          @user = unverified_user
        else
          @user = User::NULL
        end
      end

      def is_user(a_user_or_false)
        if a_user_or_false == false
          return false
        end
        true
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


  1: user logs in
  2: if successful
    server returns a JWT token
  else
    return an invalid token
  3: each subsequent request from the client has to have the token given to it
    when that client logged in.
    if not, return a "not logged in" token
  4: whenever a request comes in, authenticate the token, and instantiate the
    user from the id on that token.
=end
