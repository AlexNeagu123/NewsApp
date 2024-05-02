import 'package:final_project/utilities/constants.dart';
import 'package:flutter/material.dart';

IconData extractCategoryIcon(String category) {
  switch (category) {
    case ChannelCategories.business:
      return Icons.business;
    case ChannelCategories.sport:
      return Icons.sports_soccer;
    case ChannelCategories.politics:
      return Icons.policy;
    case ChannelCategories.news:
      return Icons.article;
    case ChannelCategories.gaming:
      return Icons.sports_esports;
    case ChannelCategories.technology:
      return Icons.computer;
    default:
      return Icons.category;
  }
}
