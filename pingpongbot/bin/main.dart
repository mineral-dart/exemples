import 'package:mineral/api.dart';
import 'package:mineral_cache/providers/memory.dart';

void main(_, port) async {
  print('Hello 🚀');

  final client = ClientBuilder().setCache(MemoryProvider.new).setHmrDevPort(port).build();

  client.events.server.serverCreate((server) async {
    client.logger.info('${server.name} was created !');
  });

  client.events.ready((bot) async {
    client.logger.info('Bot is ready as ${bot.username}!');
  });

  client.commands.declare((command) {
    command
      ..setName('ping')
      ..setDescription('Receive pong !')
      ..setContext(CommandContextType.server)
      ..setHandle((ServerCommandContext ctx) async {
        final now = DateTime.now();
        final diff = now.difference(ctx.interaction.createdAt);

        final builder = MessageBuilder.text(
            "pong: `${diff.inMilliseconds}ms`\n"
            "interaction id: `${ctx.id}`\n"
            "interaction time: `${ctx.interaction.createdAt}`\n"
            "response time: `${now.toUtc()}`",
          );

        await ctx.interaction.reply(builder: builder, ephemeral: true);
      });
  });

  await client.init();
}
