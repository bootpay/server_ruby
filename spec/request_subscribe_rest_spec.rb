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
    result = bootpay.get_subscribe_billing_key(
      order_id:        Time.current.to_i,
      pg:              'nicepay',
      item_name:       '30일 정기결제',
      card_no:         '4578457845784578',
      expire_year:     '**',
      expire_month:    '**',
      identify_number: '010101',
      card_pw:         '**',
      user_info:       {
        username: '부트페이',
        email:    'developer@bootpay.co.kr',
        phone:    '01000000000',
        address:  '인천광역시 연수구 송도문화로 28번길 28',
        zipcode:  '222000'
      },
      extra: {
        subscribe_test_payment: 1
      }
    )
    print result
  end
end
