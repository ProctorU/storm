class PingSerializer < ActiveModel::Serializer
  attributes(
    :id, :status, :created_at, :status_badge, :status_text
  )

  def created_at
    object.created_at.strftime('%B %e, %Y at %l:%M%P')
  end
end
