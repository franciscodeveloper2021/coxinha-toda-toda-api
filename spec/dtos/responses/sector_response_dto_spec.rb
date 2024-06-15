require "rails_helper"

RSpec.describe Responses::SectorResponseDto do
  let(:id) { 1 }
  let(:name) { 'Bebidas' }
  let(:subject) { described_class.new(id: id, name: name) }

  describe '#initialize' do
    context "when name has leading or trailing spaces" do
      it 'removes leading and trailing spaces from the name' do
        name_with_spaces = '  Bebidas  '

        subject

        expect(subject.name).to eq('Bebidas')
      end
    end

    context "when name is in rightly formatted" do
      it 'assigns the id correctly' do
        expect(subject.id).to eq(id)
      end

      it 'assigns the name correctly' do
        expect(subject.name).to eq(name)
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
    end

    context "with ruby dynamic type checking" do
      it "ensures ruby dynamic type checking for id" do
        expect(id).to be_a(Integer)
      end

      it "ensures ruby dynamic type checking for name" do
        expect(name).to be_a(String)
      end
    end
  end
end
