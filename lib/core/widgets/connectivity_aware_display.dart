import 'package:doktor_randevu/core/util/connectivity_service.dart';
import 'package:flutter/material.dart';

class ConnectivityAwareDisplay extends StatelessWidget {
  final Widget whenConnected;
  final Widget whenNotConnected;

  const ConnectivityAwareDisplay({
    required this.whenConnected,
    required this.whenNotConnected,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: true,
      stream: ConnectivityService().hasConnection$,
      builder: (context, snapshot) {
        final hasConnection = snapshot.data ?? true;
        return hasConnection ? whenConnected : whenNotConnected;
      },
    );
  }
}
