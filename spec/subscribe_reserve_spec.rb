require "spec_helper"

RSpec.describe Bootpay do
  it 'Subscribe Card Reserve Billing' do
    # bootpay = Bootpay::ServerApi.new(
    #   '59bfc738e13f337dbd6ca48a',
    #   'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
    #   :development
    # )
    bootpay = Bootpay::ServerApi.new(
      '5bd6a4c9396fa677cbc8ad1a',
      'Fd8vrp1hxyp0y/w0H0d+VPGAOj4typJXPyNeybh26Ek='
    )
    result  = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    # result = bootpay.subscribe_reserve_billing(
    #   billing_key:  '5b99a854e13f330555207436',
    #   item_name:    '정기결제 테스트 아이템',
    #   price:        3000,
    #   order_id:     Time.now.to_i.to_s,
    #   execute_at:   (Time.now + 10.seconds).to_i,
    #   'username':   '강훈',
    #   feedback_url: 'https://dev-api.bootpay.co.kr/callback'
    # )
    result = bootpay.subscribe_reserve_billing(
      billing_key:  '5c0e05e6ed32b37c338a2f14',
      item_name:    '정기결제 테스트 아이템',
      price:        3000,
      order_id:     Time.now.to_i.to_s,
      execute_at:   (Time.now + 10.seconds).to_i,
      'username':   '강훈',
      feedback_url: 'https://dev-api.bootpay.co.kr/callback'
    )
    print result.to_json
    # result = bootpay.subscribe_reserve_cancel result[:data][:reserve_id]
    # print result
  end
end