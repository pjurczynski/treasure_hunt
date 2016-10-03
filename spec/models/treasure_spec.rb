# frozen_string_literal: true

require 'rails_helper'

describe Treasure do
  describe '.current' do
    subject { described_class.current }

    context 'no treasures in database' do
      it { expect(subject.location.coordinates).to eq [0.0, 0.0] }
    end

    context 'there is a treasure in database' do
      it 'returns last treasure' do
        treasure = create(:treasure)
        expect(subject).to eq treasure
      end
    end
  end
end
