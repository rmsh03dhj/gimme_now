import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckProfileCompleted extends DashboardEvent {
  CheckProfileCompleted();
}

class CheckTermsConditionAccepted extends DashboardEvent {
  CheckTermsConditionAccepted();
}

class FetchStatusOnly extends DashboardEvent {
  FetchStatusOnly();
}

class DisplayLocallyStoredUserStatus extends DashboardEvent {
  DisplayLocallyStoredUserStatus();
}

class UploadLocallyStoredUserStatusAndVisitHistory extends DashboardEvent {
  UploadLocallyStoredUserStatusAndVisitHistory();
}

class UploadLocallyStoredVisitHistory extends DashboardEvent {
  UploadLocallyStoredVisitHistory();
}

class QrCodeScanned extends DashboardEvent {
  final int locationId;
  final String locId;

  QrCodeScanned({this.locationId, this.locId});
}

class ClearStatus extends DashboardEvent {}

class AcceptTermsCondition extends DashboardEvent {
  AcceptTermsCondition();
}

class FetchAndStoreQuestions extends DashboardEvent {
  FetchAndStoreQuestions();
}
