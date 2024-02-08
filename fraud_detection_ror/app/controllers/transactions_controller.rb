# frozen_string_literal: true

class TransactionsController < ApplicationController # rubocop:todo Style/Documentation
  def index
    render json: { status: 'Working!' }
  end

  def evaluate
    @transaction = Transaction.new(transaction_params)

    recommendation = Transaction.check(@transaction.merchant_id, @transaction.user_id, @transaction.transaction_amount,
                                       @transaction.transaction_date)
    if recommendation == :approve
      @transaction.has_cbk = false
      recommendation = :deny unless @transaction.save
    end

    render json: { transaction_id: @transaction.transaction_id, recommendation: }
  end

  private

  def transaction_params
    params.require(:transaction).permit(:transaction_id, :merchant_id, :user_id, :card_number, :transaction_date,
                                        :transaction_amount, :device_id)
  end
end
