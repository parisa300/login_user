import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../bloc/verify/verify_bloc.dart';
import '../bloc/verify/verify_event.dart';
import '../bloc/verify/verify_state.dart';


class VerifyScreen extends StatefulWidget {
  final String phone;

  const VerifyScreen({required this.phone});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? deviceId;
  int countdown = 120;

  @override
  void initState() {
    super.initState();
    getDeviceId();
    startCountdown();
  }

  void getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    setState(() {
      deviceId = androidInfo.id;
    });
  }

  Timer? _timer;

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void submit() {
    final code = _codeController.text.trim();

    if (deviceId != null && code.isNotEmpty) {
      context.read<VerifyBloc>().add(
        VerifyRequested(
          phone: widget.phone,
          code: code,
          deviceId: deviceId!,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('کد تأیید را وارد کنید')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Code')),
      body: BlocBuilder<VerifyBloc, VerifyState>(
        builder: (context, state) {
          if (state is VerifyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VerifySuccess) {
            // Navigate to home screen or show success message
            return const Center(child: Text('Access Granted!'));
          }

          if (state is VerifyFailure) {
            return Center(child: Text('خطا: ${state.message}'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('زمان باقی‌مانده: ${countdown}s'),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'کد ورود را وارد نمایید'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('ثبت کد فعال‌سازی'),
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
