import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/routetrees/controllers/widget_tree_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoadingViewAppStart extends StatefulWidget {
  const LoadingViewAppStart({Key? key}) : super(key: key);

  @override
  State<LoadingViewAppStart> createState() => _LoadingViewAppStartState();
}

class _LoadingViewAppStartState extends State<LoadingViewAppStart> {
  @override
  void initState() {
    super.initState();
    
    // Special handling for web - redirect immediately to website landing page
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // On web, go directly to main website landing page and skip other checks
        if (mounted) {
          context.go('/website');
        }
      });
      return;
    }
    
    // Normal mobile initialization
    try {
      bool deepLink = false;
      
      // Safely get WidgetTreeController
      if (Get.isRegistered<WidgetTreeController>()) {
        deepLink = Get.find<WidgetTreeController>().openedWithDeepLink;
      }
      
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (deepLink) {
          return;
        }
        
        try {
          if (Auth().currentUser != null) {
            context.go('/feed');
          } else {
            context.go('/authhome');
          }
        } catch (e) {
          print('Error navigating from LoadingViewAppStart (safe to ignore in web preview): $e');
          // Fallback navigation
          context.go('/authhome');
        }
      });
    } catch (e) {
      print('Error in LoadingViewAppStart.initState (safe to ignore in web preview): $e');
      
      // Fallback navigation
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.go('/authhome');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // For web, just show a simple loading screen and let initState handle navigation
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dotProgress(context),
              SizedBox(height: 24),
              Text('Loading BitNet...', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      );
    }
    
    // For mobile, use the safer auth check approach
    try {
      return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          // Show loading while waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: dotProgress(context));
          } 
          
          // Show error message if there's an error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          // Handle authenticated user
          if (snapshot.data != null) {
            // User is authenticated
            WidgetsBinding.instance.addPostFrameCallback((_) {
              try {
                bool shouldNavigate = true;
                
                // Check if we're handling a deep link
                if (Get.isRegistered<WidgetTreeController>()) {
                  shouldNavigate = !Get.find<WidgetTreeController>().openedWithDeepLink;
                }
                
                if (shouldNavigate) {
                  context.go('/feed');
                }
              } catch (e) {
                print('Navigation error (safe to ignore in web preview): $e');
                context.go('/feed');
              }
            });
            
            // Return empty container while navigation is in progress
            return Container();
          } 
          
          // Handle unauthenticated user
          else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              try {
                // Set device locale
                Locale deviceLocale = PlatformDispatcher.instance.locale;
                String langCode = deviceLocale.languageCode;
                
                // Update locale in database
                Provider.of<LocalProvider>(context, listen: false)
                  .setLocaleInDatabase(langCode, deviceLocale, isUser: false);
                
                // Navigate to auth home
                context.go('/authhome');
              } catch (e) {
                print('Locale/navigation error (safe to ignore in web preview): $e');
                context.go('/authhome');
              }
            });
            
            // Return empty container while navigation is in progress
            return Container();
          }
        },
      );
    } catch (e) {
      // Ultimate fallback UI in case the StreamBuilder throws
      print('Critical error in LoadingViewAppStart.build (safe to ignore in web preview): $e');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text('Loading error', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.go('/authhome');
                },
                child: Text('Go to login'),
              )
            ],
          ),
        ),
      );
    }
  }
}
