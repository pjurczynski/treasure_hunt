# frozen_string_literal: true

shared_examples 'validate presence of' do |attribute|
  it { expect(subject.errors[attribute]).to include(I18n.t('errors.messages.blank')) }
end

shared_examples 'coerces type' do |attribute, type|
  subject { described_class.contract }

  it "coerces #{attribute} to #{type}" do
    expect(subject.definitions[attribute][:type]).to be type
  end
end
