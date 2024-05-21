import 'dart:convert';

import 'package:final_project/models/feeds/selected_channel/selected_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:uuid/uuid.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:intl/intl.dart';

class ErrorMessages {
  static const String emailEmpty = "Email cannot be empty";
  static const String invalidEmail = "Invalid email format";
  static const String passwordEmpty = "Password cannot be empty";
  static const String confirmPasswordEmpty = "Confirm password cannot be empty";
  static const String passwordsDoNotMatch = "Passwords do not match";
  static const String invalidCredentials = "Incorrect credentials";
  static const String unknownError = "Unknown error";
  static const String invalidDetails = "Invalid details";
}

class StringConstants {
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}

enum PageType {
  feedPage,
  welcomePage,
  channelsPage;
}

class ChannelCategories {
  static const business = 'Business';
  static const sport = 'Sport';
  static const news = 'News';
  static const gaming = 'Gaming';
  static const technology = 'Technology';
  static const politics = 'Politics';
}

class ChannelOptions {
  static SelectedChannel allFeed =
      SelectedChannel(id: const Uuid().v4(), name: "All Feed");
}

final dateFormats = [
  DateFormat('yyyy-MM-dd – kk:mm'),
  DateFormat('EEE, dd MMM yyyy'),
  DateFormat('yyyy-MM-ddTHH:mm:ssZ'),
  DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\''),
];

class TimeFrameOptions {
  static const today = 'Today';
  static const lastWeek = 'Last week';
  static const lastMonth = 'Last month';
}

String truncateWithEllipsis(String text, int maxLength) {
  if (text.length > maxLength) {
    return "${text.substring(0, maxLength)}..";
  }
  return text;
}

String truncateHtmlString(String htmlString, int length) {
  final document =
      htmlparser.parse(utf8.decode(htmlString.codeUnits, allowMalformed: true));

  final plainText = document.body!.text;
  final unescape = HtmlUnescape();
  final unescapedText = unescape.convert(plainText);

  debugPrint(plainText);
  debugPrint(unescapedText);

  return unescapedText.length > length
      ? '${unescapedText.substring(0, length)}...'
      : unescapedText;
}
