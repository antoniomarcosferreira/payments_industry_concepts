# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/transactions', type: :request do # rubocop:todo Metrics/BlockLength
  let(:valid_attributes) do
    { transaction_id: 2_342_357, merchant_id: 29_744, user_id: 97_051, card_number: '434505******9116',
      transaction_date: '2019-11-31T23:16:32.812632', transaction_amount: 373, device_id: 285_475 }
  end

  let(:invalid_attributes) do
    { user_id: 97_051, card_number: '434505******9116',
      transaction_date: '2019-11-31T23:16:32.812632', transaction_amount: 373, device_id: 285_475 }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get '/', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /evaluate' do # rubocop:todo Metrics/BlockLength
    before do
      CSV.foreach(file_fixture('sample.csv'), headers: true) do |row|
        Transaction.create!(row.to_hash)
      end
    end

    context 'with approved parameters' do
      it 'return a approved Transaction' do
        expect do
          post '/evaluate',
               params: { transaction: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Transaction, :count).by(1)
      end

      it 'renders a JSON response with the results of the transaction evaluate' do
        post '/evaluate',
             params: { transaction: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with deny parameters' do # rubocop:todo Metrics/BlockLength
      it 'return a deny Transaction Invalid' do
        post '/evaluate',
             params: { transaction: invalid_attributes }, headers: valid_headers, as: :json
        ret = JSON.parse(response.body)
        expect(ret['recommendation']).to eq('deny')
      end

      it 'reject transaction if user is trying too many transactions in a row' do
        post '/evaluate',
             params: { transaction: { transaction_id: 21_323_593, merchant_id: 9603, user_id: 59_275,
                                      # rubocop:todo Layout/LineLength
                                      card_number: '528052******3611', transaction_date: '2019-11-01T11:50:01.404963', transaction_amount: 245.20 } },
             # rubocop:enable Layout/LineLength
             headers: valid_headers, as: :json
        expect(JSON.parse(response.body)['recommendation']).to eq('deny')
      end

      it 'reject transactions above a certain amount in a given period' do
        post '/evaluate',
             params: { transaction: { transaction_id: 21_323_590, merchant_id: 15_140, user_id: 38_415,
                                      card_number: '544731******7009',
                                      transaction_date: '2019-11-01T20:33:11.280461', transaction_amount: 4580.00 } },
             headers: valid_headers, as: :json
        expect(JSON.parse(response.body)['recommendation']).to eq('deny')
      end

      it 'reject transaction if a user had a chargeback before' do
        post '/evaluate',
             params: { transaction: { transaction_id: 21_323_596, merchant_id: 17_348, user_id: 8,
                                      card_number: '650487******9884',
                                      transaction_date: '2019-11-01T01:27:15.811098', transaction_amount: 2416.70 } },
             headers: valid_headers, as: :json
        expect(JSON.parse(response.body)['recommendation']).to eq('deny')

        # change value to aprove
        post '/evaluate',
             params: { transaction: { transaction_id: 21_323_596, merchant_id: 17_348, user_id: 8,
                                      card_number: '650487******9884',
                                      # rubocop:todo Layout/LineLength
                                      transaction_date: '2019-11-01T01:27:15.811098', transaction_amount: 2516.70 } }, headers: valid_headers, as: :json
        # rubocop:enable Layout/LineLength
        expect(JSON.parse(response.body)['recommendation']).to eq('approve')
      end
    end
  end
end
