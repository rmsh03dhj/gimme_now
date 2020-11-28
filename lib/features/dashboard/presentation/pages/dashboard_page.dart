import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gimmenow/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gimmenow/features/utils/gimme_now_scaffold_with_drawer.dart';

class DashBoardPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GimmeNowScaffoldWithDrawer(
      body: DashBoardPage(),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  DashBoardPage();
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool hasInternetConnection = true;
  String code;
  bool isFirstTimeNavigation = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(listener: (context, state) {
      if (state is MyStatusQuestionFetchingFailed) {}
    }, builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "I am here",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
