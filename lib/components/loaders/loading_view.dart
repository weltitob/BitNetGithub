import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';

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
              VRouter.of(context).to('/website');
            } else{
              VRouter.of(context).to(
                Matrix.of(context).widget.clients.any((client) => client.onLoginStateChanged.value == LoginState.loggedIn,) ?  '/home' : '/authhome', //'/website' : '/website', //'/feed' : '/authhome'
                queryParameters: VRouter.of(context).queryParameters,
              );
            }
          });
          return Container();
          // Or some kind of splash screen
        } else {
          // No user authenticated
          if(kIsWeb){
            VRouter.of(context).to('/website');
          } else{
            VRouter.of(context).to('/authhome');
          }
          return Container(); // Or another redirect
        }
      },
    );
  }
}
