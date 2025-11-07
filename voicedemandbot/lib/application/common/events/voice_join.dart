import 'dart:async';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';
import 'package:voice_demand_bot/application/common/entities/voice_config.dart';
import 'package:voice_demand_bot/application/common/entities/voice_demand_entity.dart';
import 'package:voice_demand_bot/application/common/states/voice_demand_state.dart';

final class VoiceJoin extends VoiceJoinEvent with State {
  @override
  Future<void> handle(VoiceState voiceState) async {
    final config = ioc.resolve<CommonConfig>();

    if (voiceState.channelId != config.initChannelId) return;
    
    final member = await voiceState.resolveMember();
    final server = await voiceState.resolveServer();
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
}