module Paginatable
  extend ActiveSupport::Concern

  SIZE = 18

  module ClassMethods
    def paginate(params)
      page(params[:page]).per(SIZE)
    end
  end
end
