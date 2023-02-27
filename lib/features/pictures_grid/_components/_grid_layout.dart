part of '../pictures_grid.dart';

class _GridLayout extends HookConsumerWidget {
  const _GridLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final state = ref.watch(pictureGridViewModelProvider);
    final events = ref.watch(pictureGridViewModelProvider.notifier);

    ref.listen(
      pictureGridViewModelProvider,
      (previous, current) {
        if (current.uiEvent == PictureGridUIEvent.goToDetails) {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (_) => const PictureDetails()),
          );
        }
      },
    );

    Widget initial() {
      return Center(
        child: LiveWellText.h1(
          Sentences.picturesGridScreenDescription(),
          align: TextAlign.center,
          color: theme.colors.contrastBackground,
        ),
      );
    }

    Widget loading() {
      return const Center(child: Loader());
    }

    Widget error() {
      return Center(child: GenericError(onTap: events.tryAgain));
    }

    Widget emtpy() {
      return Center(child: EmptySearch(search: state.search));
    }

    Widget success() {
      final picturesCount = state.pictures.length;
      final itemCount =
          state.existsMoreDataInSearch ? picturesCount + 1 : picturesCount;
      return GridColumnBuilder(
        builder: (coulumnCount) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: coulumnCount,
          ),
          itemCount: itemCount,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) => index == picturesCount
              ? const Center(child: Loader())
              : VisibilityDetector(
                  key: Key(WidgetKeys.pictureVisibility(index)),
                  onVisibilityChanged: (_) => events.handlePagination(index),
                  child: _PictureCard(
                    color: theme.colors.contrastBackground,
                    index: index,
                    onTapPicture: events.goToPictureDetails,
                    url: state.pictures[index].urlMedium,
                  ),
                ),
        ),
      );
    }

    return Builder(
      builder: (context) {
        if (state.uiState == PictureGridUIState.initial) {
          return initial();
        }

        if (state.uiState == PictureGridUIState.loading) {
          return loading();
        }

        if (state.uiState == PictureGridUIState.error) {
          return error();
        }

        if (state.uiState == PictureGridUIState.empty) {
          return emtpy();
        }

        if (state.uiState == PictureGridUIState.success) {
          return success();
        }

        return const SizedBox();
      },
    );
  }
}
