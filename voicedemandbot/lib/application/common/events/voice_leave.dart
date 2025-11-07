import 'dart:async';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';
import 'package:mineral/src/api/server/voice_state.dart';
import 'package:voice_demand_bot/application/common/states/voice_demand_state.dart';

final class VoiceLeave extends VoiceLeaveEvent with State {
  @override
  Future<void> handle(VoiceState? before, VoiceState after) async {
    if (before == null) return;

    final voiceDemand = state.read<VoiceDemandState>();
    final demand = voiceDemand.get(before.channelId!);

    if (demand == null) return;

    final channel = await before.resolveChannel();
    if (channel == null) return;

    if (channel.members.isEmpty) {
      await demand.channel.delete(reason: "Voice demand left");
      voiceDemand.remove(before.channelId!);
    }
  }
}