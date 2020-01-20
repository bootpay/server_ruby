require "spec_helper"

RSpec.describe Bootpay do
  it 'Subscribe Card By REST API' do
    # bootpay = Bootpay::ServerApi.new(
    #   '59b731f084382614ebf72215',
    #   'WwDv0UjfwFa04wYG0LJZZv1xwraQnlhnHE375n52X0U='
    # )
    bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
      :development
    )
    result  = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.request_payment(
      pg:         'kcp',
      method:     'card',
      order_id:   (Time.current.to_i),
      price:      1000,
      name:       '테스트 부트페이 상품',
      callback:   1,
      return_url: 'https://dev-api.bootpay.co.kr/callback',
      extra:      {
        expire: 30
      }
    )
    print result
  end
end
