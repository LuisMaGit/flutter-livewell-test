part of '../picture_details.dart';

class _SubmitButton extends HookConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(pictureDetailsViewModelProvider.notifier);

    return PrimaryButton(
      icon: const LiveWellIcons(icon: LiveWeelIconType.download),
      text: Sentences.pictureDetailsDownloadButton(),
      onTryAgain: event.download,
    );
  }
}