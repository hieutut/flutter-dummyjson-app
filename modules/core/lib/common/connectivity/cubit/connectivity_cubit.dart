import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core.dart';

part 'connectivity_state.dart';

@Singleton()
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial()) {
    checkInternetConnection();
  }

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool get isConnectionSuccess => state is ConnectionSuccess;

  Future<void> checkInternetConnection({int retry = 2}) async {
    if (retry < 0) return;
    final results = await _initInternetStatus();
    if (results.contains(ConnectivityResult.none)) {
      await Future.delayed(400.milliseconds);
      await checkInternetConnection(retry: retry - 1);
    }
  }

  Future<List<ConnectivityResult>> _initInternetStatus() async {
    final results = await Connectivity().checkConnectivity();
    _mapConnectivityResultToState(results);
    _disposeSubscription();
    _subscription = Connectivity().onConnectivityChanged.listen(_mapConnectivityResultToState);
    return results;
  }

  void _mapConnectivityResultToState(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      emit(ConnectionFailed());
    } else {
      emit(ConnectionSuccess());
    }
  }

  void _disposeSubscription() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void onChange(Change<ConnectivityState> change) {
    super.onChange(change);
    printOut('${change.currentState.runtimeType} -> ${change.nextState.runtimeType}', name: '$runtimeType');
  }

  @override
  Future<void> close() {
    _disposeSubscription();
    return super.close();
  }
}
