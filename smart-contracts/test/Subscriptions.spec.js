var Subscriptions = artifacts.require('Subscriptions');

contract('Subscriptions', function (accounts) {
  it('should initialise with serviceAddress as the contract deployer address', function () {
    return Subscriptions.deployed().then(function (instance) {
      return instance.serviceAddress();
    }).then(function (serviceAddress) {
      assert.equal(serviceAddress, accounts[0]);
    });
  });

  it('should allow ETH to be deposited for an account', function () {
    var valueToSend = web3.toWei(1, "ether");
    var patrecoin;
    return Subscriptions.deployed().then(function (instance) {
      patrecoin = instance;
      return patrecoin.deposit({value: valueToSend, from: accounts[0]});;
    }).then(function () {
      return patrecoin.getBalance(accounts[0])
    }).then(function (balance) {
      assert.equal(web3.eth.getBalance(patrecoin.address), valueToSend)
      assert.equal(balance, valueToSend);
    });
  });

  it('should allow a sender to subscribe to and unsubscribe from an account', function () {
    var subscriberAccount = accounts[0];
    var producerAccount = accounts[1];
    var patrecoin;
    var subscriptions;
    var subscribers;
    return Subscriptions.deployed().then(function (instance) {
      patrecoin = instance;
      return patrecoin.subscribe(producerAccount);
    }).then(function () {
      return patrecoin.getSubscriptions(subscriberAccount);
    }).then(function (results) {
      subscriptions = results;
      return patrecoin.getSubscribers(producerAccount);
    }).then(function (results) {
      subscribers = results;
      // test subscriber subscriptions
      assert.equal(subscriptions.length, 1);
      assert.equal(subscriptions[0], producerAccount);
      // test producer subscribers
      assert.equal(subscribers.length, 1);
      assert.equal(subscribers[0], subscriberAccount);
    }).then(function () {
      return patrecoin.unsubscribe(producerAccount);
    }).then(function () {
      return patrecoin.getSubscriptions(subscriberAccount);
    }).then(function (results) {
      subscriptions = results;
      return patrecoin.getSubscribers(producerAccount);
    }).then(function (results) {
      subscribers = results;
      // test subscriber subscriptions
      assert.equal(subscriptions.length, 0);
      // test producer subscribers
      assert.equal(subscribers.length, 0);
    });
  });

  it('should allow a producer to charge all subscriber accounts', function () {
    // Deposit some ether
    var subscriberAccount = accounts[0];
    var producerAccount = accounts[1];
    var valueToSend = web3.toWei(1, "ether");
    var patrecoin;
    return Subscriptions.deployed().then(function (instance) {
      patrecoin = instance;
      return patrecoin.deposit({value: valueToSend, from: accounts[0]});;
    })
    // Subscribe to an account
    .then(function () {
      return patrecoin.subscribe(producerAccount);
    })
    // Charge that account
    .then(function () {
      return patrecoin.charge({from: producerAccount});
    })
    // assert
    .then(function () {
      assert.fail()
    });
  });
});
