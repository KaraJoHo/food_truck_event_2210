class FoodTruck 
  attr_reader :name, :inventory 

  def initialize(name)
    @name = name 
    @inventory = Hash.new(0)
  end

  def check_stock(item) 
   if @inventory.has_key?(item) == false 
    @inventory[item]
   else 
    @inventory[item]
   end
  end

  def stock(item, amount)
    @inventory[item] = amount
  end

  def potential_revenue 
    @inventory.sum do |item, quantity| 
      (item.price * quantity).round(2)
    end
  end

  def all_truck_items 
    @inventory.keys
  end

  def all_item_names_on_truck 
    @inventory.map do |item, quantity| 
      item.name
    end
  end
end