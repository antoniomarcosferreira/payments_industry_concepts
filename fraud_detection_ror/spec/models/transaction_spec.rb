# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe '.create' do
    context 'with valid attributes' do
      it 'creates a new transaction' do
        expect { create(:transaction) }.to change(Transaction, :count).by(1)
      end

      it 'saves the transaction' do
        transaction = create(:transaction)
        expect(transaction.persisted?).to be_truthy
      end

      it 'assigns attributes correctly' do
        transaction = create(:transaction, transaction_id: 123_456, merchant_id: 12_345)
        expect(transaction.transaction_id).to eq(123_456)
        expect(transaction.merchant_id).to eq(12_345)
      end
    end

    context 'with invalid attributes' do
      it 'raises an error' do
        expect { create(:transaction, card_number: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
