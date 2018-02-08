var Subscriptions = artifacts.require('Subscriptions');

contract('Subscriptions', function (accounts) {
  it('should allow accounts to deposit ETH', function () {
    return Subscriptions.deployed().then(function (instance) {
      console.log('deployment successful!', instance);
    })
  });
});
