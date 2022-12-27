class Event 
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name 
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names 
    @food_trucks.map do |truck| 
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck| 
      truck.inventory.has_key?(item)
    end
  end

  def overstocked_items 
    all_event_items.flatten.find_all do |item| 
       food_trucks_that_sell(item).count >= 2 && item_quantity_on_trucks_that_sell_item(item) > 50
    end.uniq 
  end

  def all_event_items 
    @food_trucks.map do |truck| 
      truck.all_truck_items
    end
  end

  def item_quantity_on_trucks_that_sell_item(item)
    food_trucks_that_sell(item).sum do |truck| 
      truck.inventory[item]
    end
  end

  def all_item_names 
    @food_trucks.flat_map do |truck| 
      truck.all_item_names_on_truck
    end.sort.uniq
  end

end

