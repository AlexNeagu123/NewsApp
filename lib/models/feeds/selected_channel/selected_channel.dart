import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_channel.freezed.dart';
part 'selected_channel.g.dart';

@freezed
class SelectedChannel with _$SelectedChannel {
  const factory SelectedChannel({required String id, required String name}) =
      _SelectedChannel;

  factory SelectedChannel.fromJson(Map<String, dynamic> json) =>
      _$SelectedChannelFromJson(json);
}
