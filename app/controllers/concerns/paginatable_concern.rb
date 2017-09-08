# PaginatableConcern
module PaginatableConcern
  extend ActiveSupport::Concern

  private

  def ivar
    instance_variable_get("@#{controller_name}")
  end

  def return_paginated_resource
    render json: {
      next: (
        render_to_string(
          'websites/_sliced.html.erb',
          locals: { websites: ivar },
          layout: false
        )
      ),
      link: (
        render_to_string(
          'websites/_next_page.html.erb',
          locals: { websites: ivar },
          layout: false
        )
      )
    }
  end
end
