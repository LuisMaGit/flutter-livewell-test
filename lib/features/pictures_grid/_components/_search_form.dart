part of '../pictures_grid.dart';

class _SearchForm extends HookConsumerWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pictureGridViewModelProvider);
    final events = ref.watch(pictureGridViewModelProvider.notifier);

    bool enabled() {
      return state.uiState != PictureGridUIState.loading;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSpace2),
      child: SearchForm(
        onSubmitSearch: events.setSearch,
        hint: Sentences.picturesGridFormHint(),
        enabled: enabled(),
      ),
    );
  }
}
