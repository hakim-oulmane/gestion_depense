import 'package:intl/intl.dart';

class Methods {

  static bool valideDate(String date) {
    RegExp regex = new RegExp(r'^\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}$');
    return regex.hasMatch(date.trim());
  }

  static DateTime getDateTimeFromString(String date) {
    return DateFormat("dd/MM/yyyy HH:mm").parse(date);
  }

  static String getStringFromDate(DateTime date){
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static String getStringFromDateTime(DateTime date){
    return DateFormat("dd/MM/yyyy HH:mm").format(date);
  }

  static String formatMontant(String montant){
    return montant.replaceAll(new RegExp(r','), "");
  }

  static String formatDisplayMontant(String montant) {
    var val = double.parse(montant);
    montant = val.toStringAsFixed(2);
    return montant.replaceAllMapped(
        new RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}