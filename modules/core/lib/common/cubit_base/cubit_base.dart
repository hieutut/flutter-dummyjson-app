import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

abstract class CubitBase<T> extends Cubit<T> {
  CubitBase(super.initialState);

  late final ConnectivityCubit _connectivityCubit = context.read<ConnectivityCubit>();

  BuildContext get context {
    assert(
      AppRouteObserver.instance.context != null,
      '`AppRouteObserver.instance.context` must not be null.',
    );
    return AppRouteObserver.instance.context!;
  }

  Future<void> runAction(
    Future<void> Function() executable, {
    bool checkInternet = true,
    void Function(AppException error)? onError,
    bool Function(AppException error)? overrideDefaultOnError,
    VoidCallback? onFinally,
  }) async {
    try {
      if (checkInternet && !_hasInternetConnection()) {
        throw NoInternetException();
      }
      await executable();
    } on AppException catch (e) {
      if (e is NoInternetException && overrideDefaultOnError?.call(e) != true) {
        _handleNoInternetException();
      }
      context.showMessageError(e.messageFull);
      onError?.call(e);
    } finally {
      onFinally?.call();
    }
  }

  bool _hasInternetConnection() {
    return _connectivityCubit.isConnectionSuccess;
  }

  void _handleNoInternetException() {
    // Show error dialog no internet
  }
}
