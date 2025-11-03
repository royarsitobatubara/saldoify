import 'package:intl/intl.dart';

String formatRibuan(num number) {
  final formatter = NumberFormat("#,###", "id_ID");
  return formatter.format(number).replaceAll(",", ".");
}
