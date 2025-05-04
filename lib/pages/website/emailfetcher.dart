// import 'package:bitnet/backbone/helper/size_extension.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
// import 'package:bitnet/components/buttons/longbutton.dart';
// import 'package:bitnet/components/fields/textfield/formtextfield.dart';
// import 'package:bitnet/pages/website/seo/seo_text.dart';
// import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:seo/seo.dart';

// class EmailFetcherLandingPage extends StatefulWidget {
//   final WebsiteLandingPageController? controller;

//   const EmailFetcherLandingPage({super.key, this.controller});

//   @override
//   State<EmailFetcherLandingPage> createState() => _EmailFetcherLandingPageState();
// }

// class _EmailFetcherLandingPageState extends State<EmailFetcherLandingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   String? _errorMessage;

//   // Function to save the email to Firestore
//   Future<void> _saveEmail(String email) async {
//     await FirebaseFirestore.instance.collection('earlybird_email_list').add({
//       'email': email,
//       'timestamp': DateTime.now(),
//     });
//     print('E-Mail saved: $email');
//   }

//   // Validation logic for email
//   String? _validateEmail(String? val) {
//     if (val == null || val.isEmpty) {
//       return '';
//     }
//     String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
//     RegExp regex = RegExp(pattern);
//     if (!regex.hasMatch(val)) {
//       return 'Please enter a valid email.';
//     }
//     return null;
//   }

//   // Update the error message on email change
//   void _onEmailChanged(String val) {
//     setState(() {
//       _errorMessage = _validateEmail(val);
//     });
//   }

//   // Cached dimensions map to avoid recalculating responsive values on every rebuild
//   final Map<String, Map<String, double>> _cachedDimensions = {};
  
//   // Calculate responsive dimensions based on screen size, with caching
//   Map<String, double> _getResponsiveDimensions(BoxConstraints constraints) {
//     // Create a key based on the screen width to use for caching
//     final String cacheKey = constraints.maxWidth.toStringAsFixed(0);
    
//     // Return cached values if available
//     if (_cachedDimensions.containsKey(cacheKey)) {
//       return _cachedDimensions[cacheKey]!;
//     }
    
//     // Screen size handling
//     bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
//     bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
//     bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
//     bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

//     // Calculate the dimensions
//     double bigtextWidth = isMidScreen
//         ? (isSmallScreen 
//           ? (isSuperSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 28)
//           : AppTheme.cardPadding * 30)
//         : AppTheme.cardPadding * 33;
        
//     double textWidth = isMidScreen
//         ? (isSmallScreen
//           ? (isSuperSmallScreen ? AppTheme.cardPadding * 12 : AppTheme.cardPadding * 16)
//           : AppTheme.cardPadding * 22)
//         : AppTheme.cardPadding * 24;
        
//     double subtitleWidth = isMidScreen
//         ? (isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18)
//         : AppTheme.cardPadding * 22;
        
//     double spacingMultiplier = isMidScreen
//         ? (isSmallScreen ? (isSuperSmallScreen ? 0.5 : 0.5) : 0.75)
//         : 1;
        
//     double centerSpacing = isMidScreen
//         ? (isIntermediateScreen
//           ? (isSmallScreen
//             ? (isSuperSmallScreen ? AppTheme.columnWidth * 0.075 : AppTheme.columnWidth * 0.15)
//             : AppTheme.columnWidth * 0.35)
//           : AppTheme.columnWidth * 0.65)
//         : AppTheme.columnWidth;
    
//     // For very large screens, increase width proportionally
//     if (constraints.maxWidth > 1440) {
//       // Scale up dimensions for large screens
//       bigtextWidth = bigtextWidth * 1.5;
//       textWidth = textWidth * 1.5;
//       subtitleWidth = subtitleWidth * 1.5;
      
//       // On very large screens, increase spacing more
//       if (constraints.maxWidth > 2000) {
//         centerSpacing = centerSpacing * 1.5;
//       }
//     }
    
//     // Cache the results
//     _cachedDimensions[cacheKey] = {
//       'bigtextWidth': bigtextWidth,
//       'textWidth': textWidth,
//       'subtitleWidth': subtitleWidth,
//       'spacingMultiplier': spacingMultiplier,
//       'centerSpacing': centerSpacing,
//       'isSmallScreen': isSmallScreen ? 1.0 : 0.0,
//       'isSuperSmallScreen': isSuperSmallScreen ? 1.0 : 0.0,
//     };
    
//     return _cachedDimensions[cacheKey]!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Check if shown as dialog by examining parent widget
//     final bool isDialog = ModalRoute.of(context)?.settings.name == null;
    
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         // Get memoized responsive dimensions
//         final dimensions = _getResponsiveDimensions(constraints);
        
//         final double bigtextWidth = dimensions['bigtextWidth']!;
//         final double subtitleWidth = dimensions['subtitleWidth']!;
//         final double spacingMultiplier = dimensions['spacingMultiplier']!;
//         final double centerSpacing = dimensions['centerSpacing']!;
//         final bool isSmallScreen = dimensions['isSmallScreen']! > 0;
//         final bool isSuperSmallScreen = dimensions['isSuperSmallScreen']! > 0;

//         return Stack(
//           children: [
//             // Close button for dialog mode
//             if (isDialog)
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ),
//             BackgroundWithContent(
//               backgroundType: BackgroundType.asset,
//               withGradientBottomBig: true,
//               opacity: 0.7,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: centerSpacing),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: AppTheme.cardPadding * 6 * spacingMultiplier),
//                       Container(
//                         width: bigtextWidth + AppTheme.cardPadding,
//                         child: SeoText(
//                           "Be an earlybird - get rewarded later.",
//                           tagStyle: TextTagStyle.h1,
//                           textAlign: TextAlign.center,
//                           style: isSuperSmallScreen
//                               ? Theme.of(context).textTheme.displayMedium
//                               : Theme.of(context).textTheme.displayLarge,
//                         ),
//                       ),
//                       SizedBox(height: AppTheme.cardPadding * 1 * spacingMultiplier),
//                       Container(
//                         width: subtitleWidth + AppTheme.cardPadding,
//                         child: SeoText(
//                           "Join the mailing list and be the first when we launch our services.",
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ),
//                       SizedBox(height: AppTheme.cardPadding * 2.5 * spacingMultiplier),
//                       FormTextField(
//                         width: AppTheme.cardPadding * 14.ws,
//                         hintText: "Email",
//                         validator: (val) {
//                           // Validator doesn't show error under field
//                           _errorMessage = _validateEmail(val);
//                           return null; // Prevent default red error text
//                         },
//                         onChanged: _onEmailChanged,
//                         controller: _emailController,
//                         isObscure: false,
//                       ),
//                       if (_errorMessage != null) // Show error message below field if present
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             _errorMessage!,
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       SizedBox(height: AppTheme.elementSpacing),
//                       LongButtonWidget(
//                         customWidth: AppTheme.cardPadding * 14.ws,
//                         customHeight: AppTheme.cardPadding * 2.h,
//                         backgroundPainter: false,
//                         buttonType: ButtonType.solid,
//                         title: "Notify me!",
//                         onTap: () async {
//                           if (_validateEmail(_emailController.text) == null) {
//                             String email = _emailController.text;
//                             await _saveEmail(email);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 backgroundColor: AppTheme.successColor,
//                                 content: Center(
//                                   child: Text(
//                                       'Thank you! We saved your email and will notify you on launch day!',
//                                   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: darken(AppTheme.successColor, 70)),
//                                   ),
//                                 ),
//                               ),
//                             );
//                             _emailController.clear();
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 backgroundColor: AppTheme.errorColor,
//                                 content: Center(
//                                   child: Text('Please submit a valid email address.',
//                                     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: darken(AppTheme.errorColor, 70)),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       SizedBox(height: AppTheme.cardPadding * 10 * spacingMultiplier),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(
//                             height: AppTheme.cardPadding * 1,
//                             width: AppTheme.cardPadding * 1,
//                             child: Image(
//                               image: AssetImage('assets/images/logotransparent.png'),
//                             ),
//                           ),
//                           const SizedBox(width: AppTheme.elementSpacing / 2),
//                           SeoText(
//                             tagStyle: TextTagStyle.h2,
//                             "BitNet",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [Container()],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
