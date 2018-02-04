pragma solidity ^0.4.0;

contract Subscriptions {
  // ETH charge per month
  uint public costPerMonth = 1;
  // need a mapping for producers and their subscribers
  // need an array of executions dates per month

  /** Subscribe
  Checks if sender is already subscribed to the producer. If they are
  not they will be added to the array. 
  
  This function execute if the sender and the subscriber are the same
  */

  /** Unsubscribe
  Checks if sender is already subscribed to the producer. If they are they 
  will be removed from the array. 

  This function execute if the sender and the subscriber are the same
  */

  /** Charge
  Allow contact to be excuted to request payment from subscribers. This
  can only be executed once per month. Caller of this function will recieve
  a small payout of the benefits
  */

  /** Create Producer
  Checks if sender is a producer, if not, adds them to the list of producers.

  This function execute if the sender and the producer are the same
  */

  
  /** Destroy Producer
  Checks if sender is a producer, if so, removes them from the list of producers.

  This function execute if the sender and the producer are the same
  */
}