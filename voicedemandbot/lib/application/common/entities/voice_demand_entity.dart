import 'package:mineral/api.dart';

final class VoiceDemand {
  final ServerVoiceChannel channel;
  final Member owner;
  final DateTime createdAt;

  VoiceDemand({
    required this.channel,
    required this.owner,
  }) : createdAt = DateTime.now();
}