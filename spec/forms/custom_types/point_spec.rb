# frozen_string_literal: true

require_relative '../../../app/forms/custom_types/point.rb'

describe CustomTypes::Point do
  subject { described_class }

  describe '.call' do
    it 'converts array to postgres POINT' do
      expect(subject.call([1, 1]))
        .to be_a RGeo::Geographic::SphericalPointImpl
    end

    it 'returns self if value is not an array' do
      aggregate_failures do
        expect(subject.call('string')).to eq 'string'
        expect(subject.call(1)).to eq 1
        expect(subject.call(nil)).to eq nil
      end
    end
  end
end
