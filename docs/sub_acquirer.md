# Sub-Acquirer

A sub-acquirer, also known as a payment
facilitator or payment aggregator, is an entity that acts as an intermediary
between merchants and acquirers. Sub-acquirers aggregate the transactions of
multiple smaller merchants and process them under their own merchant account.
They simplify the onboarding process for smaller merchants by providing a
consolidated platform for payment acceptance.

**Money Flow:**

The cardholder initiates a transaction at a merchant location. The merchant
submits the transaction details to the sub-acquirer for processing. The
sub-acquirer aggregates and processes the transactions under its own merchant
account. The sub-acquirer communicates with the acquirer to obtain authorization
and facilitate settlement. If the transaction is approved, the sub-acquirer
transfers the funds from its account to the merchant's account, deducting their
fees.

**Information Flow:**

The merchant securely transmits the transaction details to the sub-acquirer. The
sub-acquirer encrypts and forwards the transaction details to the acquirer. The
acquirer validates the transaction, communicates with the payment network, and
relays the authorization response back to the sub-acquirer. The sub-acquirer
receives the response and communicates it to the merchant, allowing them to
proceed or decline the transaction.

___
[Back](README.md)