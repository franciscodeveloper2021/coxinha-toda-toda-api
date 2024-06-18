require "rails_helper"

RSpec.describe UseCases::Product::DestroyProductService do
  let(:repository) { ProductRepository.new }
  let(:subject) { described_class.new(repository) }

  let(:product_id) { 1 }

  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Product",
      key: "id",
      value: product_id
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
        allow(repository).to receive(:destroy).with(id: product_id).and_raise(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )

        expect { subject.call(id: product_id) }.to raise_error(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )
      end
    end

    context "with valid id" do
      it "calls destroy on the repository" do
        expect(repository).to receive(:destroy).with(id: product_id)

        subject.call(id: product_id)
      end
    end
  end
end
