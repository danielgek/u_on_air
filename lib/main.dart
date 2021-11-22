import 'package:flutter/material.dart';

import 'package:yaru/yaru.dart' as yaru_theme;
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: yaru_theme.yaruLight,
      darkTheme: yaru_theme.yaruDark,
      home: YaruMasterDetailPage(
        appBarHeight: 48,
        leftPaneWidth: 280,
        previousIconData: YaruIcons.go_previous,
        searchHint: 'Search...',
        searchIconData: YaruIcons.search,
        pageItems: pageItems,
      ),
    );
  }
}

final pageItems = <YaruPageItem>[
  YaruPageItem(
    title: 'Calendar',
    iconData: YaruIcons.calendar,
    builder: (_) => Column(
      children: [
        YaruSection(headline: 'headline', children: [
          const YaruRow(
            trailingWidget: Text('trailingWidget'),
            actionWidget: Text('actionWidget'),
            description: 'description',
          ),
          YaruCheckboxRow(
            onChanged: (_) {},
            enabled: true,
            text: "Check Box",
            value: true,
          ),
          YaruExtraOptionRow(
            actionLabel: 'Repeat Keys',
            actionDescription: 'Key presses repeat when key is held down',
            value: true,
            onChanged: (_) {},
            onPressed: () {},
            iconData: YaruIcons.go_previous,
          ),
          YaruSliderRow(
            value: 50,
            onChanged: (_) {},
            min: 0,
            max: 100,
            actionLabel: 'Slider',
          ),
          YaruSwitchRow(
            value: true,
            onChanged: (_) {},
            actionDescription: 'Switch',
            trailingWidget: Text('trailingWidget'),
          ),
          YaruToggleButtonsRow(
            actionLabel: 'actionLabel',
            onPressed: (_) {},
            labels: ['One', 'Two', 'Three'],
            selectedValues: [false, false, false],
          ),
        ])
      ],
    ),
  ),
  YaruPageItem(
    title: 'Addons',
    iconData: YaruIcons.addon_filled,
    builder: (_) => YaruExtraOptionRow(
      actionLabel: 'Repeat Keys',
      actionDescription: 'Key presses repeat when key is held down',
      value: true,
      onChanged: (_) {},
      onPressed: () {},
      iconData: const IconData(0),
    ),
  ),
  YaruPageItem(
    title: 'Address Book',
    iconData: YaruIcons.address_book,
    builder: (_) => const Text('Address Book'),
  ),
];
