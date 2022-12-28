class Event 
  attr_reader :name, :food_trucks, :start_date

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
    end.flatten
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

  def item_inventory_hash 
    item_inventory = {}

    all_event_items.each do |item|
      item_inventory[item] = {}
    end

     item_inventory.each do |item, value_hash| 
      value_hash = {quantity: item_quantity_on_trucks_that_sell_item(item), sold_on: food_trucks_that_sell(item).uniq}
      item_inventory[item] = value_hash
     end

    item_inventory
  end

  def start_date(date)
     date.strftime('%d/%m/%Y')
  end

  def can_sell_item?(item, quantity)
    if event_item_quantities_available?(item, quantity) == true
      first_truck_sells_item(item, quantity)
      true
    else 
      false
    end
  end

  def event_item_quantities_available?(item, quantity)
    food_trucks.any? do |truck| 
     truck.inventory[item] > quantity
    end
  end

  def first_truck_sells_item(item, quantity)
    food_trucks_that_sell(item).map do |truck| 
      if truck.inventory[item] != 0 
        truck.sell_item(item, quantity)
      end
      break if truck.inventory[item] != 0
    end
  end
end

