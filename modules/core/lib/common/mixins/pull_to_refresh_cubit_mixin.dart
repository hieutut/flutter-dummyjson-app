import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

mixin PullToRefreshCubitMixin<T> on Cubit<T> {
  final RefreshController refreshController = RefreshController();

  void loadCompleted() {
    refreshController
      ..refreshCompleted()
      ..loadComplete();
  }

  void loadNoMoreData() {
    refreshController.loadNoData();
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}
