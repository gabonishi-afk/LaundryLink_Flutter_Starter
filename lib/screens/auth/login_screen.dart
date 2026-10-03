import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/demo_store.dart';
import '../../widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  final DemoStore store;
  final ValueChanged<UserProfile> onLogin;

  const LoginScreen({
    super.key,
    required this.store,
    required this.onLogin,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(text: 'customer@demo.com');
  final password = TextEditingController(text: 'password');
  bool obscure = true;

  void submit() {
    final dynamic store = widget.store;
    final user = () {
      try {
        return store.signIn(email.text, password.text);
      } on NoSuchMethodError {
        try {
          return store.login(email.text, password.text);
        } on NoSuchMethodError {
          try {
            return store.authenticate(email.text, password.text);
          } on NoSuchMethodError {
            return null;
          }
        }
      }
    }();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid demo account. Password is "password".'),
        ),
      );
      return;
    }
    widget.onLogin(user);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 800;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: Row(
              children: [
                if (desktop)
                  Expanded(
                    child: Container(
                      height: 560,
                      padding: const EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_laundry_service,
                            color: Colors.white,
                            size: 70,
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'LaundryLink',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'A simple way to manage laundry orders, pickups, payments, and customer updates.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (desktop) const SizedBox(width: 40),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const AppLogo(),
                            const SizedBox(height: 32),
                            Text(
                              'Welcome back',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in to continue to LaundryLink.',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 28),
                            TextField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              controller: password,
                              obscureText: obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      setState(() => obscure = !obscure),
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            FilledButton(
                              onPressed: submit,
                              style: FilledButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text('Sign In'),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Demo accounts\n\nCustomer: customer@demo.com\nStaff: staff@demo.com\nPassword: password',
                                style: TextStyle(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
