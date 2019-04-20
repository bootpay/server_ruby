require "spec_helper"

RSpec.describe Bootpay do
  it 'Response Xml' do
    bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
      :development
    )
    # 59b731f084382614ebf72215
    # WwDv0UjfwFa04wYG0LJZZv1xwraQnlhnHE375n52X0U=
    # bootpay = Bootpay::ServerApi.new(
    #     '59b731f084382614ebf72215',
    #     'WwDv0UjfwFa04wYG0LJZZv1xwraQnlhnHE375n52X0U='
    # )
    result = bootpay.get_access_token
    print result
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.naverpay_item_response(
      [
        {
          id:             1,
          name:           '윤태섭 청바지',
          tax_type:       'TAX',
          base_price:     10000,
          info_url:       'https://bootpay.co.kr',
          image_url:      'https://bootpay.co.kr',
          stock_quantity: 100,
          status:         'ONSALE',
          option:         {
            combination:
              [
                {
                  manage_code: 'option_1',
                  status:      true,
                  options:
                               [
                                 {
                                   id:   '색상',
                                   name: '레드'
                                 },
                                 {
                                   id:   '사이즈',
                                   name: 'XL'
                                 }
                               ]
                },
                {
                  manage_code: 'option_2',
                  status:      true,
                  options:
                               [
                                 {
                                   id:   '색상',
                                   name: '블루'
                                 },
                                 {
                                   id:   '사이즈',
                                   name: 'L'
                                 }
                               ]
                }
              ]
          },
          shipping_policy:
                          {
                            method:            'DELIVERY',
                            fee_type:          'CHARGE',
                            fee_pay_type:      'PREPAYED',
                            base_price:        2500,
                            surcharge_by_area: {
                              api_support: true,
                              area2_price: 5000,
                              area3_price: 10000
                            }
                          }
        }
      ]
    )
    print result
  end
end