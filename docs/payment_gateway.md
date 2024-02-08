# Payment Gateway

A payment gateway is a
technology solution that enables the secure transmission of transaction data
between merchants, acquirers, and payment networks. Payment gateways provide the
necessary infrastructure for online and card-present transactions, facilitating
the authorization and settlement process.

**Money Flow:**

The cardholder initiates a transaction on the merchant's website or through
another online platform. The transaction details are securely transmitted to the
payment gateway. The payment gateway encrypts and transfers the transaction
details to the acquirer for processing. The acquirer communicates with the
payment network to obtain authorization and facilitate settlement. If the
transaction is approved, the acquirer transfers the funds from the cardholder's
account to the merchant's account, deducting applicable fees.

**Information Flow:**

The transaction details are securely transmitted from the merchant's website or
online platform to the payment gateway. The payment gateway encrypts and
forwards the transaction details to the acquirer. The acquirer validates the
transaction, communicates with the payment network, and relays the authorization
response back to the payment gateway. The payment gateway receives the response
and communicates it to the merchant's website or online platform, allowing them
to proceed or decline the transaction.

In summary, an acquirer directly
processes transactions on behalf of merchants, while a sub-acquirer aggregates
transactions from multiple merchants and processes them under their own account.

A payment gateway facilitates the secure transmission of transaction data
between merchants, acquirers, and payment networks, without directly processing
the transactions itself. The money flow and information flow vary slightly for
each player, but the overall objective remains the same: to enable secure and
efficient payment processing.

___
[Back](README.md)