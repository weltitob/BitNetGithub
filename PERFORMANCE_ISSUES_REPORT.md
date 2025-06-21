# Flutter Performance Anti-Patterns Report

Generated on: 2025-06-21

## Summary

This report identifies common performance anti-patterns found in the BitNET Flutter codebase. Each issue includes file paths, descriptions, and potential performance impacts.

## 1. StatefulWidget with Frequent setState() Calls

### Issue
Multiple files use setState() in response to stream listeners or timers, which can cause unnecessary rebuilds.

### Findings

#### `/lib/pages/bottomnav.dart`
- **Line 112**: setState() called in loadData() after checking user settings
- **Line 127**: setState() called inside stream listener for chart updates  
- **Line 143-159**: setState() called in onItemTapped for navigation
- **Line 319**: setState() called in getUserTheme()
- **Impact**: Rebuilds entire bottom navigation on every data change

#### `/lib/components/items/cryptoitem.dart`
- **Line 127**: setState() inside stream listener for chart updates
- **Impact**: Every chart update rebuilds the entire crypto item widget

### Recommendation
Consider using more granular state management (GetX controllers, ValueNotifier) to rebuild only affected widgets.

## 2. Expensive Operations in build() Methods

### Issue
Several widgets perform expensive operations directly in their build methods.

### Findings

#### `/lib/pages/wallet/walletscreen.dart`
- **Line 79**: MediaQuery.of(context).size called in build (should be cached)
- **Line 83-84**: Provider.of<CurrencyChangeProvider> accessed in build
- **Impact**: These operations run on every rebuild

#### `/lib/pages/bottomnav.dart`
- **Line 165-168**: Multiple GetX controller initializations in build method
- **Impact**: Controllers re-initialized on every rebuild

### Recommendation
- Cache MediaQuery values outside build
- Move controller initialization to initState or use Get.lazyPut
- Use context.watch/select for Provider access

## 3. Missing const Constructors

### Issue
Many widgets that could be const are not marked as such, preventing compile-time optimization.

### Findings

Multiple instances of non-const widgets found:
- SizedBox without const (common throughout codebase)
- Icon widgets without const
- Text widgets with static content not marked const
- Container widgets with static properties

### Examples
```dart
// Found in multiple files:
SizedBox(height: 20),  // Should be: const SizedBox(height: 20)
Icon(FontAwesomeIcons.wallet),  // Should be: const Icon(...)
```

### Recommendation
Add const keyword to all widgets with compile-time constant properties.

## 4. Inefficient List Building

### Issue
Some files use ListView with children array instead of ListView.builder for potentially large lists.

### Findings

#### `/lib/pages/feed/tokenstab.dart`
- **Line 80-82**: ListView with direct children array
- **Impact**: All children built at once, even if not visible

#### Multiple feed tab files
- Similar pattern found in appstab.dart, websitestab.dart, assetstab.dart
- Using ListView with children[] for dynamic content

### Recommendation
Use ListView.builder or ListView.separated for better performance with large lists.

## 5. Timer/Stream Subscriptions Without Proper Disposal

### Issue
Stream listeners created without corresponding disposal can cause memory leaks.

### Findings

#### `/lib/components/items/cryptoitem.dart`
- **Line 119-131**: Stream listener created in didChangeDependencies without disposal
- **Impact**: Memory leak - listener persists after widget disposal

#### `/lib/pages/bottomnav.dart`
- **Line 171-177**: Stream listener without clear disposal pattern
- **Impact**: Potential memory leak

### Recommendation
- Store StreamSubscription and cancel in dispose()
- Use StreamBuilder for automatic subscription management

## 6. Heavy Operations on Main Thread

### Issue
Synchronous operations that could block the UI thread.

### Findings

Multiple files perform JSON operations synchronously:
- jsonDecode/jsonEncode calls without compute()
- File read/write operations without async handling
- Heavy computations in build methods

### Recommendation
- Use compute() for JSON parsing of large data
- Ensure file operations are async
- Move heavy computations to isolates

## 7. Excessive GetX/Obx Rebuilds

### Issue
Overuse of Obx widgets causing unnecessary rebuilds.

### Findings

#### `/lib/pages/wallet/walletscreen.dart`
- **Lines 202-244**: Multiple nested Obx widgets
- Each Obx rebuilds independently, potentially causing cascading rebuilds

#### Common Pattern
```dart
Obx(() => Container(
  child: Obx(() => Text(...)),  // Nested Obx - avoid this
))
```

### Recommendation
- Minimize Obx usage to smallest possible widget tree
- Combine related observables into single Obx
- Use GetBuilder for less frequent updates

## Priority Recommendations

1. **High Priority**: Fix stream subscription disposal issues to prevent memory leaks
2. **High Priority**: Move expensive operations out of build methods
3. **Medium Priority**: Add const constructors throughout the codebase
4. **Medium Priority**: Replace ListView with children with ListView.builder for dynamic content
5. **Low Priority**: Optimize GetX/Obx usage patterns

## Tools for Performance Analysis

Consider using:
- Flutter DevTools Performance view
- `flutter analyze` with performance rules
- Widget rebuild tracker
- Memory profiler for leak detection