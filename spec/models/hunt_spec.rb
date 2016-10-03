# frozen_string_literal: true
require 'rails_helper'

describe Hunt do
  describe '.wininng_locations' do
    it 'calls query' do
      query_class = WithinRadiusQuery
      query_instance = double('query')
      my_point = Utils.point(longitude: 1, latitude: 1)

      aggregate_failures do
        expect(query_class).to receive(:new).with(
          relation: Hunt,
          column: :current_location,
          point: my_point,
          radius: 5,
        ).and_return(query_instance)

        expect(query_instance).to receive(:call)
      end

      described_class.winning_locations(my_point)
    end
  end
end
