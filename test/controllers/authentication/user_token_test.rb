require_relative '../../../test/models/model_test_case'
class UserTokenTest < ModelTestCase

  test 'token encodes user' do
    expected_token ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.' +
        'eyJpZCI6bnVsbH0.QC0PJGvCERZyWRQWVY7kj1Vj6rAZZmC3UQcVKGI6SGA'

    user = User.create(username: 'JSmith')
    actual_token = UserToken.for user

    assert_equal expected_token, actual_token

    user_from_token = UserToken.from(actual_token)
    assert_equal user, user_from_token
  end
end