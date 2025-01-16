import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_bloc.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_state.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_bloc.dart';
import 'package:flutter_test_synapsys/presentation/login_screen.dart';
import 'package:flutter_test_synapsys/utils/generate_string.dart';
import '../core/themes/app_color.dart';
import 'package:flutter_test_synapsys/core/service_locator.dart' as di;

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({super.key});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  double _progress = 0.0;
  bool _isFinished = false;
  final generator = RandomStringGenerator();
  String generateDeviceName = '';

  @override
  void initState() {
    super.initState();
    _startProgress();

    generateDeviceName = generator.generate(15);
  }

  void _startProgress() {
    const duration = Duration(milliseconds: 1000);
    const totalDuration = 3 * 1000;
    final steps = totalDuration ~/ duration.inMilliseconds;

    Timer.periodic(duration, (timer) {
      setState(() {
        _progress += 1 / steps;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        BlocProvider.of<DeviceManagerBloc>(context)
            .add(GetDeviceById(deviceName: 'DEVICE06'));
        setState(() {
          _isFinished = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContent(),
                const SizedBox(
                  height: 48,
                ),
                !_isFinished ? bodyContent() : installationFinishContent(),
                const SizedBox(
                  height: 48,
                ),
                bottomContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topContent() => Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dataset_linked_outlined,
              color: Colors.blue,
              size: 45,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Installation Wizard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  'Device must be registered before can be used',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget bodyContent() => Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              color: Colors.blue,
              value: _progress,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Please wait',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'We tried to install your device',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  Widget bottomContent() => BlocListener<DeviceManagerBloc, DeviceManagerState>(
      listener: (_, state) {
        if (state is DeviceManagerSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (_) => LoginBloc(di.sl()),
                      child: const LoginScreen(),
                    )),
          );
        } else if (state is DeviceManagerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Device Manager failed: ${state.message}'),
            ),
          );
        }
      },
      child: Container(child: const Text('version 1.0.0')));

  Widget installationFinishContent() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your serial number',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            width: 500,
            decoration: BoxDecoration(
              color: Colors.blue[50]?.withOpacity(0.5),
              border: Border.all(color: AppColors.Blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                generateDeviceName,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Waiting for activation',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.Blue,
            ),
          ),
        ],
      );
}
