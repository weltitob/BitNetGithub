import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



import 'settings_multiple_emotes_view.dart';

class MultipleEmotesSettings extends StatefulWidget {
  final GoRouterState routerState;
  const MultipleEmotesSettings({Key? key, required this.routerState}) : super(key: key);

  @override
  MultipleEmotesSettingsController createState() =>
      MultipleEmotesSettingsController();
}

class MultipleEmotesSettingsController extends State<MultipleEmotesSettings> {
  String? get roomId => widget.routerState.pathParameters['roomid'];
  @override
  Widget build(BuildContext context) => MultipleEmotesSettingsView(this);
}
