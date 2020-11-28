import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class MyStatusInitialState extends DashboardState {}

class LocallyStoredMyStatusUploadingState extends DashboardState {}

class LocallyStoredMyStatusUploadingFailedState extends DashboardState {}

class MyStatusLoadingState extends DashboardState {}

class MyStatusEmptyState extends DashboardState {}

class NavigateToStartQuestionnaireState extends DashboardState {
  NavigateToStartQuestionnaireState();
}

class MyStatusErrorState extends DashboardState {
  final String errorMessage;

  MyStatusErrorState({this.errorMessage});
}

class ProfileCompletedState extends DashboardState {
  ProfileCompletedState();
}

class ProfileUpdatingState extends DashboardState {
  ProfileUpdatingState();
}

class ProfileUpdateSuccessState extends DashboardState {
  final String firebaseId;

  ProfileUpdateSuccessState({this.firebaseId});
}

class ProfileUpdateErrorState extends DashboardState {
  final String errorMessage;

  ProfileUpdateErrorState({this.errorMessage});
}

class TermsConditionAcceptingState extends DashboardState {
  TermsConditionAcceptingState();
}

class TermsConditionAcceptedState extends DashboardState {
  TermsConditionAcceptedState();
}

class TermsConditionAlreadyAcceptedState extends DashboardState {
  TermsConditionAlreadyAcceptedState();
}

class TermsConditionErrorState extends DashboardState {
  final String errorMessage;

  TermsConditionErrorState({this.errorMessage});
}

class MyStatusQuestionFetchingFailed extends DashboardState {
  final String errorMessage;

  MyStatusQuestionFetchingFailed({this.errorMessage});
}

class QuestionStoredLocallyState extends DashboardState {
  QuestionStoredLocallyState();
}

class QuestionFetchingState extends DashboardState {
  QuestionFetchingState();
}

class FetchQuestionsFirstState extends DashboardState {
  FetchQuestionsFirstState();
}
