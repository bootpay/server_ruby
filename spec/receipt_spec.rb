require "spec_helper"

RSpec.describe Bootpay do
  it 'Receipt Verify' do
    bootpay = Bootpay::ServerApi.new(
        '59bfc738e13f337dbd6ca48a',
        'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
        :development
    )
    result  = bootpay.get_access_token
    print result
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.verify('5c2da0c0e13f3304e788df3d')
    print result.to_json
  end
end