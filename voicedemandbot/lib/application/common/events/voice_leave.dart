import 'dart:async';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';
import 'package:mineral/src/api/server/voice_state.dart';
import 'package:voice_demand_bot/application/common/states/voice_demand_state.dart';

final class VoiceLeave extends VoiceLeaveEvent with State {
  @override
  Future<void> handle(VoiceState after) async {
    final voiceDemand = state.read<VoiceDemandState>();
    final demand = voiceDemand.get(after.channelId!);

    if (demand == null) return;

    final channel = await after.resolveChannel();
    if (channel == null) return;

    if (channel.members.isEmpty) {
      await demand.channel.delete(reason: "Voice demand left");
      voiceDemand.remove(after.channelId!);
    }
  }
}