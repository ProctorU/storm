class WebsiteSerializer < ActiveModel::Serializer
  attributes(:id, :name, :url)

  has_many(:recent_pings, serializer: PingSerializer)
end
