# frozen_string_literal: true
require 'rails_helper'

describe WithinRadiusQuery do
  describe '#call' do
    let(:latitude) { 50.051227 }
    let(:longitude) { 19.945704 }
    let(:one_meter) { 0.00001 }

    let!(:hunt) do
      create(
        :hunt,
        current_location: Utils.point(longitude: longitude, latitude: latitude + 0.00004),
      )
    end

    let!(:not_found) do
      create(
        :hunt,
        current_location: Utils.point(longitude: longitude, latitude: latitude + 0.00006),
      )
    end

    subject do
      described_class.new(
        relation: Hunt,
        column: :current_location,
        point: Utils.point(latitude: latitude, longitude: longitude),
        radius: 5,
      )
    end

    it { expect(subject.call).to be_a Hunt::ActiveRecord_Relation }
    it 'finds only a hunt within a range' do
      expect(subject.call.count).to eq(1)
    end
  end
end
