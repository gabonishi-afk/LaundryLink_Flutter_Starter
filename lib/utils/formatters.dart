import 'package:intl/intl.dart';

String peso(double value) => '₱${value.toStringAsFixed(2)}';
String dateOnly(DateTime date) => DateFormat('MMM d, yyyy').format(date);
