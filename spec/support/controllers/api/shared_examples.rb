# frozen_string_literal: true
shared_examples 'authenticates api token' do
  it 'adds before filter to authenticate apis' do
    expect(controller._process_action_callbacks.map(&:filter))
      .to include(:authenticate_api_token!)
  end
end
