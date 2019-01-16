require "spec_helper"

RSpec.describe Bootpay do
  it 'request_access_token' do
    bootpay = Bootpay::ServerApi.new(
        '59bfc738e13f337dbd6ca48a',
        'FQj3jOvQYp053nxzWxHSuw+cq3zUlSWZV2ec/8fkiyA=',
        :development
    )
    result = bootpay.get_access_token
    ㅔ
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
  end
end