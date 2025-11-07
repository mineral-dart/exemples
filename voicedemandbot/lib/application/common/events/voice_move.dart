import 'dart:async';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';
import 'package:voice_demand_bot/application/common/entities/voice_config.dart';
import 'package:voice_demand_bot/application/common/entities/voice_demand_entity.dart';
import 'package:voice_demand_bot/application/common/states/voice_demand_state.dart';

final class VoiceMove extends VoiceMoveEvent with State {
  @override
  Future<void> handle(VoiceState? before, VoiceState after) async {
    final config = ioc.resolve<CommonConfig>();

    if (after.channelId == config.initChannelId) {
      final member = await after.resolveMember();
      final server = await after.resolveServer();
      if (member!.isBot) return;

      final channelBuilder = ChannelBuilder(ChannelType.guildVoice)
        ..setParentId(config.parentId)
        ..setName("🔊・${member.username}");

      final channel = await server.channels.create<ServerVoiceChannel>(channelBuilder);
      final voiceCtx = await member.resolveVoiceContext();

      await voiceCtx.move(channel.id.value);

      final voiceDemand = state.read<VoiceDemandState>();
      voiceDemand.add(VoiceDemand(
        owner: member,
        channel: channel,
      ));
    }

    if (before != null) {
      final voiceDemand = state.read<VoiceDemandState>();
      final demand = voiceDemand.get(before.channelId!);

      if (demand == null) return;

      final channel = await before.resolveChannel();

      if (channel == null) return;

      if (channel.members.length == 0) {
        await demand.channel.delete(reason: "Voice demand left");
        voiceDemand.remove(before.channelId!);
      }
    }
  }
}