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
    if (deviceId != null) {
      context.read<VerifyBloc>().add(
        VerifySubmitted(
          widget.phone,
          _codeController.text,
          deviceId!,
        ),
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
            return Center(child: CircularProgressIndicator());
          } else if (state is VerifySuccess) {
            return Center(child: Text('Access Granted!'));
          } else if (state is VerifyFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Time left: ${countdown}s'),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(labelText: 'کد ورد وارد نمایید'),
                ),
                ElevatedButton(
                  onPressed: submit,
                  child: Text('ثبت کد فعال سازی'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
