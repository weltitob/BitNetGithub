import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:matrix/matrix.dart';


class LoadingViewAppStart extends StatelessWidget {
  const LoadingViewAppStart({Key? key}) : super(key: key);

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
                path: Matrix.of(context).widget.clients.any((client) => client.onLoginStateChanged.value == LoginState.loggedIn,) ?  '/feed' : '/authhome', //'/website' : '/website', //'/feed' : '/authhome'
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
