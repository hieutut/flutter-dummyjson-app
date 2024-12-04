import 'package:flutter_bloc/flutter_bloc.dart';

import '../logging/logging.dart';

class CubitBaseObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    printOut('onCreate', name: '${bloc.runtimeType}', colorCode: 32);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printOut('onChange:\nFrom : ${change.currentState}\nTo   : ${change.nextState}', name: '${bloc.runtimeType}', colorCode: 35);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    printOut('onError:\nError: $error\nStackTrace: $stackTrace', name: '${bloc.runtimeType}', colorCode: 31);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    printOut('onClose', name: '${bloc.runtimeType}', colorCode: 34);
  }
}
