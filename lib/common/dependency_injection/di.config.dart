// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/common/dependency_injection/di.module.dart' as _i596;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../networking/api.dart' as _i489;
import '../../data/datasource/remote/client/product_client.dart' as _i1013;
import '../../data/repositories/product_repository_impl.dart' as _i839;
import '../../domain/repositories/product_repository.dart' as _i747;
import '../../features/product/cubit/product_detail/product_detail_cubit.dart'
    as _i370;
import '../../features/product/cubit/product_list/product_list_cubit.dart'
    as _i1002;
import '../../features/settings/theme/cubit/theme_cubit.dart' as _i570;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i596.CorePackageModule().init(gh);
    gh.factory<_i489.Api>(() => _i489.Api.create());
    gh.factory<_i1013.ProductClient>(() => _i1013.ProductClient.create());
    gh.singleton<_i570.ThemeCubit>(() => _i570.ThemeCubit());
    gh.factory<_i747.ProductRepository>(
        () => _i839.ProductRepositoryImpl(client: gh<_i1013.ProductClient>()));
    gh.factory<_i1002.ProductListCubit>(() =>
        _i1002.ProductListCubit(repository: gh<_i747.ProductRepository>()));
    gh.factory<_i370.ProductDetailCubit>(() =>
        _i370.ProductDetailCubit(repository: gh<_i747.ProductRepository>()));
    return this;
  }
}
