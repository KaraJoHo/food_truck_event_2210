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
    end
  end

end
