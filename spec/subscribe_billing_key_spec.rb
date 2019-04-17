require "spec_helper"

RSpec.describe Bootpay do
  it 'Get Subscribe Billing key by REST' do
    bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
      :development
    )
    # bootpay = Bootpay::ServerApi.new(
    #   '5bd6a4c9396fa677cbc8ad1a',
    #   'Fd8vrp1hxyp0y/w0H0d+VPGAOj4typJXPyNeybh26Ek='
    # )
    result = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.subscribe_billing(
      billing_key: "5cb3d695e13f33668ddfe068",
      item_name:   '테스트결제',
      price:       100,
      order_id:    Time.current.to_i
    )
    print result
    # print result.to_json
    # result = bootpay.subscribe_reserve_cancel result[:data][:reserve_id]
    # print result
  end
end