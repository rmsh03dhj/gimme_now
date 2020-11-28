import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/core/config/gimme_now_routes.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_event.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_state.dart';

class GimmeNowScaffoldNoDrawer extends StatefulWidget {
  final Widget body;
  GimmeNowScaffoldNoDrawer({@required this.body});

  @override
  _GimmeNowScaffoldNoDrawerState createState() => _GimmeNowScaffoldNoDrawerState();
}

class _GimmeNowScaffoldNoDrawerState extends State<GimmeNowScaffoldNoDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/logo_small.png",
              color: Colors.orange,
              scale: 3,
            ),
          ),
        ),
        body: widget.body);
  }
}
