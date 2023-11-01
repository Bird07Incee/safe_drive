class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;

  String get fullRoute => Uri(path: route, queryParameters: _queryParameters.isEmpty ? null : _queryParameters).toString();
  Map<String, String> get queryParameters => _queryParameters;

  RoutingData({
    required this.route,
    required Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}
