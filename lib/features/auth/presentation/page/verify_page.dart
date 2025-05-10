import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:neww/features/auth/presentation/page/profile_page.dart';

import '../bloc/verify/verify_bloc.dart';
import '../bloc/verify/verify_event.dart';
import '../bloc/verify/verify_state.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;

  const VerifyScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? deviceId;
  int countdown = 120;
  Timer? _timer;

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

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
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
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<VerifyBloc, VerifyState>(
          builder: (context, state) {
            if (state is VerifyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VerifySuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              });
            }

            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                                label: const Text(''),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.teal,
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Image.asset('assets/images/verify.png', height: 120),
                            const SizedBox(height: 16),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'لطفاً کد ارسالی به شماره ',
                                style: const TextStyle(color: Colors.black87, fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: widget.phone,
                                    style: const TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(text: ' را وارد نمایید'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'کد ارسالی',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: const Icon(Icons.verified),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 16),
                            Text('لطفاً صبر کنید', style: TextStyle(color: Colors.grey[700])),
                            Text(
                              formatTime(countdown),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'شماره را اشتباه وارد کردید؟ روی اصلاح شماره کلیک نمایید',
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'ثبت کد فعال‌سازی',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

}
