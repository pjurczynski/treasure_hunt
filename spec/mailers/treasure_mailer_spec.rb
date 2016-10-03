# frozen_string_literal: true

require 'rails_helper'

shared_examples 'sends email to' do |test_email|
  it { expect(subject.to).to include test_email }
end

shared_examples 'exclaims that you are' do |ordinalized|
  it 'expresses whech treasure hunter you are' do
    expect(subject.body.to_s).to match "You are #{ordinalized} treasure hunter"
  end
end

describe TreasureMailer do
  describe '#found' do
    subject { described_class.found('winner@example.com', found_treasure_count) }

    let(:found_treasure_count) { 1 }

    it_behaves_like 'sends email to', 'winner@example.com'
    it_behaves_like 'exclaims that you are', '1st'

    context 'treasure hounters count is 0' do
      let(:found_treasure_count) { 1 }

      it_behaves_like 'sends email to', 'winner@example.com'
      it_behaves_like 'exclaims that you are', '1st'
    end

    context 'email is nil' do
      subject { described_class.found(nil, 1) }

      it { expect(subject.to).to be_empty }
    end
  end
end
