// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' show min;

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../styles/app_theme.dart';
import '../../settings/theme/cubit/theme_cubit.dart';

class ProductListDrawer extends StatelessWidget {
  const ProductListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Container(
      width: min(350, ScreenUtil.instance.width * 0.8),
      color: context.colors.background,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil.instance.statusBarHeight + kSpace16),
          BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (previous, current) => previous.themeMode != current.themeMode,
            builder: (context, state) {
              final mode = state.themeMode;
              return _DrawerItem(
                text: mode.title,
                onTap: () {
                  themeCubit.toggleTheme();
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      color: mode.isLight ? context.colors.primary : context.colors.gray400,
                      size: kIconSize24,
                    ),
                    kBoxSpace4,
                    Switch.adaptive(
                      value: mode.isDark,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (value) {
                        themeCubit.toggleTheme();
                      },
                    ),
                    kBoxSpace4,
                    Icon(
                      Icons.nightlight_round,
                      color: mode.isDark ? context.colors.primary : context.colors.gray400,
                      size: kIconSize24,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _DrawerItem({
    required this.text,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: kPadding16Hor.add(kPadding12Ver),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: context.text.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              kBoxSpace12,
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
