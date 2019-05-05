require "spec_helper"

RSpec.describe Bootpay do
  it 'Receipt Cancel' do
    # bootpay = Bootpay::ServerApi.new(
    #   '59bfc738e13f337dbd6ca48a',
    #   'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
    #   :development
    # )

    bootpay = Bootpay::ServerApi.new(
      '5cb93559e13f331a427e8f26',
      'RHa8MMvNJF1dNucxDWrVUmg5j4HMf/Kdz98fSytrnIk=',
      :development
    )
    result  = bootpay.get_access_token
    expect(result).not_to be_empty
    expect(result[:status]).to eq(200)

    result = bootpay.cancel(
      '5cce90afe13f331f6f5b590a',
      '35000',
      0,
      'test',
      'test'
    )
    print result
  end
end