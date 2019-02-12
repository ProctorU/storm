# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include Daredevil

      before_action(:authenticate_token!)

      private

      def authenticate_token!
        if token?
          token.touch(:last_used_at)
        else
          unauthenticated
        end
      end

      def unauthenticated
        render json: {
          message: I18n.t('tokens.api.invalid')
        }, status: 401
      end

      def token
        @token ||= Token.find_by(value: token_header)
      end

      def token?
        token.present?
      end

      def token_header
        request.headers['X-AUTHORIZATION-TOKEN']
      end
    end
  end
end
