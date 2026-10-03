import 'package:flutter/material.dart';
import 'app.dart' show LaundryLinkApp;
import 'services/demo_store.dart' show DemoStore;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final store = DemoStore.instance;
  runApp(LaundryLinkApp(store: store));
}
