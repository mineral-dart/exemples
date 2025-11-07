import 'package:mineral/api.dart';
import 'package:mineral_cache/providers/memory.dart';
import 'package:voice_demand_bot/application/common/common_provider.dart';

void main(_, port) async {
  print('Hello 🚀');

  final client = ClientBuilder()
      .setCache(MemoryProvider.new)
      .registerProvider(CommonProvider.new)
      .setHmrDevPort(port)
      .build();

  client.events.server.serverCreate((server) async {
    client.logger.info('${server.name} was created !');
  });

  client.events.ready((bot) async {
    client.logger.info('Bot is ready as ${bot.username}!');
  });


  await client.init();
}
