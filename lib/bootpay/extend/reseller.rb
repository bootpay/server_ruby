module Bootpay
  module Extend
    module Reseller
      extend ActiveSupport::Concern

      included do
        # 리셀러 밑에 회원 정보를 조회한다
        # Comment by Gosomi
        # Date: 2020-01-17
        # @return [Hash]
        def lookup_seller(email)
          request(
            :get,
            [api_url, 'seller', 'lookup.json'].join('/'),
            {},
            {
              content_type:  :json,
              Authorization: @token,
              params:        {
                email: email
              }
            }
          )
        end

        # 리셀러 계정으로 판매자 가입
        # Comment by Gosomi
        # Date: 2020-01-17
        # @return [Hash]
        def seller_join(data)
          request(
            :post,
            [api_url, 'seller', 'join.json'].join('/'),
            data.to_json,
            {
              content_type:  :json,
              Authorization: @token
            }
          )
        end
      end
    end
  end
end