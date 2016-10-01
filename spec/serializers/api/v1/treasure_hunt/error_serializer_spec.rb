# frozen_string_literal: true
require 'spec_helper'
require_relative '../../../../../app/serializers/api/v1/treasure_hunt/create_serializer'

describe API::V1::TreasureHunt::ErrorSerializer do
  let(:operation_double) do
    double(
      'operation',
      errors: double('contract', full_messages: ['msg']),
    )
  end
  subject { described_class.new(operation_double) }

  it { expect(subject.status).to eq 'error' }
  it { expect(subject.distance).to eq(-1) }
  it { expect(subject.error).to eq 'msg' }
end
