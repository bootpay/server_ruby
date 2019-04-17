require "spec_helper"

RSpec.describe Bootpay do
  it 'Receipt Verify' do
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
    result  = bootpay.get_access_token
    print result
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)
    result = bootpay.verify("5cb6f284e13f33668ddfe181")
    print result.to_json
  end
end