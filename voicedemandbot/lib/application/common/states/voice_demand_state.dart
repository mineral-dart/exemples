import 'package:mineral/api.dart';
import 'package:voice_demand_bot/application/common/entities/voice_demand_entity.dart';

final class VoiceDemandState implements GlobalState<Map<Snowflake, VoiceDemand>> {
  @override
  Map<Snowflake, VoiceDemand> state = {};

  void add(VoiceDemand demand) => state[demand.channel.id] = demand;
  void remove(Snowflake channelId) => state.remove(channelId);
  VoiceDemand? get(Snowflake channelId) => state[channelId];
}