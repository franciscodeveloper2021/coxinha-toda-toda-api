require "rails_helper"

RSpec.describe SectorResponseDTO do
  describe '#initialize' do
    let(:id) { 1 }
    let(:name) { 'Bebidas' }
    subject { described_class.new(id, name) }

    it 'assigns the id correctly' do
      expect(subject.id).to eq(id)
    end

    it 'assigns the name correctly' do
      expect(subject.name).to eq(name)
    end
  end
end
