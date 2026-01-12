import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to watch connection state (true = online, false = offline)
final connectivityProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((
    List<ConnectivityResult> results,
  ) {
    // If ANY result is not none, we have connection (simplistic but works for most cases)
    // Actually, 'none' means strictly no connection.
    return !results.contains(ConnectivityResult.none);
  });
});

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}
