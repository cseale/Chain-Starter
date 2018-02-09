var Subscriptions = artifacts.require('Subscriptions');

contract('Subscriptions', function (accounts) {
  it('should initialise with serviceAddress as the contract deployer address', function () {
    return Subscriptions.deployed().then(function (instance) {
      return instance.serviceAddress();
    }).then(function (serviceAddress) {
      assert.equal(serviceAddress, accounts[0]);
    });
  });

  it('should allow ETH to be deposited for an address', function () {
    var valueToSend = 2000;
    var patrecoin;
    return Subscriptions.deployed().then(function (instance) {
      patrecoin = instance;
      return patrecoin.deposit({value: valueToSend, from: accounts[0]});;
    }).then(function () {
      return patrecoin.getBalance(accounts[0])
    }).then(function (balance) {
      assert.equal(balance, valueToSend);
    });
  });
});
