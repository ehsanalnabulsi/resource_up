import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_connection_state.dart';

enum ConnectivityStatus { connected, disconnected }

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final Connectivity connectivity;

  InternetConnectionCubit(this.connectivity)
      : super(InternetConnectionInitial());

  Future<void> checkConnection() async {
    final hasConnection = await connectivity.checkConnectivity();
    if (hasConnection != ConnectivityResult.none) {
      emit(InternetConnectionChangedState(ConnectivityStatus.connected));
    } else {
      emit(InternetConnectionChangedState(ConnectivityStatus.disconnected));
    }
  }
}
