# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  SIZE = 18

  included do
    max_pages(20)
  end

  module ClassMethods
    def paginate(params)
      page(params[:page]).per(SIZE)
    end
  end
end
