class WebsiteSerializer < ActiveModel::Serializer
  attributes(:id, :name, :url, :active)

  has_many(:recent_pings, serializer: PingSerializer)
end
