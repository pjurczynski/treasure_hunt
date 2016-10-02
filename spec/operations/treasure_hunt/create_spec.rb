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
    context 'with location within the range of the event' do
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

      it { expect { subject }.to change(Hunt, :count).by(1) }

      it 'sets distance' do
        subject
        expect(operation.contract.distance).to eq 0
      end

      it 'sends an email' do
        expect { subject }.to have_enqueued_job.on_queue('mailers')
      end

      context 'sending location when already won' do
        before { subject }
        it { expect { subject }.not_to have_enqueued_job.on_queue('mailers') }
        it { expect { subject }.not_to change(Hunt, :count) }
      end
    end

    context 'with location out of the range of the event' do
      let(:treasure) { create(:treasure, :cracow) }
      let(:hunt) { build(:hunt, current_location: Utils.point(latitude: 1, longitude: 1)) }
      let(:params) do
        {
          treasure_location: treasure.location,
          current_location: hunt.current_location.coordinates,
          email: hunt.email,
        }
      end
      subject { run }

      it { expect { subject }.to change(Hunt, :count).by(1) }

      it 'sets distance' do
        subject
        expect(operation.contract.distance).to eq 5_737_706
      end

      it 'sends an email' do
        expect { subject }.not_to have_enqueued_job.on_queue('mailers')
      end
    end

    context 'without passing validation' do
      subject { run }
      it { expect { subject }.not_to change(Hunt, :count) }
      it { expect { subject }.not_to have_enqueued_job.on_queue('mailers') }
    end
  end
end
