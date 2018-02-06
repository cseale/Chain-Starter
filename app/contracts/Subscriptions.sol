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

  // need a mapping of subscriber address to their balance
  mapping (address => uint) public balances;

  // need a struct of Producers
  // Each producer has a public address
  // and a list of subscribers
  struct Producer {
    address publicAddress;
    address[] subscribers;
  }

  Producer[] public producers;
  
  // need to keep last execution in memory, cannot execute a charge call more than once a week
  uint lastExecution;

  // need an event for subscribing, unsubscribing, etc.

  /** Subscribe
  Checks if sender is already subscribed to the producer. If they are
  not they will be added to the array. 
  
  This function execute if the sender and the subscriber are the same

  Emits a Subscribe event
  */

  /** Unsubscribe
  Checks if sender is already subscribed to the producer. If they are they 
  will be removed from the array. 

  This function execute if the sender and the subscriber are the same
  
  Emit an Unsubscribe event
  */

  /** Charge
  Allow contact to be excuted to request payment from subscribers. This
  can only be executed once per week. Caller of this function will recieve
  a small payout of the benefits. Possibly restrict this to subscribers and producers?
  */

  /** Create Producer
  Checks if sender is a producer, if not, adds them to the list of producers.

  This function execute if the sender and the producer are the same
  
  Emits a create producer event
  */

  
  /** Destroy Producer
  Checks if sender is a producer, if so, removes them from the list of producers.

  This function execute if the sender and the producer are the same
  
  Emits a destroy producer event
  */

  /**
  Deposit Money
  */
}