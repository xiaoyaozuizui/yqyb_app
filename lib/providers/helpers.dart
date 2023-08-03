/// Helper function to make a URL.
Uri makeUri(
  String serverUrl,
  String path, [
  int? id,
  String? objectMethod,
  Map<String, dynamic>? query,
]) {
  final Uri uriServer = Uri.parse(serverUrl);

  final pathList = [uriServer.path, 'api', 'v2', path];
  if (id != null) {
    pathList.add(id.toString());
  }
  if (objectMethod != null) {
    pathList.add(objectMethod);
  }

  final uri = Uri(
    scheme: uriServer.scheme,
    host: uriServer.host,
    port: uriServer.port,
    path: '${pathList.join('/')}/',
    queryParameters: query,
  );

  return uri;
}
