var Subscriptions = artifacts.require('Subscriptions');

contract('Subscriptions', function (accounts) {
  it('should initialise with serviceAddress as the contract deployer address', function () {
    return Subscriptions.deployed().then(function (instance) {
      return instance.serviceAddress();
    }).then(function (serviceAddress) {
      assert.equal(serviceAddress, accounts[0]);
    });
  });
});
