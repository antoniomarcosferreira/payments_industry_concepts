# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    transaction_id { 2_342_357 }
    merchant_id { 29_744 }
    user_id { 97_051 }
    card_number { '434505******9116' }
    transaction_date { '2019-11-31T23:16:32.812632' }
    transaction_amount { 373 }
    device_id { 285_475 }
  end
end
