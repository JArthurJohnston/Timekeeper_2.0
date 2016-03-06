require_relative '../../../test/models/model_test_case'
class AuthenticationTokenTest < ModelTestCase

  test 'token encodes payload' do
    expected_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9." +
    "eyJtZXNzYWdlIjoidGhhdCBsb2FkIHdoaWNoIGlzIGJlaW5nIHBhaWQifQ." +
    "-LS19zhiW9k6sRnNgQQFfq2vl824vEcMtAHz44ATDoo"

    payload = {message: 'that load which is being paid'}
    actual_token = AuthenticationToken.for payload

    assert_equal expected_token, actual_token

    payload_from_token = AuthenticationToken.from(actual_token)
    assert_equal payload[:message], payload_from_token['message']
  end
end