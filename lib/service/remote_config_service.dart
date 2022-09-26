import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class IRemoteConfigService {
  Future<bool> fetchUpdates();
  String get hourPrice;
  String get dayPrice;
  String get weekPrice;
  String get monthPrice;
}

class RemoteConfigService implements IRemoteConfigService {
  final _hourPrice = 'hourPrice';
  final _dayPrice = 'dayPrice';
  final _weekPrice = 'weekPrice';
  final _monthPrice = 'monthPrice';
  late FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService() {
    _remoteConfig = FirebaseRemoteConfig.instance;
    _remoteConfig.setDefaults(
      <String, dynamic>{
        _hourPrice: 0,
        _dayPrice: 0,
        _weekPrice: 0,
        _monthPrice: 0,
      },
    );
  }

  @override
  String get hourPrice => _remoteConfig.getString(_hourPrice);
  @override
  String get dayPrice => _remoteConfig.getString(_dayPrice);
  @override
  String get weekPrice => _remoteConfig.getString(_weekPrice);
  @override
  String get monthPrice => _remoteConfig.getString(_monthPrice);

  @override
  Future<bool> fetchUpdates() => _remoteConfig.fetchAndActivate();
}
