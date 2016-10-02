# frozen_string_literal: true

shared_examples 'validate presence of' do |attribute|
  it { expect(subject.errors[attribute]).to include(I18n.t('errors.messages.blank')) }
end
