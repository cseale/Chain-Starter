pragma solidity ^0.4.0;

contract Subscriptions {
  // service address
  address public serviceAddress;

  // ETH charge per week, in Gwei
  uint weeklyCharge = 9;

  // Service charge is 10%
  uint serviceCharge = 1;

  // week in unix time
  uint week = 604800;

  // need a struct of Producers
  // Each producer has a public address
  // and a list of their subscribers
  struct Producer {
    address[] subscribers;
    uint lastPayment;
  }

  mapping (address => Producer) producers;

  // Subscriber
  // Each subscriber has a balance
  // and a list of people they are subscribed to
  struct Subscriber {
    uint balance; // defaults to zero
    address[] subscribedTo; // defaults to empty array
  }

  mapping (address => Subscriber) subscribers;
  
  event Subscribed(address subscriber, address subscribedTo);
  event Unsubscribed(address subscriber, address subscribedTo);
  event Deposited(address subscriber, uint deposit  );
  event Charged(address producer, address[] subsribers, uint payout, uint service);


  function Subscriptions() public {
    serviceAddress = msg.sender;
  }

  // Deposit
  // Allow subscribers to deposit ETH
  // Will be used for weekly payouts
  // Non-refundable
  function deposit() public payable {
    Subscriber storage subscriber = subscribers[msg.sender];
    subscriber.balance += msg.value;
    Deposited(msg.sender, msg.value);
  }

  // subscribe()
  // Checks if sender is already subscribed to the producer. If they are
  // not they will be added to the array. 
  
  // This function execute if the sender and the subscriber are the same
  function subscribe(address subscribeTo) public {
    require(msg.sender != subscribeTo);
    // add subscribeTo address to subscriber if it doesn't exist
    // loop through subscribeTo array and subscribe
    Subscriber storage subscriber = subscribers[msg.sender];
    bool subscribedToExists = false;
    for (uint i = 0; i < subscriber.subscribedTo.length; i++) {
      if (subscriber.subscribedTo[i] == subscribeTo) {
        subscribedToExists = true;
        break;
      }
    }

    if (!subscribedToExists) {
      subscriber.subscribedTo.push(subscribeTo);
    }

    // add msg sender address to producer subcribers array
    Producer storage producer = producers[subscribeTo];
    bool subscriberExists = false;
    for (uint j = 0; j < producer.subscribers.length; j++) {
      if (producer.subscribers[i] == msg.sender) {
        subscriberExists = true;
        break;
      }
    }

    if (!subscriberExists) {
      producer.subscribers.push(msg.sender);
    }
    Subscribed(msg.sender, subscribeTo);
  }

  // unsubscribe()
  // Checks if sender is already subscribed to the producer. If they are they 
  // will be removed from the array. 
  // This function will not execute if the sender and the subscriber are the same
  function unsubscribe(address unsubscribeFrom) public {
    require(msg.sender != unsubscribeFrom);

    // remove unsubscribeFrom address to subscriber if it exists
    Subscriber storage subscriber = subscribers[msg.sender];
    for (uint i = 0; i < subscriber.subscribedTo.length; i++) {
      if (subscriber.subscribedTo[i] == unsubscribeFrom) {
        remove(i, subscriber.subscribedTo);
        break;
      }
    }

    // add msg sender address to producer subcribers array
    Producer storage producer = producers[unsubscribeFrom];
    for (uint j = 0; j < producer.subscribers.length; j++) {
      if (producer.subscribers[i] == msg.sender) {
        remove(i, producer.subscribers);
        break;
      }
    }
    Unsubscribed(msg.sender, unsubscribeFrom);
  }

  // charge()
  // Allow contract to be executed by producer in order to collect weekly income.
  // Slightly cumbersome user experience. Could allow automation for contract to be executed weekly on
  // the producers behalf?
  function charge() external {
    uint payout;
    uint service;

    // only allow a producer to call the charge function once a week
    Producer storage producer = producers[msg.sender];
    require(producer.lastPayment + week <= now);

    // calculate payout
    for (uint i = 0; i < producer.subscribers.length; i++) {
      // get subscriber 
      address subscriberAddress = producer.subscribers[1];
      Subscriber storage subscriber = subscribers[subscriberAddress];
      //check balance
      if (subscriber.balance >= weeklyCharge) {
        subscriber.balance -= weeklyCharge + serviceCharge;
        payout += weeklyCharge;
        service += serviceCharge;
      } 
    }
    // send total ETH to producer address
    producer.lastPayment = now;
    msg.sender.transfer(payout);
    serviceAddress.transfer(serviceCharge);
    Charged(msg.sender, producer.subscribers, payout, service);
  }

  // Below are possible functions that we need to implement. 
  // Investigate access to public state variables on the blockchain

  // getSubscriptions(account) public constant
  // Allow users to see what subscriptions they have

  // getBalance(account) public constant
  // Allow users to see what their balance is
  function getBalance(address account) public constant returns (uint) {
    return subscribers[account].balance;
  }

  // getSubscribers(account) public constant
  // Allow users to see what subscribers they have

  // getLastPayment(account) public constant
  // Allow users to see what time they last collected payment

  function remove(uint index, address[] storage array) private returns(address[]) {
      if (index >= array.length) {
        return;
      }

      for (uint i = index; i<array.length-1; i++) {
          array[i] = array[i+1];
      }
      delete array[array.length-1];
      array.length--;
      return array;
  }
}