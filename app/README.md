# Patrecoin

## A Patreon rip off, build on the Ethereum Blockchain

### Proposal
Current Content Payment Platforms of subscription for content producer0 have 2 main pitfalls:
1. They rely on trust that payments will be made on time each month.
2. If the platform of choice disappears overnight, the revenue stream for those content producers expires.
3. These Platforms have control over what does and does not get monotonised.

By decentralizing these 3 aspects of content payment, the control is put into the hands of the Producers to determine how and when they get paid for their work. It also protects them against the payment network itself going down, as the smart contract itself 

### Stakeholders in the DApp
- Content Producers (Producers)
People who produce content and have address associated with the patrecoin smart contact. Subscribers will subscribe to these parties in order to support their continued work

- Subscribers
These people will subscribe to content producers on the patreon smart contract and pay them on a regular basis on order for them to continue their work.

- Miners
These people will get a reward for executing a "charge" contract once per month.

- Maintainer
These people will get a cut of the monthly payments for upkeep of the DApp.

### Design
- Front End: Simple React or Angular Web Front end for producers and subscribers to manage all their accounts and data. 

- Backend: NodeJS, MongoDB application which can store customer metadata and execute the "charge" smart contract.

- Data Storage: We will use a combination of on-chain and off-chain data storage. On Chain we store only data vital to the payments of all members of the system. Off Chain we can store metadata about producers and subscribers in order to provide a more fluid user experience. 

### MVP
For an MVP, the Patrecoin DApp should have the following functionality
- Allow producers to publish their address to the smart contract
- Allow subscribers to subscribe to the address of their favourite producers
- Allow miners to execute a contract (which can only be executed once per month), in return for a small cut of the overall system payments
- Allow users to deposit ETH to the smart contract address
- Maintainer, recieves a small cut of the overall system payments

### Possible extra features
- Request payments into smart contract a week before the charge is applied in order to make sure that all producers will be paid
- Provide democracised content regulation which puts control into the hands of subscribers in order to fine producers of inappropriate content
- Provide a token which could be used to incentavise people to use the system.

