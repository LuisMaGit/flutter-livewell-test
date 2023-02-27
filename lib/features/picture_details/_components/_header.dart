part of '../picture_details.dart';

class _Header extends HookConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider).colors;
    final picture = ref.watch(pictureDetailsViewModelProvider).picture;
    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: kSpace1),
      child: Row(
        children: [
          RippleButton(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(kSpace2),
              child: LiveWellIcons(
                icon: LiveWeelIconType.arrowBack,
              ),
            ),
          ),
          LSpacers.h1,
          Expanded(
            child: LiveWellText.body1(
              picture.name,
              maxLines: 2,
            ),
          ),
          LSpacers.h1,
        ],
      ),
    );
  }
}
