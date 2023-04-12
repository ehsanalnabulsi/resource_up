part of 'internet_connection_cubit.dart';

abstract class InternetConnectionState {}

class InternetConnectionInitial extends InternetConnectionState {}

class InternetConnectionChangedState extends InternetConnectionState {
  final ConnectivityStatus status;

  InternetConnectionChangedState(this.status);
}
