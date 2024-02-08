# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :transaction_id, :card_number, :transaction_date, :transaction_amount, presence: true

  MAX_CONSECUTIVE_TRANSACTIONS_BY_DAY = 10
 
  def self.check(merchant_id, user_id, transaction_amount, transaction_date)
    return :deny unless user_id.present? && transaction_amount.present? && transaction_date.present?
    return :deny if transaction_amount <= 0

    # use the last 5 days transactions to avaliate limits
    source = where(' DATE(transaction_date) >= DATE(?)', transaction_date - 5.days)

    margin = 1.3

    # value is egual the last value
    return :deny if duplicated?(user_id, transaction_amount, transaction_date)

    # value is grather then the max value for this client or this merchant_id
    return :deny if amount_exceeded?(source, merchant_id, user_id, margin, transaction_amount)

    # Max transactions by day
    return :deny if daily_count_exceeded?(user_id, transaction_date)

    return :deny if where(user_id:, transaction_amount:, has_cbk: true).exists?

    :approve
  end

  def self.duplicated?(user_id, transaction_amount, transaction_date)
    last_transaction = where(user_id:).where('DATE(transaction_date) = DATE(?)', transaction_date).last
    last_transaction && (transaction_amount == last_transaction.transaction_amount)
  end

  def self.amount_exceeded?(source, merchant_id, user_id, margin, transaction_amount)
    max_value_by_merchant_id = (merchant_id && source.where(merchant_id:).maximum(:transaction_amount)) || 0
    max_value_by_user_id = source.where(user_id:).maximum(:transaction_amount) || 0
    avg_value = source.average(:transaction_amount) || 0
    max_value = [max_value_by_merchant_id, max_value_by_user_id, avg_value].max * margin
    max_value > 0 && transaction_amount > max_value
  end

  def self.daily_count_exceeded?(user_id, transaction_date)
    daily_transactions_count = where(user_id:).where(' DATE(transaction_date) = DATE(?)', transaction_date).count
    daily_transactions_count_avg = where(user_id:).select('count(*) / count(DISTINCT DATE(transaction_date)) as v').first.v || 0
    daily_transactions_count_avg = [daily_transactions_count_avg, MAX_CONSECUTIVE_TRANSACTIONS_BY_DAY].max

    daily_transactions_count >= daily_transactions_count_avg
  end

end
