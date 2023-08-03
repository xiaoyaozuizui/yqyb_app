import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:permission_handler/permission_handler.dart';

import 'providers/auth.dart';
import 'providers/base_provider.dart';
import 'providers/user.dart';
import 'providers/scan.dart';
import 'providers/store.dart';
import 'providers/devices.dart';
import 'providers/inventory.dart';
import 'screens/auth_screen.dart';
import 'screens/home_tabs_screen.dart';
import 'screens/device.dart';
import 'screens/store.dart';
import 'screens/inventory_submit.dart';
import 'screens/scan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  [
    Permission.location,
    Permission.storage,
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan
  ].request().then((status) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(
            AppBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? UserProvider(AppBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, DevicesProvider>(
          create: (context) => DevicesProvider(
            AppBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? DevicesProvider(AppBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, StoreProvider>(
          create: (context) => StoreProvider(
            AppBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? StoreProvider(AppBaseProvider(base)),
        ),
        ChangeNotifierProxyProvider<AuthProvider, InventoryProvider>(
          create: (context) => InventoryProvider(
            AppBaseProvider(Provider.of<AuthProvider>(context, listen: false)),
          ),
          update: (context, base, previous) =>
              previous ?? InventoryProvider(AppBaseProvider(base)),
        ),
        ChangeNotifierProvider(create: (context) => ScanProvider()),
      ],
      child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'app',
                home: auth.isAuth
                    ? HomeTabsScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Scaffold(
                                    body: Center(
                                      child: Text('Loading...'),
                                    ),
                                  )
                                : AuthScreen(),
                      ),
                routes: {
                  DeviceScreen.routeName: (context) => DeviceScreen(),
                  StoreScreen.routeName: (context) => StoreScreen(),
                  SubmitScreen.routeName: (context) => SubmitScreen(),
                  ScanScreen.routeName: (context) => ScanScreen(),
                },
              )),
    );
  }
}
