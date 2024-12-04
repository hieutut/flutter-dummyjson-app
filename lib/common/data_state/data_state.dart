enum DataState {
  init,
  loading,
  success,
  error;

  bool get isInit => this == DataState.init;
  bool get isLoading => this == DataState.loading;
  bool get isInitOrLoading => isInit || isLoading;
  bool get isSuccess => this == DataState.success;
  bool get isError => this == DataState.error;
}
