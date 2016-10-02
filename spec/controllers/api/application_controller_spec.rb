# frozen_string_literal: true
require 'rails_helper'

describe API::ApplicationController do
  it_behaves_like 'authenticates api token'

  describe '#authenticate_api_token!' do
    context 'without token header' do
      before { controller.request.headers['API_TOKEN'] = nil }

      it 'raises not authenticated error' do
        expect { controller.authenticate_api_token! }
          .to raise_error(API::ApplicationController::NotAuthenticated)
      end
    end
    context 'with token header' do
      # api token is added by the example group automatically

      it 'returns nil' do
        expect(controller.authenticate_api_token!).to eq nil
      end
    end
  end
end
