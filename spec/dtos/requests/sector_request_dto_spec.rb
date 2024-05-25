require "rails_helper"

RSpec.describe Requests::SectorRequestDto do
  let(:name) { 'Bebidas' }
  subject { described_class.new(name: name) }

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

  describe '#initialize' do
    it 'assigns the name correctly' do
      expect(subject.name).to eq(name)
    end
  end
end
