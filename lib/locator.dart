import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/data/data_export.dart';
import 'package:livewell_test/features/picture_details/picture_details_state.dart';
import 'package:livewell_test/features/picture_details/picture_details_viewmodel.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_state.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_viewmodel.dart';
import 'package:livewell_test/features/startup/startup_state.dart';
import 'package:livewell_test/features/startup/startup_viewmodel.dart';

final _locator = GetIt.instance;

Future<void> configureDependencies() async {
  _locator
    ..registerFactory(() => PaginationService())
    ..registerLazySingleton(() => ThemeService())
    ..registerFactory<IEnvironmentService>(() => EnvironmentService())
    ..registerFactory<IPathProviderService>(() => PathProviderService())
    ..registerFactory<IImageDownloadService>(() => ImageDownloadService())
    ..registerFactory<IPictureNetworkService>(
      () => PictureNetworkService(
        envService: _getDependency<IEnvironmentService>(),
      ),
    )
    ..registerFactory<IImageSaveGalleryService>(() => ImageSaveGalleryService())
    ..registerLazySingleton<IConectivityService>(() => ConectivityService())
    ..registerLazySingleton(() => QuickSnackbarService())
    ..registerLazySingleton<IPlatformService>(() => PlatformService())
    ..registerLazySingleton<IPermissionService>(
      () => PermissionsService(
        platformService: _getDependency<IPlatformService>(),
      ),
    );
}

T _getDependency<T extends Object>() {
  return _locator<T>();
}

final pictureGridViewModelProvider =
    StateNotifierProvider<PictureGridViewModel, PictureGridState>(
  (_) => PictureGridViewModel(
    paginationService: _getDependency<PaginationService>(),
    picturesNetworkService: _getDependency<IPictureNetworkService>(),
  ),
);

final pictureDetailsViewModelProvider = StateNotifierProvider.autoDispose<
    PictureDetailsViewModel, PictureDetailsState>(
  (ref) {
    final picture = ref.read(pictureGridViewModelProvider).selectedPicture;
    return PictureDetailsViewModel(
      pathProviderService: _getDependency<IPathProviderService>(),
      imageDownloadService: _getDependency<IImageDownloadService>(),
      permissionsService: _getDependency<IPermissionService>(),
      quickSnackbarService: _getDependency<QuickSnackbarService>(),
      imageSaveGallerySerice: _getDependency<IImageSaveGalleryService>(),
      picture: picture,
    );
  },
);

final startupViewModelProvider =
    StateNotifierProvider<StartupViewModel, StartupState>(
  (_) => StartupViewModel(
    themeService: _getDependency<ThemeService>(),
    conectivityService: _getDependency<IConectivityService>(),
    quickSnackbarService: _getDependency<QuickSnackbarService>(),
  ),
);

final themeProvider = StateNotifierProvider<ThemeNotifier, LiveWellTheme>(
  (_) => ThemeNotifier(
    themeService: _getDependency<ThemeService>(),
  ),
);
