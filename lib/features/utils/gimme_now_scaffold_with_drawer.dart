import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/core/config/gimme_now_routes.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_event.dart';

class GimmeNowScaffoldWithDrawer extends StatefulWidget {
  final Widget body;
  GimmeNowScaffoldWithDrawer({@required this.body});

  @override
  _GimmeNowScaffoldWithDrawerState createState() => _GimmeNowScaffoldWithDrawerState();
}

class _GimmeNowScaffoldWithDrawerState extends State<GimmeNowScaffoldWithDrawer> {
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
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                  child: Image.asset(
                "assets/logo.png",
                scale: 3,
              )),
              ListTile(
                title: Text("My Profile"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Log out"),
                onTap: () {
                  BlocProvider.of<AppStartBloc>(context).add(LoggedOut());
                  Navigator.of(context).pushNamed(GimmeNowRoutes.signUp);
                },
              ),
            ]),
          ),
        ),
        body: widget.body);
  }
}
