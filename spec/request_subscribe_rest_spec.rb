require "spec_helper"

RSpec.describe Bootpay do
  it 'Subscribe Card By REST API' do
    bootpay = Bootpay::ServerApi.new(
      '59b731f084382614ebf72215',
      'WwDv0UjfwFa04wYG0LJZZv1xwraQnlhnHE375n52X0U='
    )
    result  = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.get_subscribe_billing_key(
      order_id:        Time.current.to_i,
      pg:              'nicepay',
      item_name:       '30일 정기결제',
      card_no:         '[ 카드 번호 ]',
      expire_year:     '[ 만료 년도 ]',
      expire_month:    '[ 만료 월 ]',
      identify_number: '[ 카드 소유주 생년 월일 ]',
      card_pw:         '[ 카드 비밀번호 2자리 ]',
      user_info:       {
        username: '부트페이',
        email:    'developer@bootpay.co.kr',
        phone:    '01000000000',
        address:  '인천광역시 연수구 송도문화로 28번길 28',
        zipcode:  '222000'
      }
    )
    print result
  end
end
