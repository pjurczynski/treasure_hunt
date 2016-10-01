# frozen_string_literal: true
require 'spec_helper'
require_relative '../../../../../app/serializers/api/v1/treasure_hunt/create_serializer'

describe API::V1::TreasureHunt::CreateSerializer do
  let(:operation_double) { double('operation', contract: double('contract', distance: 0)) }
  subject { described_class.new(operation_double) }

  it { expect(subject.status).to eq 'ok' }
  it { expect(subject.distance).to eq 0 }
end
