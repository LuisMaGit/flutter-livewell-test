import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livewell_test/locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core_mocks.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PaginationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<IPictureNetworkService>(onMissingStub: OnMissingStub.returnDefault),
])
PaginationService getAndRegisterPaginationService({
  int? nextPageStub,
  int? pageSizeStub,
  bool? shouldRequestOtherPageStub,
  bool? missinDataStub,
}) {
  removeRegistrationIfExists<PaginationService>();
  final mock = MockPaginationService();
  if (nextPageStub != null) {
    when(mock.nextPage).thenReturn(nextPageStub);
  }
  if (pageSizeStub != null) {
    when(mock.getPageSize).thenReturn(pageSizeStub);
  }
  if (shouldRequestOtherPageStub != null) {
    when(mock.shouldRequestOtherPage(argThat(isNotNull)))
        .thenReturn(shouldRequestOtherPageStub);
  }
  if (missinDataStub != null) {
    when(mock.missingData).thenReturn(missinDataStub);
  }
  locator.registerSingleton<PaginationService>(mock);
  return mock;
}

IPictureNetworkService getAndRegisterPictureNetworkService({
  PicturesPaginated? picturesRespStub,
}) {
  removeRegistrationIfExists<IPictureNetworkService>();
  final mock = MockIPictureNetworkService();
  if (picturesRespStub != null) {
    when(mock.getPictures(
      query: argThat(isNotNull, named: 'query'),
      page: argThat(isNotNull, named: 'page'),
      perPage: argThat(isNotNull, named: 'perPage'),
    )).thenAnswer((_) async => picturesRespStub);
  }
  locator.registerSingleton<IPictureNetworkService>(mock);
  return mock;
}
