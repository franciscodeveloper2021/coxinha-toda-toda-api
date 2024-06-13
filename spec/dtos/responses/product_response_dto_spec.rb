require "rails_helper"

RSpec.describe Responses::ProductResponseDto do
  let(:id) { 1 }
  let(:name) { 'Coca-Cola' }
  let(:description) { 'Refrigerante de cola' }
  let(:price) { 5.99 }
  let(:available) { true }
  let(:sector_id) { 2 }
  let(:subject) do
    described_class.new(
      id: id,
      name: name,
      description: description,
      price: price,
      available: available,
      sector_id: sector_id
    )
  end

  describe '#initialize' do
    context "when name and description have leading or trailing spaces" do
      it 'removes leading and trailing spaces from the name' do
        name_with_spaces = '  Coca-Cola  '

        subject

        expect(subject.name).to eq('Coca-Cola')
      end

      it 'removes leading and trailing spaces from the description' do
        description_with_spaces = '  Refrigerante de cola  '

        subject

        expect(subject.description).to eq('Refrigerante de cola')
      end
    end

    context "when attributes are rightly formatted" do
      it 'assigns the id correctly' do
        expect(subject.id).to eq(id)
      end

      it 'assigns the name correctly' do
        expect(subject.name).to eq(name)
      end

      it 'assigns the description correctly' do
        expect(subject.description).to eq(description)
      end

      it 'assigns the price correctly' do
        expect(subject.price).to eq(price)
      end

      it 'assigns the available correctly' do
        expect(subject.available).to eq(available)
      end

      it 'assigns the sector_id correctly' do
        expect(subject.sector_id).to eq(sector_id)
      end
    end
  end

  describe "type checking" do
    context "with sorbet static type checking" do
      context "when id is not an Integer" do
        it "raises a TypeError" do
          id = "1"

          expect { T.assert_type!(id, Integer) }.to raise_error(TypeError)
        end
      end

      context "when name is not a String" do
        it "raises a TypeError" do
          name = 123

          expect { T.assert_type!(name, String) }.to raise_error(TypeError)
        end
      end

      context "when description is not a String" do
        it "raises a TypeError" do
          description = 456

          expect { T.assert_type!(description, String) }.to raise_error(TypeError)
        end
      end

      context "when price is not a Float" do
        it "raises a TypeError" do
          price = "5.99"

          expect { T.assert_type!(price, Float) }.to raise_error(TypeError)
        end
      end

      context "when available is not a Boolean" do
        it "raises a TypeError" do
          available = "true"

          expect { T.assert_type!(available, T::Boolean) }.to raise_error(TypeError)
        end
      end

      context "when sector_id is not an Integer" do
        it "raises a TypeError" do
          sector_id = "2"

          expect { T.assert_type!(sector_id, Integer) }.to raise_error(TypeError)
        end
      end
    end

    context "with ruby dynamic type checking" do
      it "ensures ruby dynamic type checking for id" do
        expect(id).to be_a(Integer)
      end

      it "ensures ruby dynamic type checking for name" do
        expect(name).to be_a(String)
      end

      it "ensures ruby dynamic type checking for description" do
        expect(description).to be_a(String)
      end

      it "ensures ruby dynamic type checking for price" do
        expect(price).to be_a(Float)
      end

      it "ensures ruby dynamic type checking for available" do
        expect(available).to be_in([true, false])
      end

      it "ensures ruby dynamic type checking for sector_id" do
        expect(sector_id).to be_a(Integer)
      end
    end
  end
end
