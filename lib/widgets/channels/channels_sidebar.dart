import 'package:final_project/providers/providers.dart';
import 'package:final_project/utilities/categories.dart';
import 'package:final_project/widgets/shared/vertical_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelsSidebar extends HookConsumerWidget {
  const ChannelsSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsCategoriesFuture = ref.watch(newsCategoriesProvider);
    return Flexible(
      flex: 2,
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newsCategoriesFuture.when(
              data: (categories) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return VerticalNavButton(
                        onTap: () => ref
                            .read(selectedCategoryProvider.notifier)
                            .state = categories[index],
                        buttonTitle: categories[index],
                        buttonIcon:
                            Icon(extractCategoryIcon(categories[index])),
                      );
                    },
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
              error: (error, stackTrace) => Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
