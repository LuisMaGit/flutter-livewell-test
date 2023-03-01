import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:core/core_export.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_state.dart';

class PictureGridViewModel extends StateNotifier<PictureGridState> {
  PictureGridViewModel({
    required IPictureNetworkService picturesNetworkService,
    required PaginationService paginationService,
    this.initialState = const PictureGridState(),
  })  : _picturesNetworkService = picturesNetworkService,
        _paginationService = paginationService,
        super(initialState);

  //di
  final IPictureNetworkService _picturesNetworkService;
  final PaginationService _paginationService;

  final PictureGridState initialState;
  PictureGridState get getState => state;

  void _setState(PictureGridState newState) {
    state = newState.copyWith(
      uiEvent: PictureGridUIEvent.initial,
    );
  }

  Future<void> _searchPicturesAndSetState() async {
    final picturesPaginated = await _picturesNetworkService.getPictures(
      query: state.search,
      page: _paginationService.nextPage,
      perPage: _paginationService.getPageSize,
    );

    if (picturesPaginated == null) {
      _setState(state.copyWith(uiState: PictureGridUIState.error));
      return;
    }

    if (picturesPaginated.pictures.isEmpty) {
      _setState(state.copyWith(uiState: PictureGridUIState.empty));
      return;
    }

    final pictures = [...state.pictures, ...picturesPaginated.pictures];
    _paginationService.setControlParamsFromSuccessPage(
      pageObtainedSize: pictures.length,
    );
    _setState(
      state.copyWith(
        existsMoreDataInSearch: _paginationService.missingData,
        pictures: pictures,
        uiState: PictureGridUIState.success,
      ),
    );
  }

  //events
  Future<void> setSearch(String? search) async {
    if (search == null || search.isEmpty) {
      return;
    }
    _setState(
      state.copyWith(
        uiState: PictureGridUIState.loading,
        search: search,
        pictures: [],
      ),
    );
    _paginationService.dispose();
    await _searchPicturesAndSetState();
  }

  Future<void> tryAgain() async {
    _setState(
      const PictureGridState().copyWith(
        uiState: PictureGridUIState.loading,
        search: state.search,
      ),
    );
    _paginationService.dispose();
    await _searchPicturesAndSetState();
  }

  Future<void> handlePagination(int index) async {
    if (_paginationService.shouldRequestOtherPage(index)) {
      await _searchPicturesAndSetState();
    }
  }

  void goToPictureDetails(int idx) {
    final picture = state.pictures[idx];
    state = state.copyWith(
      uiEvent: PictureGridUIEvent.goToDetails,
      selectedPicture: picture,
    );
  }
}
