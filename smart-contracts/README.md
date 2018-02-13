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
#### Producer
- lastChargedDate (uint) - Date that producer last executes the charge function.
- subscribers (Subscription[]) - see Subscription struct.

#### Subscriptions
- account (address) - Address of subscriber.
- lastPaymentDate (uint) - Date the subscriber last paid. Defaults to date of subscription.
- chargePerSecond (uint) - Used to calculate payment. Must be multiple of 10.

#### Subscriber 
- balance (uint) - current ETH deposited
- subscribedTo (Subscription[]) - active subscriptions

## Functions
#### Charge
- Charges all subscribers for a producer, applying the following logic:
```
Check that Producer has not called charge within a week of previous timestamp

For all producer subscriptions:

  Payment = (Block Timestamp - Last Payment Date) * Subscription Fee Per Second

  if (Account Balance >= Total Payment) 
  then 
    Service Charge = Total Payment / 10;
    Total Service Charge += Service Charge
    Total Payment += (Payment - Service Charge)

Record payment dates

Update Balances

Send Funds  
```
