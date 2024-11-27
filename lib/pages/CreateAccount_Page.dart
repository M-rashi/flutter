import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/components/custom_app_bar.dart';

final usernameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final usernameErrorProvider = StateProvider<String?>((ref) => null);
final emailErrorProvider = StateProvider<String?>((ref) => null);
final passwordErrorProvider = StateProvider<String?>((ref) => null);

class CreateAccountPage extends ConsumerWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final usernameError = ref.watch(usernameErrorProvider);
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);

    void createAccount() {
      bool isValid = true;

      if (username.isEmpty) {
        ref.read(usernameErrorProvider.notifier).state =
            'Username cannot be empty';
        isValid = false;
      } else {
        ref.read(usernameErrorProvider.notifier).state = null;
      }

      if (email.isEmpty) {
        ref.read(emailErrorProvider.notifier).state = 'Email cannot be empty';
        isValid = false;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        ref.read(emailErrorProvider.notifier).state =
            'Enter a valid email address';
        isValid = false;
      } else {
        ref.read(emailErrorProvider.notifier).state = null;
      }

      if (password.isEmpty) {
        ref.read(passwordErrorProvider.notifier).state =
            'Password cannot be empty';
        isValid = false;
      } else if (password.length < 6) {
        ref.read(passwordErrorProvider.notifier).state =
            'Password must be at least 6 characters long';
        isValid = false;
      } else {
        ref.read(passwordErrorProvider.notifier).state = null;
      }

      if (isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully registered!')),
        );
      }
    }

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.blue,
                ),

                const SizedBox(height: 50),

                // Welcome
                Text(
                  'Create a new account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) =>
                            ref.read(usernameProvider.notifier).state = value,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      if (usernameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            usernameError,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) =>
                            ref.read(emailProvider.notifier).state = value,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      if (emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            emailError,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        obscureText: true,
                        onChanged: (value) =>
                            ref.read(passwordProvider.notifier).state = value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      if (passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            passwordError,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Sign-up button
                GestureDetector(
                  onTap: createAccount,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Continue with text
                Text(
                  'Or continue with',
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 20),

                // Social media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.apple,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.g_mobiledata,
                        size: 78,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
