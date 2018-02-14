pragma solidity ^0.4.0;

contract Subscriptions {
  // service address
  address public serviceAddress;

  // Service charge is 10%
  uint servicePercentage = 10;

  // week in unix time
  uint week = 604800;

  struct Subscription {
    address account;
    bool active;
    uint chargePerSecond;
    uint lastPaymentDate; 
  }

  struct Producer {
    Subscription[] subscribers;
    uint lastPayment;
  }

  mapping (address => Producer) producers;

  struct Subscriber {
    uint balance;
    Subscription[] subscribedTo;
  }

  mapping (address => Subscriber) subscribers;
  
  event Subscribed(address subscriber, address subscribedTo);
  event Unsubscribed(address subscriber, address subscribedTo);
  event Deposited(address subscriber, uint deposit  );
  event Charged(address producer, uint payout, uint service);


  function Subscriptions() public {
    serviceAddress = msg.sender;
  }

  // Deposit
  // Allow subscribers to deposit ETH
  // Non-refundable
  function deposit() public payable {
    Subscriber storage subscriber = subscribers[msg.sender];
    subscriber.balance += msg.value;
    Deposited(msg.sender, msg.value);
  }

  // subscribe()
  // Activate/reactivate a subscription 
  function subscribe(address subscribeTo, uint chargePerSecond) public {
    require(msg.sender != subscribeTo);

    Subscriber storage subscriber = subscribers[msg.sender];
    bool subscribedToExists = false;
    for (uint i = 0; i < subscriber.subscribedTo.length; i++) {
      if (subscriber.subscribedTo[i].account == subscribeTo) {
        subscriber.subscribedTo[i].active = true;
        subscribedToExists = true;
        break;
      }
    }

    // Here to reduce costs we assume that if the subscription doesn't exist in one,
    // it doesn't exist in the other 
    if (!subscribedToExists) { 
      subscriber.subscribedTo.push(Subscription(subscribeTo, true, chargePerSecond, now));
      producer.subscribers.push(Subscription(msg.sender, true, chargePerSecond, now));
      Subscribed(msg.sender, subscribeTo);
      return;
    }

    // subscription must exist, therefore reactivate
    Producer storage producer = producers[subscribeTo];
    for (uint j = 0; j < producer.subscribers.length; j++) {
      if (producer.subscribers[i].account == msg.sender) {
        subscriber.subscribedTo[i].active = true;
        break;
      }
    }
    Subscribed(msg.sender, subscribeTo);
  }

  // unsubscribe()
  // Deactivates a subscription
  function unsubscribe(address unsubscribeFrom) public {
    require(msg.sender != unsubscribeFrom);

    bool subscriptionExists = false;
    Subscriber storage subscriber = subscribers[msg.sender];
    for (uint i = 0; i < subscriber.subscribedTo.length; i++) {
      if (subscriber.subscribedTo[i].account == unsubscribeFrom && subscriber.subscribedTo[i].active) {
        subscriptionExists = true;
        subscriber.subscribedTo[i].active = false;
        break;
      }
    }

    if (subscriptionExists) {
      Producer storage producer = producers[unsubscribeFrom];
      for (uint j = 0; j < producer.subscribers.length; j++) {
        if (producer.subscribers[i].account == msg.sender) {
          subscriber.subscribedTo[i].active = false;
          break;
        }
      }
    }

    Unsubscribed(msg.sender, unsubscribeFrom);
  }

  // charge()
  // Allow contract to be executed by producer in order to collect weekly income.
  function charge() external {
    // only allow a producer to call the charge function once a week
    Producer storage producer = producers[msg.sender];
    require(producer.lastPayment + week <= now);

    // calculate payouts
    uint totalPayout;
    uint totalServiceCharge;

    for (uint i = 0; i < producer.subscribers.length; i++) {
      // get subscriber account and subscription details
      Subscriber storage subscriber = subscribers[producer.subscribers[i].account];
      uint payout = (now - producer.subscribers[i].lastPaymentDate) * producer.subscribers[i].chargePerSecond;
      // check subscription & balance
      if (producer.subscribers[i].active && subscriber.balance >= payout) {
        // total payouts
        uint serviceCharge = payout / servicePercentage;
        totalServiceCharge += serviceCharge;
        totalPayout += (payout - serviceCharge);

        // storage writes
        subscriber.balance -= payout; 
        producer.subscribers[i].lastPaymentDate = now;
      } 
    }
    // storage writes
    producer.lastPayment = now;
    // transfer ETH
    msg.sender.transfer(totalPayout);
    serviceAddress.transfer(totalServiceCharge);
    Charged(msg.sender, totalPayout, totalServiceCharge);
  }

  // getSubscriptions(account) public constant
  // Allow users to see what subscriptions they have
  function getSubscriptions(address account) public constant returns (Subscription[]) {
    return subscribers[account].subscribedTo;
  }

  // getBalance(account) public constant
  // Allow users to see what their balance is
  function getBalance(address account) public constant returns (uint) {
    return subscribers[account].balance;
  }

  // getSubscribers(account) public constant
  // Allow users to see what subscribers they have
  function getSubscribers(address account) public constant returns (Subscription[]) {
    return producers[account].subscribers;
  }

  // getLastPayment(account) public constant
  // Allow users to see what time they last collected payment
  function getLastPayment(address account) public constant returns (uint) {
    return producers[account].lastPayment;
  }
}