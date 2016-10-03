# frozen_string_literal: true
require 'rails_helper'

shared_examples 'runs operation' do
  it 'uses operation' do
    subject
    expect(operation).to have_received(:run).with(
      controller.params.merge(treasure_location: treasure.location),
    )
  end
end

describe Api::V1::TreasureHuntsController do
  it_behaves_like 'authenticates api token'
  it_behaves_like 'has throttle'

  describe 'POST create' do
    let(:operation) { TreasureHunt::Create }
    before { allow(operation).to receive(:run).and_call_original }

    subject { post :create, params: params }

    context 'with location within the range of the event' do
      let!(:treasure) { create(:treasure, :cracow) }
      let(:hunt) { build(:hunt, :cracow) }
      let(:params) do
        {
          current_location: hunt.current_location.coordinates,
          email: hunt.email,
        }
      end

      it { is_expected.to have_http_status :created }
      it_behaves_like 'runs operation'

      it 'returns expected json structure' do
        subject
        aggregate_failures do
          expect(json_response[:status]).to eq 'ok'
          expect(json_response[:distance]).to eq 0
        end
      end

      context 'sending location when already won' do
        before { hunt.save }

        it { is_expected.to have_http_status :ok }
        it_behaves_like 'runs operation'

        it 'returns expected json structure' do
          subject
          aggregate_failures do
            expect(json_response[:status]).to eq 'ok'
            expect(json_response[:distance]).to eq 0
          end
        end
      end
    end

    context 'with location out of the range of the event' do
      let(:treasure) { create(:treasure, :cracow) }
      let(:params) do
        {
          current_location: [treasure.location.x, treasure.location.y + 0.000_06],
          email: 'test@example.com',
        }
      end

      it { is_expected.to have_http_status :created }
      it_behaves_like 'runs operation'

      it 'returns expected json structure' do
        subject
        aggregate_failures do
          expect(json_response[:status]).to eq 'ok'
          expect(json_response[:distance]).to eq 6
        end
      end
    end

    context 'invalid request' do
      let(:params) { {} }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'returns expected json structure' do
        subject
        aggregate_failures do
          expect(json_response[:status]).to eq 'error'
          expect(json_response[:distance]).to eq(-1)
          expect(json_response[:error])
            .to eq [
              "Email can't be blank",
              "Current location can't be blank",
            ].join(', ')
        end
      end
    end
  end
end
