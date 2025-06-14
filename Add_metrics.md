# BitNET User Retention & Analytics Implementation Plan

## Overview
This document outlines the implementation plan for comprehensive user retention metrics and analytics in the BitNET application, following YCombinator's cohort analysis best practices.

## Core Metrics Definition

### Active User Definition
An active user is defined as a user who:
1. Opens the app AND
2. Completes at least one transaction within the same session

### Measurement Frequency
- **Primary**: Monthly cohort retention analysis
- **Secondary**: Weekly and daily tracking for insights

## 1. Analytics Data Structure

### User Session Data
```dart
class UserSession {
  String userId;
  DateTime sessionStart;
  DateTime? sessionEnd;
  String sessionId;
  bool isFirstSession;
  List<UserAction> actions;
  String appVersion;
  String platform;
  Map<String, dynamic> deviceInfo;
}
```

### User Action/Transaction Data
```dart
class UserAction {
  String actionId;
  String userId;
  String sessionId;
  DateTime timestamp;
  ActionType type;
  String? subType;
  Map<String, dynamic> metadata;
  bool isOnline;
}

enum ActionType {
  // Core transactions
  lightningPayment,
  lightningReceive,
  onchainSend,
  onchainReceive,
  
  // Taproot Assets
  assetMint,
  assetBurn,
  assetTransfer,
  assetPurchase,
  assetSale,
  
  // Trading/Exchange
  swap,
  exchange,
  
  // App interactions
  appOpen,
  walletCreated,
  walletRestored,
  profileUpdated,
  
  // Marketplace
  nftPurchase,
  nftSale,
  nftListing,
  
  // Social features
  postCreated,
  commentAdded,
  userFollowed
}
```

### Cohort Data
```dart
class UserCohort {
  String cohortId;
  DateTime cohortDate; // First app open date
  int totalUsers;
  Map<int, CohortRetention> retentionByMonth;
}

class CohortRetention {
  int month;
  int activeUsers;
  double retentionRate;
  List<String> activeUserIds;
}
```

## 2. Analytics Controller Architecture

### Core Analytics Controller
```dart
class AnalyticsController extends GetxController {
  // Session management
  void startSession();
  void endSession();
  
  // Action tracking
  void trackAction(ActionType type, {String? subType, Map<String, dynamic>? metadata});
  
  // Specific transaction tracking methods
  void trackLightningPayment(double amount, String currency);
  void trackAssetTransaction(String assetId, String transactionType, double amount);
  void trackWalletCreation(String walletType);
  
  // Funnel tracking
  void trackFunnelStep(FunnelStep step);
  
  // Offline storage and sync
  void _storeOfflineAction(UserAction action);
  void syncOfflineActions();
}
```

### Funnel Tracking
```dart
enum FunnelStep {
  appInstalled,
  appFirstOpen,
  onboardingStarted,
  walletCreated,
  firstDeposit,
  firstTransaction,
  secondTransaction,
  weeklyActive,
  monthlyActive
}

class FunnelAnalytics {
  void trackFunnelConversion(String userId, FunnelStep from, FunnelStep to);
  Future<Map<FunnelStep, double>> getFunnelConversionRates();
}
```

## 3. Implementation Strategy

### Phase 1: Core Infrastructure
1. **Analytics Controller Setup**
   - Create base analytics controller
   - Implement session tracking
   - Set up offline storage using local SQLite database

2. **Data Models**
   - Define all analytics data models
   - Create database schema for local storage
   - Set up cloud firestore collections

3. **Basic Action Tracking**
   - Implement app open tracking
   - Track basic navigation events
   - Store data locally with network status awareness

### Phase 2: Transaction Tracking
1. **Lightning Network Transactions**
   - Hook into existing lightning payment flows
   - Track both sends and receives
   - Capture transaction amounts and success/failure

2. **On-chain Transactions**
   - Monitor wallet transaction events
   - Track transaction types and amounts

3. **Taproot Assets**
   - Integrate with existing taproot asset flows
   - Track minting, burning, transfers
   - Monitor marketplace activities

### Phase 3: Advanced Analytics
1. **Cohort Analysis**
   - Implement cohort generation logic
   - Calculate retention rates
   - Generate quarterly reports

2. **Funnel Analysis**
   - Track user progression through app
   - Identify drop-off points
   - Measure conversion rates

3. **Offline Sync**
   - Implement robust offline storage
   - Create sync mechanism for when connectivity returns
   - Handle data conflicts and deduplication

### Phase 4: Reporting & Visualization
1. **Admin Dashboard Backend**
   - Create cloud functions for data aggregation
   - Implement cohort calculation APIs
   - Set up funnel analysis endpoints

2. **Frontend Dashboard** (Future website feature)
   - Cohort retention visualization
   - Funnel analysis charts
   - Real-time metrics display

## 4. Technical Implementation Details

### Local Storage Strategy
- **SQLite Database**: For offline action storage
- **Hive Boxes**: For session data and user preferences
- **Automatic Sync**: Background sync when network available

### Cloud Storage Structure
```
analytics/
├── users/
│   └── {userId}/
│       ├── profile/
│       ├── sessions/
│       └── actions/
├── cohorts/
│   └── {cohortDate}/
└── funnels/
    └── global/
```

### Integration Points

#### 1. App Lifecycle (main.dart)
```dart
// App startup
AnalyticsController.to.startSession();

// App backgrounded/closed
AnalyticsController.to.endSession();
```

#### 2. Transaction Monitoring
- **Lightning**: Hook into `sendpayment_v2.dart` and invoice subscription
- **On-chain**: Monitor wallet transaction streams
- **Assets**: Integrate with taproot asset controllers

#### 3. User Actions
- **Wallet Creation**: Track in auth flow
- **First Transaction**: Special tracking for onboarding funnel
- **Marketplace**: Track all NFT and asset activities

### Privacy & Compliance
- **User Consent**: Implement analytics opt-in/opt-out
- **Data Anonymization**: Hash sensitive data
- **GDPR Compliance**: Allow data deletion requests
- **Local Control**: User can view and delete local analytics data

## 5. Metrics Dashboard Features

### Cohort Retention Views
- Quarterly retention heatmap
- Cohort size trends over time
- Retention rate comparisons

### Funnel Analysis Views
- Step-by-step conversion rates
- Drop-off identification
- Time-to-conversion metrics

### Transaction Analytics
- Transaction volume trends
- Popular transaction types
- User engagement patterns

## 6. Implementation Files Structure

```
lib/backbone/services/analytics/
├── analytics_controller.dart
├── models/
│   ├── user_session.dart
│   ├── user_action.dart
│   ├── cohort_data.dart
│   └── funnel_data.dart
├── storage/
│   ├── local_analytics_storage.dart
│   └── cloud_analytics_sync.dart
├── tracking/
│   ├── transaction_tracker.dart
│   ├── session_tracker.dart
│   └── funnel_tracker.dart
└── privacy/
    └── analytics_privacy_controller.dart
```

## 7. Success Metrics

### Key Performance Indicators (KPIs)
- **Quarterly Retention Rate**: Target >40% Q1, >20% Q2, >15% Q3+
- **First Transaction Rate**: Target >60% of new users within 7 days
- **Weekly Active Users**: Track week-over-week growth
- **Transaction Frequency**: Average transactions per active user

### Funnel Benchmarks
- App Install → First Open: >90%
- First Open → Wallet Created: >70%
- Wallet Created → First Transaction: >60%
- First Transaction → Second Transaction: >40%

## Next Steps

1. **Review & Approval**: Review this plan and provide feedback
2. **Technical Architecture**: Finalize technical implementation details
3. **Privacy Review**: Ensure compliance with privacy requirements
4. **Development Timeline**: Create sprint planning for implementation
5. **Testing Strategy**: Define testing approach for analytics accuracy

---

*This plan provides a comprehensive foundation for implementing YCombinator-style cohort retention analysis while maintaining user privacy and providing actionable insights for growth.*