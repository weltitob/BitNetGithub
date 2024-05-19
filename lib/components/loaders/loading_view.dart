import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
 if(Auth().currentUser!= null) {
      context.go('/feed');
    } else {
      context.go('/authhome');
    }
    });
   
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return Center(child: dotProgress(context));

        } else if (snapshot.hasError) {

          return Center(child: Text('Error: ${snapshot.error}'));

        } else if (snapshot.data != null) {
          // User is authenticated and user data is loaded
          Future.delayed(Duration.zero, () {
            if(kIsWeb){
              context.go('/website');
            } else{
              context.go(
                Uri(
                path: Auth().currentUser != null ?  '/feed' : '/authhome', //'/website' : '/website', //'/feed' : '/authhome'
                queryParameters: GoRouter.of(context).routeInformationProvider.value.uri.queryParameters,).toString()
              );
            }
          });
          return Container();
          // Or some kind of splash screen
        } else {
          // No user authenticated
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {          if(kIsWeb){
            context.go('/website');
          } else{
                     Locale deviceLocale = PlatformDispatcher.instance.locale;// or html.window.locale
        String langCode = deviceLocale.languageCode;

            Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase( langCode,
            deviceLocale, isUser: false);

            context.go('/authhome');
          }
 });
          // if(kIsWeb){
          //   context.go('/website');
          // } else{
          //   context.go('/authhome');
          // }
          return Container(); // Or another redirect
        }
      },
    );
  }
}