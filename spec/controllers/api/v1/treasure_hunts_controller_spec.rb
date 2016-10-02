# frozen_string_literal: true

require 'rails_helper'

describe API::V1::TreasureHuntsController do
  describe 'POST create' do
    subject { post :create, params: params }

    context 'with location within the range of the event' do
      before { create(:treasure, :cracow) }
      let(:hunt) { build(:hunt, :cracow) }
      let(:params) do
        {
          current_location: hunt.current_location.coordinates,
          email: hunt.email,
        }
      end

      it { is_expected.to have_http_status :created }
      it { expect { subject }.to change(Hunt, :count) }

      it 'returns expected json structure' do
        subject
        aggregate_failures do
          expect(json_response[:status]).to eq 'ok'
          expect(json_response[:distance]).to eq 0
        end
      end

      it 'sends an email'
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
              "Treasure location can't be blank",
            ].join(', ')
        end
      end

      it "doesn't send an email"
      it "doesn't create a new hunt"
    end
  end
end
