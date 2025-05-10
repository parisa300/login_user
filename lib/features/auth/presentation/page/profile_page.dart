
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile/profile_entity.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../bloc/profile/update_profile_event.dart';

class ProfilePage extends StatefulWidget {


  const ProfilePage({super.key,

  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
@override
  void initState() {
  context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            _firstNameController.text = state.profile.firstName ?? '';
            _lastNameController.text = state.profile.lastName ?? '';
            _emailController.text = state.profile.email ?? '';
            _phoneController.text = state.profile.phone ?? '';
          }  else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded ) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                      final updatedProfile = ProfileEntity(
                        phone: _phoneController.text,
                        email: _emailController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        address: null,
                        postalCode: null,
                        fixedNumber: null,
                        gender: "Other",
                        nationalCode: null,
                        cardNumber: null,
                        profileImage: null,
                        birthDate: null,
                        shebaNumber: null,
                      );
                      context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
                    },
                  child: const Text('ذخیره'),
                ),
              ],
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('load'));
        },
      ),
    );
  }
}

