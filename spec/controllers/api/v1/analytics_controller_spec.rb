# frozen_string_literal: true
require 'rails_helper'

shared_examples 'runs analytics index operation' do
  it 'uses operation' do
    allow(operation).to receive(:present).and_call_original
    subject
    expect(operation).to have_received(:present).with(controller.params)
  end
end

describe Api::V1::AnalyticsController do
  it_behaves_like 'authenticates api token'
  it_behaves_like 'has throttle'

  describe 'GET index' do
    let(:operation) { Analytics::Index }
    let(:params) { { start_time: 1.day.ago, end_time: 1.day.from_now } }

    subject { post :index, params: params }

    it { is_expected.to have_http_status :ok }
    it_behaves_like 'runs analytics index operation'

    fit 'returns expected json structure' do
      hunt = create(:hunt, current_location: Utils.point(longitude: 0.0, latitude: 0.0))

      subject

      aggregate_failures do
        expect(json_response[:status]).to eq 'ok'
        json_response[:requests].each do |row|
          expect(row[:email]).to eq hunt.email
          expect(row[:current_location]).to eq [0.0, 0.0]
        end
      end
    end
  end
end
