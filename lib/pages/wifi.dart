// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

var client = NetworkManagerClient();

class WifiPage extends StatelessWidget {
  const WifiPage({Key? key}) : super(key: key);

  Widget availableNetworks(NetworkManagerDeviceWireless wireless,
      NetworkManagerDevice device, NetworkManagerClient client) {
    wireless.propertiesChanged.listen((_) {
      print(_);
    });
    return YaruSection(
        headline: 'Available networks',
        headerWidget: Text('Available networks'),
        children: [
          StreamBuilder<List<String>>(
              stream: wireless.propertiesChanged
                  .where((p) => p.contains('LastScan')),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error getting wifi scan'));
                }

                if (snapshot.hasData) {
                  Map<String, NetworkManagerAccessPoint> accessPointsMap = {};

                  wireless.accessPoints
                      .where((a) => a.ssid.isNotEmpty)
                      .forEach((element) {
                    if (accessPointsMap[utf8.decode(element.ssid)] != null &&
                        accessPointsMap[utf8.decode(element.ssid)]!.strength <
                            element.strength) {
                      accessPointsMap[utf8.decode(element.ssid)] = element;
                    } else if (accessPointsMap[utf8.decode(element.ssid)] ==
                        null) {
                      accessPointsMap[utf8.decode(element.ssid)] = element;
                    }
                  });

                  List<NetworkManagerAccessPoint> accessPoints =
                      accessPointsMap.values.toList();
                  accessPoints.sort((a, b) => b.strength.compareTo(a.strength));
                  // Sort by signal strength.
                  return Column(
                      children: accessPoints.map((accessPoint) {
                    var ssid = utf8.decode(accessPoint.ssid);
                    var strength = accessPoint.strength.toString().padRight(3);
                    return YaruRow(
                      trailingWidget: Text(ssid),
                      actionWidget: TextButton(
                          child: const Text('Connect'),
                          onPressed: () {
                            client.activateConnection(
                                device: device, accessPoint: accessPoint);
                          }),
                      description: "$strength%",
                      enabled: true,
                    );
                  }).toList());
                }

                return Center(
                    child: Column(children: [
                  CircularProgressIndicator(),
                  Text('Scanning networks...'),
                ]));
              })
        ]);
  }

  Widget currentConnection(
      NetworkManagerDeviceWireless wireless, NetworkManagerDevice device) {
    String headline = wireless.activeAccessPoint?.ssid != null
        ? utf8.decode(wireless.activeAccessPoint!.ssid)
        : 'Not connected';
    return YaruSection(headline: headline, children: [
      TextButton(
          onPressed: () {
            device.disconnect();
          },
          child: Text('Disconnect')),
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<void>(
            future: client.connect(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(children: const [
                  CircularProgressIndicator(),
                  Text('Connecting to wifi...'),
                ]));
              }

              NetworkManagerDevice device;
              try {
                device = client.devices.firstWhere(
                    (d) => d.deviceType == NetworkManagerDeviceType.wifi);
              } catch (e) {
                return Center(child: Text('No wifi device found'));
              }
              NetworkManagerDeviceWireless wireless = device.wireless!;
              wireless.requestScan();
              return Column(children: [
                currentConnection(wireless, device),
                availableNetworks(wireless, device, client),
              ]);
            }));
  }
}
