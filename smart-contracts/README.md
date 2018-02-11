# @Patrecoin/Smart-Contracts

This package contains the smart contract subscription code for Patrecoin. Built using the truffle framework.

## Development

- Install dependencies
```
npm install
```

- To compile the code, run
```
npm run compile
```


- To run the tests, first start ganache, then run
```
npm test
```

## Structs

- Producer
  - lastChargedDate (uint) - Date that producer last executes the charge function
  - subscribers (Subscription[]) - see Subscription struct

- Subscriptions
  - account (address) - Address of subscriber
  - lastPaymentDate (uint) - Date the subscriber last paid. Defaults to date of subscription
  - chargePerSecond (uint) - Optional. Used to calculate payment.

- Subscriber 
  - balance (uint) - current ETH deposited
  - subscribedTo (Producer[]) - active subscriptions

## Functions
- To be detailed
