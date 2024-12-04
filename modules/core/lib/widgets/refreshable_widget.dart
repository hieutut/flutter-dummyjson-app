// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RefreshableWidget extends StatelessWidget {
  const RefreshableWidget({
    super.key,
    required this.refreshController,
    this.scrollController,
    this.onRefresh,
    this.onLoadMore,
    required this.builder,
  });

  final RefreshController refreshController;
  final ScrollController? scrollController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      scrollController: scrollController,
      enablePullDown: onRefresh != null,
      enablePullUp: onLoadMore != null,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      header: const MaterialClassicHeader(),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingIcon: CircularProgressIndicator(),
        canLoadingIcon: CircularProgressIndicator(),
        idleIcon: SizedBox.shrink(),
        loadingText: '',
        canLoadingText: '',
        idleText: '',
      ),
      child: builder(context),
    );
  }
}
