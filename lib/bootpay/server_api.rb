Gem.find_files("bootpay/extend/*.rb").each { |path| require path }

module Bootpay
  class ServerApi

    include Bootpay::Extend::Billing
    include Bootpay::Extend::Common
    include Bootpay::Extend::Message
    include Bootpay::Extend::Naverpay
    include Bootpay::Extend::Samsung
    include Bootpay::Extend::Token
    include Bootpay::Extend::Verification

    URL = {
      development: 'https://dev-api.bootpay.co.kr',
      test:        'https://test-api.bootpay.co.kr',
      stage:       'https://stage-api.bootpay.co.kr',
      production:  'https://api.bootpay.co.kr'
    }.freeze

    def initialize(application_id, private_key, mode = :production)
      raise 'application_id 값이 비어있습니다.' if application_id.nil?
      raise 'private_key 값이 비어있습니다.' if private_key.nil?
      @application_id = application_id
      @private_key    = private_key
      @mode           = mode.to_sym
      @token          = nil
    end
  end
end