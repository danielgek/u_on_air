import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nm/nm.dart';

import 'package:yaru/yaru.dart' as yaru_theme;
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:desktop_notifications/desktop_notifications.dart';

import 'pages/wifi.dart';
import 'pages/widgets_showcase.dart';

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
    builder: (_) => WidgetsShowCasePage(),
  ),
  YaruPageItem(
    title: 'Wi-fi',
    iconData: YaruIcons.network_wireless,
    builder: (_) => const WifiPage(),
  ),
];
