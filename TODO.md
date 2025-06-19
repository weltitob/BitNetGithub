# BitNET TODO List

## Local Macaroon Storage Migration

### Background
Currently, the admin macaroon is retrieved from Firestore's `UserNodeMapping` during operations. We want to transition to loading macaroons locally for better performance and offline capability.

### Tasks

#### 1. Immediate Fix - Store Macaroon Locally During Registration
- [ ] Add local storage of admin macaroon in `/lib/pages/auth/createaccount/createaccount.dart`
- [ ] Call `storeLitdAccountData()` after successful wallet initialization
- [ ] Ensure both Firestore and local storage have the macaroon

#### 2. Future Migration - Load Macaroons Locally
Replace remote macaroon loading with local loading in the following functions:

##### Lightning Operations
- [ ] `/lib/backbone/streams/lnd/sendpayment_v2.dart` - `sendPaymentV2Stream()`
  - Replace: `final macaroon = nodeMapping.adminMacaroon;`
  - With: `loadMacaroonAsset()` from local storage

##### Onchain Operations  
- [ ] `/lib/backbone/cloudfunctions/lnd/walletkitservice/send_coins.dart`
  - `sendCoins()` - Replace nodeMapping.adminMacaroon with local loading
  - `estimateFee()` - Replace nodeMapping.adminMacaroon with local loading

##### Address Generation
- [ ] `/lib/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart`
  - `nextAddrDirect()` - Replace nodeMapping.adminMacaroon with local loading

##### Invoice Creation
- [ ] `/lib/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart`
  - `addInvoice()` - Replace nodeMapping.adminMacaroon with local loading

### Implementation Notes
- Keep Firestore storage as backup/recovery mechanism
- Local storage should be primary source for performance
- Handle migration gracefully for existing users who don't have local macaroons
- Consider adding a fallback: try local first, then Firestore if not found

### Testing Requirements
- Test new registrations store macaroon locally
- Test existing users can still operate without local macaroons
- Test macaroon recovery from Firestore if local is missing
- Test offline functionality with local macaroons