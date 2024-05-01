import 'package:final_project/utilities/constants.dart';
import 'package:final_project/widgets/shared/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelsScreen extends HookConsumerWidget {
  const ChannelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        appBar: Navbar(
          type: PageType.channelsPage,
        ),
        body: Text("Hello World"));
  }
}
