require "rails_helper"

RSpec.describe UseCases::Sector::DestroySectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }

  let(:sector_id) { 1 }

  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Sector",
      key: "id",
      value: sector_id
    )
  }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "with invalid id" do
      it "raises a ActiveRecord::RecordNotFound error" do
        allow(repository).to receive(:destroy).with(id: sector_id).and_raise(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )

        expect { subject.call(id: sector_id) }.to raise_error(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )
      end
    end

    context "with valid id" do
      it "calls destroy on the repository" do
        expect(repository).to receive(:destroy).with(id: sector_id)

        subject.call(id: sector_id)
      end
    end
  end
end
