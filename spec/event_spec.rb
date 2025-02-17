require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do 
  let(:event) {Event.new("South Pearl Street Farmers Market")}

  let(:food_truck1) {FoodTruck.new("Rocky Mountain Pies")}
  let(:food_truck2) {FoodTruck.new("Ba-Nom-a-Nom")}
  let(:food_truck3) {FoodTruck.new("Palisade Peach Shack")}

  let(:item1) {Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})}
  let(:item2) {Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  describe '#initialize' do 
    it 'exists and has a name and list of food trucks' do 
      expect(event).to be_a(Event)
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])

      allow(event).to receive(event.start_date(Time.new(2015, 02, 01))).and_return('01/02/2015')
      expect(event.start_date(Time.new(2015, 02, 01))).to eq('01/02/2015')
    end
  end

  describe '#add_food_truck and #food_truck_names' do 
    it 'adds food trucks with items to the list of food trucks and their names' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)

      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#food_trucks_that_sell' do 
    it 'returns food trucks that sell a given item' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)

      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end
  end

  describe '#overstocked_items' do 
    it 'returns a list of overstocked items(sold by more than 1 truck and quantity over 50' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3) 

      expect(event.overstocked_items).to eq([item1])
    end
  end

  describe '#all_item_names' do 
    it 'returns a list of names of all items on the trucks, sorted alphabetically' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3) 

      expect(event.all_item_names).to eq(['Apple Pie (Slice)', "Banana Nice Cream", 'Peach Pie (Slice)', "Peach-Raspberry Nice Cream"])
    end
  end

  describe '#item_inventory_hash' do 
    it 'can return a list of items and its quantity and trucks its sold on' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)  

      expected = {
                  item1 => {quantity: 100, sold_on: [food_truck1, food_truck3]},
                  item2 => {quantity: 7, sold_on: [food_truck1]},
                  item3 => {quantity: 25, sold_on: [food_truck2]}, 
                  item4 => {quantity: 50, sold_on: [food_truck2]}                
      }

      expect(event.item_inventory_hash).to eq(expected)
    end
  end

  describe '#can_sell_item' do 
    it 'can sell an item of a given amount, return true if it is available false if not' do 
      food_truck1.stock(item1, 35)    
      food_truck1.stock(item2, 7)  

      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)

      food_truck3.stock(item1, 65)  

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)  

      expect(event.can_sell_item?(item1, 5)).to eq(true)
      expect(event.can_sell_item?(item2, 2)).to eq(true)
      expect(event.can_sell_item?(item3, 5)).to eq(true)

      food_truck1_inventory = {
                                item1 => 30, 
                                item2 => 5

      }

      food_truck2_inventory = { 
                                item4 => 50,
                                item3 => 20
      }

      expect(event.can_sell_item?(item2, 10)).to eq(false)
      expect(food_truck1.inventory).to eq(food_truck1_inventory)
    end
  end
end
