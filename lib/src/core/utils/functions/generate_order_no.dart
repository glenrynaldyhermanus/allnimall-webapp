
import 'package:intl/intl.dart';

String generateOrderNo(){
  return "GRM-WEB-${DateFormat('ddMMhhmmss').format(DateTime.now())}";
}