class PaginationService {
  int _pageSize = 20;
  int _lastIndex = 0;
  int _pageObtainedSize = 0;
  bool _isReadyForAnotherCall = false;
  int _pageDesiredSize = 0;
  int _pageCounter = 1;

  ///These must be set affter getting every page
  void setControlParamsFromSuccessPage({
    required int pageObtainedSize,
  }) {
    _pageObtainedSize = pageObtainedSize;
    _lastIndex = _pageObtainedSize - 1;
    _pageDesiredSize = _pageCounter * _pageSize;
    _pageCounter++;
    _isReadyForAnotherCall = true;
  }

  ///Check if it is at the end of the scroll (_lastIndex), if the page requested is equals at thes sames obtained (_pageObtainedSize == _pageDesiredSize)
  ///and if have been already invoked
  bool shouldRequestOtherPage(int index) {
    final should = index >= _lastIndex && missingData && _isReadyForAnotherCall;
    if (should) {
      _isReadyForAnotherCall = false;
      return true;
    }

    return false;
  }

  set pageSize(int value) => _pageSize = value;
  int get getPageSize => _pageSize;
  int get nextPage => _pageCounter;
  bool get missingData => _pageObtainedSize == _pageDesiredSize;

  void dispose() {
    _lastIndex = 0;
    _pageObtainedSize = 0;
    _isReadyForAnotherCall = false;
    _pageDesiredSize = 0;
    _pageCounter = 1;
  }
}
