import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedMain extends HookConsumerWidget {
  const FeedMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Flexible(
      flex: 3,
      child: Center(
        child: Text('Main Content Area'),
      ),
    );
  }
}
