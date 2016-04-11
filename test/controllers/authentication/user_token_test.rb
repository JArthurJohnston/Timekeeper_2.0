require_relative '../../../test/models/model_test_case'
class UserTokenTest < ModelTestCase

  test 'token encodes user' do
    expected_token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.' +
        'eyJpZCI6MSwiY3VycmVudF90aW1lc2hlZXRfaWQiOm51bGwsInVzZXJuYW1lIjpudWxsLCJlbWFpbCI6bnVsbH0.' +
        '4KAH8t1Zowfueqndb9CYr_EaHtxGAOot2UdsWSn9TnQ'
    user = User.create(id: 1, password: '1234', password_digest: '1234')

    actual_token = UserToken.for user

    assert_equal expected_token, actual_token

    user_from_token = UserToken.from(actual_token)

    assert_equal user, user_from_token
  end

end