import 'package:core/core_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_state.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_viewmodel.dart';
import 'package:livewell_test/locator.dart';
import 'package:mockito/mockito.dart';
import '../mocks/core_mocks.dart';

void _registerDependencies() {
  getAndRegisterPaginationService();
  getAndRegisterPictureNetworkService();
}

void _unRegisterDependencies() {
  removeRegistrationIfExists<PaginationService>();
  removeRegistrationIfExists<IPictureNetworkService>();
}

const _initialState = PictureGridState();
const _search = 'dog';
final _initialPictures = List<Picture>.generate(
  5,
  (index) => Picture(id: index, name: 'picture $index'),
);
final _initialStateWithPictures = _initialState.copyWith(
  pictures: _initialPictures,
  search: _search,
);

void main() {
  setUpAll(_registerDependencies);
  tearDownAll(_unRegisterDependencies);

  group(
    '$PictureGridViewModel - ',
    () {
      group(
        'initialization - ',
        () {
          test(
            'Given a new viewmodel, the state must be initial',
            () {
              final vm = PictureGridViewModel();
              expect(vm.getState, _initialState);
            },
          );
        },
      );
      group(
        'events - ',
        () {
          group('setSearch - ', () {
            test(
              'Given an empty/null search, the state should not change',
              () {
                final vm = PictureGridViewModel();
                vm.setSearch('');
                vm.setSearch(null);
                expect(vm.getState, _initialState);
              },
            );
            test(
              'Given a not empty/null search, the ui state must be loading, '
              'the search stored, the picures cleared, the pagination service disposed '
              'and call the search pictures api',
              () {
                //arrange
                const nextPage = 343;
                const pageSize = 252;
                final paginationMock = getAndRegisterPaginationService(
                  nextPageStub: nextPage,
                  pageSizeStub: pageSize,
                );
                final picturesNetwokMock =
                    getAndRegisterPictureNetworkService();
                const _loadingState = PictureGridState(
                  uiState: PictureGridUIState.loading,
                  search: _search,
                  pictures: [],
                );
                final vm = PictureGridViewModel();
                //act
                vm.setSearch(_search);
                expect(vm.getState, _loadingState);
                //assert
                verify(paginationMock.dispose());
                verify(
                  picturesNetwokMock.getPictures(
                    query: _search,
                    page: nextPage,
                    perPage: pageSize,
                  ),
                );
              },
            );
            test(
              'Given an error from the api, the ui state must be error',
              () async {
                final vm = PictureGridViewModel();
                await vm.setSearch(_search);
                expect(
                  vm.getState,
                  _initialState.copyWith(
                    search: _search,
                    uiState: PictureGridUIState.error,
                  ),
                );
              },
            );
            test(
              'Given an empty response from the api, the ui state must be empty',
              () async {
                getAndRegisterPictureNetworkService(
                  picturesRespStub: PicturesPaginated(pictures: []),
                );
                final vm = PictureGridViewModel();
                await vm.setSearch(_search);
                expect(
                  vm.getState,
                  _initialState.copyWith(
                    search: _search,
                    uiState: PictureGridUIState.empty,
                  ),
                );
              },
            );
            test(
              'Given a first success response from the api, the ui state must be success '
              'append the pictures to the state and handle the pagination',
              () async {
                final _initialPictures = List<Picture>.generate(
                  5,
                  (index) => Picture(id: index, name: 'picture $index'),
                );
                final _missingData = true;
                final _stateWithFirstPictures = _initialState.copyWith(
                  search: _search,
                  existsMoreDataInSearch: _missingData,
                  uiState: PictureGridUIState.success,
                  pictures: _initialPictures,
                );
                getAndRegisterPictureNetworkService(
                  picturesRespStub: PicturesPaginated(
                    pictures: _initialPictures,
                  ),
                );
                final mockPagination = getAndRegisterPaginationService(
                  missinDataStub: _missingData,
                );
                final vm = PictureGridViewModel();
                //act
                await vm.setSearch(_search);
                //assert
                verify(
                  mockPagination.setControlParamsFromSuccessPage(
                    pageObtainedSize: _initialPictures.length,
                  ),
                );
                expect(vm.getState, _stateWithFirstPictures);
              },
            );
          });
          group('handlePagination - ', () {
            test(
              'Given the pagination trigger is ON and a success api response, then should '
              'append the pictures to the state and handle the pagination',
              () async {
                //arrage
                final _picturesToAppend = List<Picture>.generate(
                  5,
                  (index) {
                    final next = index + 5;
                    return Picture(id: next, name: 'picture $next');
                  },
                );
                final _fullData = [..._initialPictures, ..._picturesToAppend];
                final _missingData = true;
                final _stateWith2Pages = _initialState.copyWith(
                  search: _search,
                  existsMoreDataInSearch: _missingData,
                  uiState: PictureGridUIState.success,
                  pictures: _fullData,
                );
                final _indexTrigger = 231331;
                getAndRegisterPictureNetworkService(
                  picturesRespStub: PicturesPaginated(
                    pictures: _picturesToAppend,
                  ),
                );
                final mockPagination = getAndRegisterPaginationService(
                  missinDataStub: _missingData,
                  shouldRequestOtherPageStub: true,
                );
                final vm = PictureGridViewModel(
                  initialState: _initialStateWithPictures,
                );
                //act
                await vm.handlePagination(_indexTrigger);
                //assert
                verify(
                  mockPagination.shouldRequestOtherPage(_indexTrigger),
                );
                verify(
                  mockPagination.setControlParamsFromSuccessPage(
                    pageObtainedSize: _fullData.length,
                  ),
                );
                expect(vm.getState, _stateWith2Pages);
              },
            );
            test(
              'Given the pagination trigger is OFF, should mantain the state',
              () {
                final mockPagination = getAndRegisterPaginationService(
                  shouldRequestOtherPageStub: false,
                );
                final _indexTrigger = 231331;
                final vm = PictureGridViewModel(
                  initialState: _initialStateWithPictures,
                );
                vm.handlePagination(_indexTrigger);
                verify(
                  mockPagination.shouldRequestOtherPage(_indexTrigger),
                );
                expect(vm.getState, _initialStateWithPictures);
              },
            );
          });

          group(
            'goToPictureDetails - ',
            () {
              test(
                'When called, should get the selected picture '
                'and trigger the ui event to go to the details screen',
                () {
                  final _indexPicture = 3;
                  final selectedPicture =
                      _initialStateWithPictures.pictures[_indexPicture];
                  final vm = PictureGridViewModel(
                    initialState: _initialStateWithPictures,
                  );
                  vm.goToPictureDetails(_indexPicture);
                  expect(
                    vm.getState,
                    _initialStateWithPictures.copyWith(
                      uiEvent: PictureGridUIEvent.goToDetails,
                      selectedPicture: selectedPicture,
                    ),
                  );
                },
              );
            },
          );
        },
      );
    },
  );
}
