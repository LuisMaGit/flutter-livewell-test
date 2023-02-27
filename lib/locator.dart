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

final locator = GetIt.instance;
Future<void> configureDependencies() async {
  locator
    ..registerFactory(() => PaginationService())
    ..registerLazySingleton(() => ThemeService())
    ..registerFactory<IEnvironmentService>(() => EnvironmentService())
    ..registerFactory<IPathProviderService>(() => PathProviderService())
    ..registerFactory<IImageDownloadService>(() => ImageDownloadService())
    ..registerFactory<IPictureNetworkService>(() => PictureNetworkService())
    ..registerFactory<IImageSaveGalleryService>(() => ImageSaveGalleryService())
    ..registerLazySingleton<IConectivityService>(() => ConectivityService())
    ..registerLazySingleton(() => QuickSnackbarService())
    ..registerLazySingleton<IPermissionService>(() => PermissionsService())
    ..registerLazySingleton<IPlatformService>(() => PlatformService());
}

void removeRegistrationIfExists<T extends Object>(){
    if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

final pictureGridViewModelProvider =
    StateNotifierProvider<PictureGridViewModel, PictureGridState>(
  (_) => PictureGridViewModel(),
);

final pictureDetailsViewModelProvider =
    StateNotifierProvider.autoDispose<PictureDetailsViewModel, PictureDetailsState>(
  (ref) {
    final picture = ref.read(pictureGridViewModelProvider).selectedPicture;
    return PictureDetailsViewModel(picture: picture);
  },
);

final startupViewModelProvider =
    StateNotifierProvider<StartupViewModel, StartupState>(
  (_) => StartupViewModel(),
);

final themeProvider = StateNotifierProvider<ThemeNotifier, LiveWellTheme>(
  (_) => ThemeNotifier(),
);
