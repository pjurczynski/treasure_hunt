# frozen_string_literal: true
require 'rails_helper'

describe API::V1::TreasureHuntsController do
  describe 'POST create' do
    context 'with location within the range of the event' do
      subject { post :create }

      it { is_expected.to have_http_status :ok }
    end
  end
end
