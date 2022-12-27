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
end
