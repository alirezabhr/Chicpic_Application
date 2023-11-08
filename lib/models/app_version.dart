class AppVersion {
  final double id;
  final String version;
  final String platform;
  final String url;
  final bool forceUpdate;
  final List<dynamic> changes;
  final DateTime publishedAt;

  const AppVersion({
    required this.id,
    required this.version,
    required this.platform,
    required this.url,
    required this.forceUpdate,
    required this.changes,
    required this.publishedAt,
  });

  AppVersion.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        version = data['version'],
        platform = data['platform'],
        url = data['url'],
        forceUpdate = data['forceUpdate'],
        changes = data['changes'],
        publishedAt = DateTime.parse(data['publishedAt']);

  // TODO: write a unit test for this
  int compareVersion(String version) {
    return this.version.compareTo(version);
  }
}
