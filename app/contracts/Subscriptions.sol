pragma solidity ^0.4.0;

contract Subscriptions {
  // ETH charge per week, in Gwei
  uint chargePerWeek = 10;

  // Service charge is 10%
  uint serviceCharge = 1;

  // Miner payment of 10%
  uint minerPayment = 1;

  // week in unix time
  uint week = 604800;

  // need a struct of Producers
  // Each producer has a public address
  // and a list of their subscribers
  struct Producer {
    address publicAddress;
    address[] subscribers;
    uint lastPayment;
  }

  mapping (address => Producer) public producers;

  // Subscriber
  // Each subscriber has a balance
  // and a list of people they are subscribed to
  struct Subscriber {
    uint balance; // defaults to zero
    address[] subscribedTo // defaults to empty array
  }

  mapping (address => Subscriber) public subscribers;
  
  event Subscribed(address subscriber, address subscribedTo);
  event Unsubscribed(address subscriber, address subscribedTo);
  event Deposited(address subscriber, uint deposit);
  event Charged(address producer, address[] subsribers, uint payout);

  // Deposit
  // Allow subscribers to deposit ETH
  // Will be used for weekly payouts
  // Non-refundable
  function deposit() public payable {
    Subscriber storage subscriber = subscribers[msg.sender];
    subscriber.balance += msg.value;
  }

  // need an event for subscribing, unsubscribing, etc.

  /** Subscribe
  Checks if sender is already subscribed to the producer. If they are
  not they will be added to the array. 
  
  This function execute if the sender and the subscriber are the same

  Emits a Subscribe event
  */
  function subscribe(address subscribeTo) public {
    // add subscribeTo address to subscriber if it doesn't exist
    // loop through subscribeTo array and subscribe
    Subscriber storage subscriber = subscribers[msg.sender];
    
    // add subscriber address to producer subcribers array
    Producer storage producer = producers[subscribeTo];
  }

  /** Unsubscribe
  Checks if sender is already subscribed to the producer. If they are they 
  will be removed from the array. 

  This function execute if the sender and the subscriber are the same
  
  Emit an Unsubscribe event
  */

  /** Charge
  Two design options:
  1 - Allow contact to be excuted by anyone to request payment from subscribers. This
  can only be executed once per week. Would total all subscribers payments and send eth to all producers.
  Possibly this could be very expensive. Caller of this function will recieve
  a small payout of the benefits. Possibly restrict this to subscribers and producers?
  
  2 - Allow contract to be executed by producer in order to collect weekly income.
  Slightly cumbersome user experience. Could allow automation for contract to be executed weekly on
  the producers behalf?
  */
}