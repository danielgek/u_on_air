import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nm/nm.dart';

import 'package:yaru/yaru.dart' as yaru_theme;
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:desktop_notifications/desktop_notifications.dart';

import 'pages/wifi.dart';

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
    title: 'Widget ShowCase',
    iconData: YaruIcons.app_grid,
    builder: (_) => Column(
      children: [
        YaruSection(headline: 'Yaru Section headline', children: [
          YaruRow(
            trailingWidget: Text('yaru row'),
            actionWidget: TextButton(
              child: Text('action'),
              onPressed: () {},
            ),
            description: 'description',
            enabled: true,
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
            iconData: YaruIcons.keyboard_shortcuts,
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
            onPressed: (_) async {
              var client = NotificationsClient();
              await client.notify('Hello World!');
              await client.close();
            },
            labels: ['One', 'Two', 'Three'],
            selectedValues: [false, false, false],
          ),
        ])
      ],
    ),
  ),
  YaruPageItem(
    title: 'Wi-fi',
    iconData: YaruIcons.network_wireless,
    builder: (_) => const WifiPage(),
  ),
];
