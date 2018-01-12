module Api
  module V1
    class BaseController < ActionController::API
      before_action(:authenticate_token!)

      private

      def authenticate_token!
        return unauthenticated unless token?
      end

      def unauthenticated
        render json: {
          message: I18n.t('tokens.api.invalid')
        }, status: 401
      end

      def token?
        Token.find_by(value: token_header).present?
      end

      def token_header
        request.headers['X-AUTHORIZATION-TOKEN']
      end
    end
  end
end
