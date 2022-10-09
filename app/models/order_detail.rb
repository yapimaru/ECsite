class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def subtotal
    item.with_tax_price * amount
  end

  enum making_status: { impossible: 0, wait: 1, making: 2, complete: 3 }
end
