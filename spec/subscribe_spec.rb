require "spec_helper"

RSpec.describe Bootpay do
  it 'Subscribe Card Billing' do
    bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
      :development
    )
    result  = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)

    result = bootpay.subscribe_billing(
      billing_key: '5d130a3da3935803ab34eb69',
      'item_name': '정기결제 테스트 아이템',
      'price':     3000,
      'order_id':  Time.now.to_i.to_s,
      'username':  '강훈'
    )
    print result
  end
end