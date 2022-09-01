import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_share_kit/social_share_kit.dart';
import 'package:social_share_kit_example/utils/file_loader.dart';
import 'package:social_share_kit_example/widgets/platform_icon_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final availableAppsFuture = SocialShareKit.getAvailableApps();
  final md5SignatureFuture = SocialShareKit.getMd5Signature();
  final fileLoader = FileLoader.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SocialShareKit Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Available apps:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FutureBuilder<Map<String, dynamic>?>(
                future: availableAppsFuture,
                builder: (context, snapshot) {
                  final availableApps = snapshot.data;
                  if (availableApps != null) {
                    availableApps.removeWhere((key, value) => value == false);
                    return Wrap(
                      children: [
                        for (final app in availableApps.entries) ...[
                          PlatformIconButton(
                            platformName: app.key,
                            action: '',
                            onPressed: () {
                              // SocialShareKit.instagram.direct(
                              //   file: fileLoader.image,
                              //   contentUrl: 'https://www.kaique.dev/',
                              // );
                              //
                              SocialShareKit.tiktok.greenSreenImage(
                                file: fileLoader.image,
                              );
                              //
                              // SocialShareKit.instagram.directMessage(
                              //   message: 'Hi from Flutter',
                              // );
                            },
                          )
                        ]
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              if (Platform.isAndroid) ...[
                Text(
                  'Md5 hash:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FutureBuilder<String?>(
                  future: md5SignatureFuture,
                  builder: (context, snapshot) {
                    return SelectableText.rich(
                      TextSpan(
                        text: snapshot.data ?? '',
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
