import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  final InternetConnectionChecker _connectivityChecker = InternetConnectionChecker();
  final _hasConnectionController = BehaviorSubject<bool>.seeded(true);

  // Private constructor
  ConnectivityService._internal() {
    _initialize();
  }

  factory ConnectivityService() {
    return _instance;
  }

  // Stream to listen to connection changes
  Stream<bool> get hasConnection$ => _hasConnectionController.stream;

  // Initialize the service
  Future<void> _initialize() async {
    final initialStatus = await _connectivityChecker.hasConnection;
    _hasConnectionController.add(initialStatus);
    _listenForOffline();
  }

  // Start listening for connection status changes
  void _listenForOffline() {
    _connectivityChecker.onStatusChange.listen((status) {
      _hasConnectionController.add(status != InternetConnectionStatus.disconnected);
    });
  }

  // Close the stream controller when done
  void close() {
    _hasConnectionController.close();
  }
}

