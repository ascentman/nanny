import 'package:firebase_analytics/firebase_analytics.dart';

abstract class IAnalyticsService {
  Future<void> logEvent(String name);
}

class AnalyticsService implements IAnalyticsService {
  final FirebaseAnalytics _analyticsService = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name) async {
    await _analyticsService.logEvent(name: name);
  }
}
