// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logic_folder/Bloc_folder/eye_hide_unhide/eye_state.dart';
import 'package:go_router/go_router.dart';
import '../Bloc_folder/create_account/create_account_bloc.dart';
import '../Bloc_folder/create_account/create_account_event.dart';
import '../Bloc_folder/create_account/create_account_state.dart';
import '../Bloc_folder/eye_hide_unhide/eye_bloc.dart';
import '../Bloc_folder/eye_hide_unhide/eye_event.dart';
import '../Integration_folder_with_backend/user_integration.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController blockNumberController = TextEditingController();

  Color passwordFieldColor = Colors.white.withOpacity(0.3); // Default color
  bool showCheckMark = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    countryController.dispose();
    cityController.dispose();
    houseNumberController.dispose();
    streetNumberController.dispose();
    postalCodeController.dispose();
    blockNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountAuthBloc(UserService()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<CreateAccountAuthBloc, CreateAccountAuthState>(
          listener: (context, state) {
            if (state is CreateAccountAuthSuccess) {
              setState(() {
                showCheckMark = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Future.delayed(const Duration(seconds: 2), () {
                context.go('/'); // Navigate to the next page after 2 seconds
              });
            } else if (state is CreateAccountAuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: _buildCreateAccountForm(),
        ),
      ),
    );
  }

  Widget _buildCreateAccountForm() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/signin1.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        Align(
          alignment: Alignment.center,
          child: _buildFrostedGlassContainer(),
        ),
        if (showCheckMark) _buildCheckMarkAnimation(),
      ],
    );
  }

  Widget _buildFrostedGlassContainer() {
    return Container(
      width: 900,
      height: 650,
      padding: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: _frostedGlassEffect(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildText('Create Account', 24, FontWeight.bold),
                const SizedBox(height: 20),
                _buildInputFields(),
                const SizedBox(height: 24),
                _buildCreateAccountButton(),
                const SizedBox(height: 16),
                _buildSignInLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _frostedGlassEffect() => BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5),
        ],
      );

  Widget _buildInputFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(emailController, 'Email', Icons.email),
              const SizedBox(height: 16),
              _buildPasswordField(passwordController, 'Password'),
              const SizedBox(height: 16),
              _buildPasswordField(confirmPasswordController, 'Confirm Password',
                  isConfirm: true),
              const SizedBox(height: 16),
              _buildTextField(fullNameController, 'Full Name', Icons.person),
              const SizedBox(height: 16),
              _buildTextField(
                  phoneNumberController, 'Phone Number', Icons.phone),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(countryController, 'Country', Icons.language),
              const SizedBox(height: 16),
              _buildTextField(cityController, 'City', Icons.location_city),
              const SizedBox(height: 16),
              _buildTextField(houseNumberController, 'House No', Icons.home),
              const SizedBox(height: 16),
              _buildTextField(
                  streetNumberController, 'Street No', Icons.streetview),
              const SizedBox(height: 16),
              _buildTextField(postalCodeController, 'Postal Code', Icons.mail),
              const SizedBox(height: 16),
              _buildTextField(blockNumberController, 'Block No or Sector No',
                  Icons.subdirectory_arrow_left),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label,
      {bool isConfirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
        builder: (context, state) {
          return TextField(
            controller: controller,
            obscureText: !state.isPasswordVisible,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: passwordFieldColor, // Use the variable for color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<PasswordVisibilityBloc>(context)
                      .add(TogglePasswordVisibility());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildText(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: Colors.white),
    );
  }

  Widget _buildCreateAccountButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: _createAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Create Account',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  void _createAccount() {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String phoneNumber = phoneNumberController.text;

    // Email validation
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }

    // Password validation
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$');
    if (password.isEmpty || !passwordRegExp.hasMatch(password)) {
      setState(() {
        passwordFieldColor =
            Colors.red.withOpacity(0.3); // Change color to red on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Password must be at least 10 characters, contain an uppercase letter, a symbol, and a number")),
      );
      return;
    } else {
      setState(() {
        passwordFieldColor = Colors.white.withOpacity(0.3); // Reset color
      });
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    BlocProvider.of<CreateAccountAuthBloc>(context).add(CreateAccountEvent(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      fullname: fullNameController.text,
      phonenumber: phoneNumber,
      country: countryController.text,
      city: cityController.text,
      houseNo: houseNumberController.text,
      streetNo: streetNumberController.text,
      postalCode: postalCodeController.text,
      blockNo: blockNumberController.text,
    ));
  }

  Widget _buildSignInLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: const TextStyle(color: Colors.white),
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.go('/sign-in'); // Change to your sign-in route
              },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckMarkAnimation() {
    return Center(
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 100,
      ),
    );
  }
}
