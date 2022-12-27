require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do 
  let(:food_truck) {FoodTruck.new("Rocky Mountain Pies")}
  let(:item1) {Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})}
  let(:item2) {Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})}

  describe '#initialize' do 
    it 'exists and has a name and inventory' do 
      expect(food_truck.name).to eq("Rocky Mountain Pies")
      expect(food_truck.inventory).to eq({})
    end
  end

  describe '#check_stock' do 
    it 'returns 0 if there is none of the given item in stock' do 
      expect(food_truck.check_stock(item1)).to eq(0)
    end
  end

  describe '#stock' do 
    it 'adds items to the inventory and can check them' do 
      food_truck.stock(item1, 30) 

      expected = {item1 => 30}

      expect(food_truck.inventory).to eq(expected)
      expect(food_truck.check_stock(item1)).to eq(30)

      food_truck.stock(item2, 12) 

      new_expected = {item1 => 30, item2 => 12}

      expect(food_truck.inventory).to eq(new_expected)
    end
  end

  describe '#potential_revenue' do 
    it 'is the sum of all their items price times quantity' do 
      food_truck.stock(item1, 30) 
      food_truck.stock(item2, 12) 
      
      expect(food_truck.potential_revenue).to eq(142.50)
    end

  end
end
