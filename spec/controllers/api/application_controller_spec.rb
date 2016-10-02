# frozen_string_literal: true
require 'rails_helper'

describe API::ApplicationController do
  it_behaves_like 'authenticates api token'
  it_behaves_like 'has throttle'

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

  describe '#check_throttle!' do
    context 'with email provided' do
      before { controller.params[:email] = 'some@example.com' }

      it { expect(controller.check_throttle!).to be_nil }

      it 'raises error on the 21st request that was made within an hour' do
        20.times { controller.check_throttle! }
        expect { controller.check_throttle! }
          .to raise_error(API::ApplicationController::TooManyRequestsPerHour)
      end
    end

    context 'with no email provided' do
      it { expect(controller.check_throttle!).to be_nil }

      it 'permits making more requests' do
        20.times { controller.check_throttle! }
        expect(controller.check_throttle!).to be_nil
      end
    end
  end
end
