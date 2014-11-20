class OrderSerializer < ActiveModel::Serializer
  attributes :id, :billing_name, :shipping_name
end
