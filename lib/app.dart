import 'package:flutter/material.dart';
import 'models/user_profile.dart';
import 'screens/auth/login_screen.dart';
import 'screens/customer/customer_shell.dart';
import 'screens/staff/staff_shell.dart';
import 'services/demo_store.dart';

class LaundryLinkApp extends StatefulWidget {
  final DemoStore store;
  const LaundryLinkApp({super.key, required this.store});

  @override
  State<LaundryLinkApp> createState() => _LaundryLinkAppState();
}

class _LaundryLinkAppState extends State<LaundryLinkApp> {
  UserProfile? currentUser;

  void login(UserProfile user) => setState(() => currentUser = user);
  void logout() => setState(() => currentUser = null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaundryLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      home: currentUser == null
          ? LoginScreen(store: widget.store, onLogin: login)
          : currentUser!.role == UserRole.customer
              ? CustomerShell(
                  store: widget.store,
                  user: currentUser!,
                  onLogout: logout,
                )
              : StaffShell(
                  store: widget.store,
                  user: currentUser!,
                  onLogout: logout,
                ),
    );
  }
}
