# frozen_string_literal: true
require 'rails_helper'

describe Throttler do
  let(:throttler) { described_class.new('some@example.com') }

  describe '#requested!' do
    it 'adds new set with the email' do
      throttler.requested!
      expect(throttler.redis.exists('email:some@example.com')).to be_truthy
    end

    it 'sets expire to 1 hour for a set' do
      throttler.requested!
      expect(throttler.redis.ttl('email:some@example.com')).to eq 1.hour
    end

    it 'resets expire to 1 hour, every time' do
      throttler.requested!
      throttler.redis.expire('email:some@example.com', 15.minutes)

      expect { described_class.new('some@example.com').requested! }
        .to change { throttler.redis.ttl('email:some@example.com') }
        .from(15.minutes)
        .to eq 1.hour
    end

    it 'stores a keys for separate requests' do
      throttler.requested!
      keys = throttler.redis.sscan('email:some@example.com', 0)[1]
      aggregate_failures do
        expect(keys.count).to eq 1
        expect(throttler.redis.exists("email:#{keys[0]}")).to be_truthy
        expect(throttler.redis.ttl("email:#{keys[0]}")).to eq 1.hour
      end
    end
  end

  describe '#max_reached?' do
    subject { throttler.max_reached? }

    context '20 requests were made' do
      before { 20.times { described_class.new('some@example.com').requested! } }

      it { is_expected.to be_truthy }
    end

    context '19 requests were made' do
      before { 19.times { described_class.new('some@example.com').requested! } }

      it { is_expected.to be_falsey }
    end

    context 'set has an old key that does not exist anymore' do
      before do
        throttler.requested!
        key = throttler.redis.sscan('email:some@example.com', 0)[1][0]
        throttler.redis.del("email:#{key}")
      end

      it 'clears a key from a set' do
        expect { subject }
          .to change { throttler.redis.scard('email:some@example.com') }.from(1).to(0)
      end
    end
  end
end
