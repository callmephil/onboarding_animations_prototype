// ignore_for_file: prefer-single-widget-per-file

import 'package:app/theme/app_sizes.dart';
import 'package:app/widgets/upload_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.s12,
            horizontal: AppSizes.s24,
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Register'),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Registration',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(AppSizes.s24),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).longestSide,
        ),
        child: Column(
          spacing: AppSizes.s16,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _firstName,
              decoration: const InputDecoration(labelText: 'First Name'),
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastName,
              decoration: const InputDecoration(labelText: 'Last Name'),
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              keyboardType: TextInputType.visiblePassword,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                return null;
              },
            ),
            UploadField(onTap: () {}, label: 'Upload Driving License'),
          ],
        ),
      ),
    );
  }
}
