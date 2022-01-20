// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:desktop_notifications/desktop_notifications.dart';

class WidgetsShowCasePage extends StatelessWidget {
  const WidgetsShowCasePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
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
    );
  }
}
