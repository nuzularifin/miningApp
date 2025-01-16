import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/core/service_locator.dart' as di;
import 'package:flutter_test_synapsys/core/themes/app_theme.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_bloc.dart';
import 'package:flutter_test_synapsys/presentation/installation_screen.dart';

Future<void> main() async {
  di.setup();
  runApp(const MiningApp());
}

class MiningApp extends StatefulWidget {
  const MiningApp({super.key});

  @override
  State<MiningApp> createState() => _MiningAppState();
}

class _MiningAppState extends State<MiningApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (_) => DeviceManagerBloc(di.sl()),
        child: const InstallationScreen(),
      ),
    );
  }
}
