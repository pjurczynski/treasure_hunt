# frozen_string_literal: true
require 'rails_helper'

describe Analytics::Index do
  let(:collection) { described_class.present(params).model }

  describe '#model!' do
    context 'with start and end time' do
      before { Timecop.freeze }
      after { Timecop.return }

      let(:params) { { start_time: 1.day.ago, end_time: 1.day.from_now } }

      it 'returns hunts from the time frame' do
        create(:hunt, created_at: 2.days.ago)
        create(:hunt, created_at: 2.days.from_now)
        searched_hunt = create(:hunt)

        aggregate_failures do
          expect(collection.count).to eq 1
          expect(collection).to include(searched_hunt)
        end
      end

      context 'with range' do
        let(:params) { { start_time: 1.day.ago, end_time: 1.day.from_now, range: 10 } }

        it 'returns hunts from the time frame' do
          create(:hunt, current_location: Utils.point(longitude: 0.00011, latitude: 0))
          create(:hunt, current_location: Utils.point(longitude: 0, latitude: 0.00011))

          hunts_within_range = [
            create(:hunt, current_location: Utils.point(longitude: 0, latitude: 0)),
            create(:hunt, current_location: Utils.point(longitude: 0.00009, latitude: 0)),
          ]

          aggregate_failures do
            expect(collection.count).to eq 2
            expect(collection.pluck(:id)).to match(hunts_within_range.map(&:id))
          end
        end
      end
    end
  end
end
