require "spec_helper"

RSpec.describe Bootpay do
  it 'Lookup Seller' do
    bootpay = Bootpay::ServerApi.new(
      '5e211dae36f0f3018b65d812',
      'USsMUaEBBb66H+g6r8z5ZZaWECnrldhszGWiNRfVjdU=',
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
    result = bootpay.lookup_seller("aqure84@naver.com")
    print result.to_json
  end
end