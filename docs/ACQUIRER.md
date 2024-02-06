# Acquirer

An acquirer also known as a merchant bank or acquiring bank, is a financial
institution that enters into agreements with merchants to process their payment
card transactions. Acquirers have direct relationships with payment networks
(such as Visa, Mastercard, etc.) and are responsible for facilitating the
authorization, settlement, and funding of transactions. They act as the primary
point of contact for merchants and handle the majority of transaction
processing.

**Money Flow:**

The cardholder initiates a transaction at a merchant location. The ~~merchant~~
submits the transaction details to the acquirer for processing. The acquirer
validates the transaction, communicates with the payment network, and obtains
authorization from the card issuer. If the transaction is approved, the acquirer
transfers the funds from the cardholder's account to the merchant's account,
deducting applicable fees.

**Information Flow:**

The merchant securely transmits the transaction details to the acquirer, who
encrypts and forwards the information to the payment network. The payment
network verifies the transaction details, communicates with the card issuer, and
relays the authorization response back to the acquirer. The acquirer receives
the response and communicates it to the merchant, allowing them to proceed or
decline the transaction.
