# BitNET TODO List

## Payment Tracking Implementation

### Background
With the one-user-one-node architecture, we need reliable payment tracking that doesn't depend on the frontend app staying open. Solution: Bake limited-permission macaroons during signup that allow backend services to track invoice status without compromising security.

### Immediate Tasks

#### 1. Implement Limited Macaroon Baking During Signup
- [ ] Complete the `bakeLimitedMacaroon` implementation in `/lib/pages/auth/createaccount/createaccount.dart`
- [ ] Permissions needed: `invoices:read`, `offchain:read`, `info:read`
- [ ] Store the invoice tracking macaroon in UserNodeMapping.invoiceTrackingMacaroon
- [ ] Test that limited macaroon cannot perform admin operations

#### 2. Create Backend Payment Tracking Service
- [ ] Build a Cloud Function or Cloud Run service that:
  ```python
  # For each user node:
  1. Read UserNodeMapping with invoiceTrackingMacaroon
  2. Subscribe to SubscribeInvoices using limited macaroon
  3. When invoice.state == SETTLED:
     - Write to Firebase: backend/{userId}/invoices/{rHash}
  4. Handle reconnection on stream failure
  ```
- [ ] Consider using a single service that manages all subscriptions
- [ ] Add monitoring and alerting for failed connections

#### 3. Migration for Existing Users
- [ ] Create admin tool to bake invoice tracking macaroons for existing users
- [ ] Run migration to update all UserNodeMapping documents
- [ ] Verify all active users have invoiceTrackingMacaroon

### Architecture Benefits
- **Security**: Limited macaroons can only read invoice status, not create/modify
- **Reliability**: Backend service ensures payments are tracked even if app closes
- **Scalability**: One service can manage many node subscriptions
- **Self-custody**: Admin macaroons stay on user devices, only limited tracking macaroons in cloud

## Local Macaroon Storage Migration

### Background
Currently, the admin macaroon is retrieved from Firestore's `UserNodeMapping` during operations. We want to transition to loading macaroons locally for better performance and offline capability.

### Tasks

#### 1. Immediate Fix - Store Macaroon Locally During Registration
- [x] Add local storage of admin macaroon in `/lib/pages/auth/createaccount/createaccount.dart`
- [x] Call `storeLitdAccountData()` after successful wallet initialization
- [x] Ensure both Firestore and local storage have the macaroon

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