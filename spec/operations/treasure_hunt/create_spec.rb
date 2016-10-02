# frozen_string_literal: true

require_relative './shared_examples.rb'
require 'rails_helper'

describe TreasureHunt::Create do
  let(:run) { described_class.run(params) }
  let(:result) { run[0] }
  let(:operation) { run[1] }
  let(:params) { {} }

  describe 'validations' do
    subject { operation }
    it_behaves_like 'validate presence of', :email
    it_behaves_like 'validate presence of', :current_location
  end

  describe '.contract' do
    subject { described_class.contract }

    describe 'coercions' do
      it 'coerces current_location to Point' do
        expect(subject.definitions['current_location'][:type])
          .to be CustomTypes::Point
      end
    end
  end

  describe '#process' do
    let(:treasure) { create(:treasure, :cracow) }
    let(:hunt) { build(:hunt, :cracow) }
    let(:params) do
      {
        treasure_location: treasure.location,
        current_location: hunt.current_location.coordinates,
        email: hunt.email,
      }
    end
    subject { run }

    it { expect { subject }.to change(Hunt, :count) }
  end
end
