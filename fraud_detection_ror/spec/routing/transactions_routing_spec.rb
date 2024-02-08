# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/').to route_to('transactions#index')
    end

    it 'routes to #evaluate' do
      expect(post: '/evaluate').to route_to('transactions#evaluate')
    end
  end
end
