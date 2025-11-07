final class CommonConfig {
  final String parentId;
  final String initChannelId;
  final String welcomeChannelId;

  CommonConfig({
    required this.parentId,
    required this.initChannelId,
    required this.welcomeChannelId
  });

  factory CommonConfig.of(final payload) {
    return CommonConfig(parentId: payload['voice']['parent_id'], initChannelId: payload['voice']['init_channel_id'], welcomeChannelId: payload['welcome_channel_id']);
  }
}
