require "rails_helper"

RSpec.describe Requests::SectorRequestDto do
  let(:name) { 'Bebidas' }
  subject { described_class.new(name: name) }

  describe '#initialize' do
    context "when name has leading or trailing spaces" do
      it 'removes leading and trailing spaces from the name' do
        name_with_spaces = '  Bebidas  '

        subject = described_class.new(name: name_with_spaces)

        expect(subject.name).to eq('Bebidas')
      end
    end

    context "when name is in the rightly formatted" do
      it 'assigns the name correctly' do
        expect(subject.name).to eq(name)
      end
    end
  end

  describe "type checking" do
    context "with sorbet static type checking" do
      context "when name is not a String" do
        it "raises a TypeError" do
          name = 123

          expect { T.assert_type!(name, String) }.to raise_error(TypeError)
        end
      end
    end

    context "with ruby dynamic type checking" do
      it "ensures ruby dynamic type checking for name" do
        expect(name).to be_a(String)
      end
    end
  end
end
