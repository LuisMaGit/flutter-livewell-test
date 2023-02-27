import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';

class SearchForm extends HookWidget {
  const SearchForm({
    required this.onSubmitSearch,
    required this.hint,
    required this.enabled,
    this.initialSearch = '',
    this.maxLines = 1,
    this.width = 2,
    super.key,
  });

  final void Function(String value) onSubmitSearch;
  final String initialSearch;
  final String hint;
  final int maxLines;
  final double width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    late final TextEditingController searchController;
    final showCleanIcon = useState(initialSearch.isNotEmpty);
    searchController = useTextEditingController.fromValue(
      TextEditingValue(
        text: initialSearch,
      ),
    )..addListener(() {
        final prevValue = showCleanIcon.value;
        final newValue = searchController.text.isNotEmpty;
        if (prevValue != newValue) {
          showCleanIcon.value = newValue;
        }
      });

    void actionChecker(VoidCallback action) {
      if (enabled) {
        action();
      }
    }

    Widget getSuffixIcon() {
      if (showCleanIcon.value) {
        return RippleButton(
          onTap: () => actionChecker(() => searchController.text = ''),
          child: const LiveWellIcons(
            icon: LiveWeelIconType.close,
          ),
        );
      }

      return const LiveWellIcons(
        icon: LiveWeelIconType.search,
      );
    }

    Widget getSearchButton(Color color) {
      if (showCleanIcon.value) {
        return RippleButton(
          onTap: () {
            actionChecker(() => onSubmitSearch(searchController.text));
          },
          child: Padding(
            padding: const EdgeInsets.all(kSpace1),
            child: LiveWellText.body1(
              Sentences.picturesGridFormSearchButton(),
              color: color,
            ),
          ),
        );
      }

      return const SizedBox();
    }

    return HookConsumer(
      builder: (context, ref, _) {
        final theme = ref.watch(themeProvider);
        final focusColor = theme.colors.principal;
        final enabledColor = theme.colors.inverseBackground;
        final disabledColor = theme.colors.contrastBackground;

        Color getStateColor() {
          return enabled ? enabledColor : disabledColor;
        }

        OutlineInputBorder getBorder(Color color) {
          return OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: width,
            ),
            borderRadius: BorderRadius.zero,
          );
        }

        return Row(
          children: [
            Expanded(
              child: TextFormField(
                onEditingComplete: () => onSubmitSearch(searchController.text),
                cursorColor: theme.colors.inverseBackground,
                style: theme.textStyles.body1,
                maxLines: maxLines,
                enabled: enabled,
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: hint,
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: theme.textStyles.body1.copyWith(
                    color: theme.colors.contrastBackground,
                  ),
                  suffixIconColor: getStateColor(),
                  suffixIcon: getSuffixIcon(),
                  focusedBorder: getBorder(focusColor),
                  enabledBorder: getBorder(enabledColor),
                  disabledBorder: getBorder(disabledColor),
                  contentPadding: const EdgeInsets.only(left: kSpace1),
                  isDense: true,
                ),
              ),
            ),
            LSpacers.h2,
            getSearchButton(focusColor),
            LSpacers.h1,
          ],
        );
      },
    );
  }
}
