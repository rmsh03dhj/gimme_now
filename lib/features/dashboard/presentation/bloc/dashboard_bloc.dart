import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(
          MyStatusInitialState(),
        );

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is CheckProfileCompleted) {}
  }
}
