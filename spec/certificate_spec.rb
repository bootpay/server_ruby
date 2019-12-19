require "spec_helper"

RSpec.describe Bootpay do
  it 'Certificate Verify' do
    bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0='
    )
    result  = bootpay.get_access_token
    print result
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.certificate("[[ receipt_id ]]")
    print result.to_json
  end
end