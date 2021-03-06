require 'rails_helper'

RSpec.describe Chef, type: :model do
  before :each do
    @guy = Chef.create!(name: 'Guy Fieri')
    create_ingredients
    create_burger_for_guy
    create_nachos_for_guy
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it { should have_many :dishes }
    it { should have_many(:dish_ingredients).through(:dishes) }
    it { should have_many(:ingredients).through(:dish_ingredients) }
  end

  describe 'instance methods' do
    describe '#ingredients_used' do
      it 'should return alpha-sorted unique list of ingredients from all dishes' do
        expect(@guy.ingredients_used).to eq([@bun, @cheese, @chip, @jalepeno, @meat])
      end
    end
  end

  def create_ingredients
    @bun = Ingredient.create!(name: 'Bun', calories: 10)
    @meat = Ingredient.create!(name: 'Meat', calories: 50)
    @chip = Ingredient.create!(name: 'Chips', calories: 10)
    @cheese = Ingredient.create!(name: 'Cheese', calories: 60)
    @jalepeno = Ingredient.create!(name: 'Jalepeno', calories: 5)
  end

  def create_burger_for_guy
    @burger = @guy.dishes.create!(name: 'Burger', description: 'A classic.')
    @burger.ingredients << @bun
    @burger.ingredients << @meat
    @burger.ingredients << @jalepeno
  end

  def create_nachos_for_guy
    @nachos = @guy.dishes.create!(name: 'Nachos', description: "You can't go wrong with this.")
    @nachos.ingredients << @chip
    @nachos.ingredients << @cheese
    @nachos.ingredients << @jalepeno
  end
end
