require "spec_helper"

RSpec.describe Bootpay do
  it 'Get Samsung chatbotpay URL' do
     bootpay = Bootpay::ServerApi.new(
      '59bfc738e13f337dbd6ca48a',
      'pDc0NwlkEX3aSaHTp/PPL/i8vn5E/CqRChgyEp/gHD0=',
      :development
     )

    #bootpay = Bootpay::ServerApi.new(
    #  '5dbffc304f74b40025c5f469',
    #  'FL92Ylb2aTo0EqyKzj1jtQ846CWjMrF/e3Mc+NMXnGc=',
    #  :stage
    #)
    bootpay.get_samsung_access_token
    # response = bootpay.request_samsung_chatbotpay(
    #   # application_id: '59a568d3e13f3336c21bf707',
    #   pg:             'inicis',
    #   method:         'card',
    #   order_id:       (Time.current.to_i),
    #   price:          1000,
    #   name:           '테스트 부트페이 상품',
    #   callback:       1,
    #   extra:          {
    #     expire: 30
    #   }
    # )
    response = bootpay.request_samsung_chatbotpay(
      pg:           'kcp',
      method:       'card',
      order_id:     (Time.current.to_i),
      price:        1000,
      name:         '테스트 부트페이 상품',
      callback:     1,
      feedback_url: 'https://api.bootpay.co.kr/callback',
      extra:        {
        expire:     30,
        samsungpay: 1
      }
    )
    print "#{response[:data]}?chatid=#{SecureRandom.uuid}-#{Time.current.to_i}&botid=#{SecureRandom.uuid}-#{Time.current.to_i}&serviceid=#{SecureRandom.uuid}-#{Time.current.to_i}&vkey=#{SecureRandom.uuid}-#{Time.current.to_i}"
  end
end