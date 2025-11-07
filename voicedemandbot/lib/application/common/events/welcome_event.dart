import 'dart:async';

import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';
import 'package:voice_demand_bot/application/common/entities/voice_config.dart';

final class WelcomeEvent extends ServerMemberAddEvent with State {
  @override
  Future<void> handle(Member member, Server server) async {
    final config = ioc.resolve<CommonConfig>();
    final welcomeChannel = await server.channels.get<ServerTextChannel>(config.welcomeChannelId);

    if (welcomeChannel == null) return;

    await welcomeChannel.send(MessageBuilder()..text("Welcome $member to Mineral, feel free to visit our [github](https://github.com/mineral-dart)!"));
  }
}