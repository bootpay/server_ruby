module Bootpay
  class ServerApi
    URL = {
      development: 'https://dev-api.bootpay.co.kr',
      test:        'https://test-api.bootpay.co.kr',
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

    def set_token(token)
      @token = token
    end

    def get_access_token
      result = request(
        :post,
        [api_url, 'request', 'token.json'].join('/'),
        {
          application_id: @application_id,
          private_key:    @private_key
        }
      )
      @token = result[:data][:token] if result[:status] == 200
      result
    end

    def verify(receipt_id)
      raise 'receipt_id 값이 비어있습니다.' if receipt_id.nil?
      raise 'token 값이 비어 있습니다.' if @token.blank?
      request(
        :get,
        [api_url, 'receipt', "#{receipt_id}.json"].join('/'),
        {},
        {
          Authorization: @token
        }
      )
    end

    def cancel(receipt_id, price = nil, name = '', reason = '')
      raise 'token 값이 비어 있습니다.' if @token.blank?
      request(
        :post,
        [api_url, 'cancel.json'].join('/'),
        {
          receipt_id: receipt_id,
          price:      price,
          name:       name,
          reason:     reason
        }.compact,
        {
          Authorization: @token
        }
      )
    end

    def get_subscribe_billing_key(data)
      raise 'token 값이 비어 있습니다.' if @token.blank?
      raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
      raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
      raise '결제하고자 하는 pg alias를 입력해주세요.' if data[:pg].blank?
      request(
        :post,
        [api_url, 'request', 'card_rebill.json'].join('/'),
        data,
        {
          Authorization: @token
        }
      )
    end

    def destroy_subscribe_billing_key(billing_key)
      raise 'token 값이 비어 있습니다.' if @token.blank?
      request(
        :delete,
        [api_url, 'subscribe', 'billing', "#{billing_key}.json"].join('/'),
        {},
        {
          Authorization: @token
        }
      )
    end

    def subscribe_billing(data)
      raise 'token 값이 비어 있습니다.' if @token.blank?
      raise 'billing_key 값을 입력해주세요.' if data[:billing_key].blank?
      raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
      raise 'price 금액을 설정을 해주세요.' if data[:price].blank?
      raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
      request(
        :post,
        [api_url, 'subscribe', 'billing.json'].join('/'),
        data,
        {
          Authorization: @token
        }
      )
    end

    def subscribe_reserve_billing(data)
      raise 'token 값이 비어 있습니다.' if @token.blank?
      raise 'billing_key 값을 입력해주세요.' if data[:billing_key].blank?
      raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
      raise 'price 금액을 설정해주세요.' if data[:price].blank?
      raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
      raise 'execute_at 실행 시간을 설정해주세요.' if data[:execute_at].blank?
      data[:scheduler_type] = data[:scheduler_type].presence || 'oneshot'
      request(
        :post,
        [api_url, 'subscribe', 'billing', 'reserve.json'].join('/'),
        data,
        {
          Authorization: @token
        }
      )
    end

    def subscribe_reserve_cancel(reserve_id)
      raise 'reserve_id를 입력해주세요.' if reserve_id.blank?
      request(
        :delete,
        [api_url, 'subscribe', 'billing', 'reserve', "#{reserve_id}.json"].join('/'),
        {},
        {
          Authorization: @token
        }
      )
    end

    def confirm(receipt_id)
      raise 'receipt_id를 입력해주세요.' if receipt_id.blank?
      request(
        :post,
        [api_url, 'submit.json'].join("/"),
        {
          receipt_id: receipt_id
        },
        {
          Authorization: @token
        }
      )
    end

    private

      def request(method, url, data = {}, headers = {})
        begin
          response = RestClient::Request.execute(
            method:  method.to_sym,
            url:     url,
            payload: data,
            headers: headers
          )
            # RestClient에서 HTTP 200 OK가 아닌 경우 처리
        rescue RestClient::ExceptionWithResponse => e
          response = e.response
        end

        JSON.parse(response.body, symbolize_names: true) rescue {
          status:  500,
          code:    -100,
          message: e.message
        }
      end

      def api_url
        URL[@mode.to_sym]
      end
  end
end