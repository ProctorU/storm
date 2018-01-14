class PingSerializer < ActiveModel::Serializer
  attributes(
    :id, :status, :created_at, :status_badge, :status_text
  )
end
