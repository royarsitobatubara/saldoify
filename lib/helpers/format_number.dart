import 'package:intl/intl.dart';

String formatRibuan(int number) {
  final formatter = NumberFormat("#,###", "id_ID");
  return formatter.format(number).replaceAll(",", ".");
}
