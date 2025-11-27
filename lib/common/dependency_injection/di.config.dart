// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/common/dependency_injection/di.module.dart' as _i596;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource/local/database/app_database.dart' as _i1004;
import '../../data/datasource/local/shared_preferences/local_storage_helper.dart'
    as _i30;
import '../../data/datasource/remote/client/product_client.dart' as _i72;
import '../../data/repositories/cart_repository_impl.dart' as _i915;
import '../../data/repositories/product_repository_impl.dart' as _i876;
import '../../domain/repositories/cart_repository.dart' as _i46;
import '../../domain/repositories/product_repository.dart' as _i933;
import '../../features/product/cubit/product_detail/product_detail_cubit.dart'
    as _i254;
import '../../features/product/cubit/product_list/product_list_cubit.dart'
    as _i727;
import '../../features/settings/theme/cubit/theme_cubit.dart' as _i959;
import '../networking/api.dart' as _i588;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i596.CorePackageModule().init(gh);
    gh.factory<_i588.Api>(() => _i588.Api.create());
    gh.factory<_i72.ProductClient>(() => _i72.ProductClient.create());
    gh.singleton<_i1004.AppDB>(() => _i1004.AppDB());
    await gh.singletonAsync<_i30.LocalStorageHelper>(
      () => _i30.LocalStorageHelper.init(),
      preResolve: true,
    );
    gh.singleton<_i959.ThemeCubit>(() => _i959.ThemeCubit());
    gh.factory<_i933.ProductRepository>(
      () => _i876.ProductRepositoryImpl(client: gh<_i72.ProductClient>()),
    );
    gh.factory<_i46.CartRepository>(
      () => _i915.CartRepositoryImpl(appDB: gh<_i1004.AppDB>()),
    );
    gh.factory<_i254.ProductDetailCubit>(
      () => _i254.ProductDetailCubit(repository: gh<_i933.ProductRepository>()),
    );
    gh.factory<_i727.ProductListCubit>(
      () => _i727.ProductListCubit(repository: gh<_i933.ProductRepository>()),
    );
    return this;
  }
}
