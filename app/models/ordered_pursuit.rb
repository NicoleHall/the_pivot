class OrderedPursuit
  attr_reader :pursuit_id, :travellers, :price

  def initialize(pursuit_id, travellers, price)
    @pursuit_id = pursuit_id
    @travellers = travellers.abs
    @price = price
  end
end
