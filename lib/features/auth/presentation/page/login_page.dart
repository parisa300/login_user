
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _agreedToTerms = false;

  void _sendPhoneNumber() {
    final phone = _phoneController.text.trim();

    if (phone.length == 11 && phone.startsWith('09') && _agreedToTerms) {
      // Dispatch the LoginRequested event
      context.read<LoginBloc>().add(LoginRequested(phone));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفاً شماره صحیح وارد کرده و قوانین را تایید نمایید')),
      );
    }
  }


  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality( // برای راست‌چین شدن
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFEF8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const Icon(Icons.lock_outline, size: 100, color: Colors.teal),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'لطفاً شماره موبایل خود را وارد نمایید',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'شماره موبایل',
                    border: OutlineInputBorder(),
                    counterText: '',
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() => _agreedToTerms = value!);
                      },
                    ),
                    const Expanded(
                      child: Text('قوانین و مقررات استفاده از اپ را مطالعه کرده و می‌پذیرم'),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _sendPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26C6DA),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("ارسال"),
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      // Show loading indicator or progress bar
                      // You can implement a loading widget or show a progress indicator here
                    } else if (state is LoginSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('کد ارسال شد: ${state.otp}')),
                      );
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطا: ${state.message}')),
                      );
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

