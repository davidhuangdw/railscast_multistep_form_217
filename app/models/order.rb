class Order < ActiveRecord::Base
  # validates :billing_name, presence:true, on: [:create, :update, :billing_step]
  validates_presence_of :shipping_name, on: [:create, :update, :shipping_step]
end
