import 'dart:io';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/utils.dart';
import 'package:voice_demand_bot/application/common/entities/voice_config.dart';
import 'package:voice_demand_bot/application/common/events/voice_join.dart';
import 'package:voice_demand_bot/application/common/events/voice_leave.dart';
import 'package:voice_demand_bot/application/common/events/voice_move.dart';
import 'package:voice_demand_bot/application/common/events/welcome_event.dart';
import 'package:voice_demand_bot/application/common/states/voice_demand_state.dart';

final class CommonProvider extends Provider with State {
  final Client _client;

  CommonProvider(this._client) {
    _client.register<VoiceDemandState>(VoiceDemandState.new);

    _client.register(VoiceJoin.new);
    _client.register(VoiceLeave.new);
    _client.register(VoiceMove.new);
    _client.register(WelcomeEvent.new);
  }

  @override
  void ready() {
    final config = File("config/common.yml").readAsYamlSync();
    ioc.make<CommonConfig>(() => CommonConfig.of(config));

    print("Common provider is ready !");
  }
}