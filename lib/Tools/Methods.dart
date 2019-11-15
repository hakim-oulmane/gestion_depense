class Methods {

  static bool valideDate(String date) {
    RegExp regex = new RegExp(r'^\d{2}\/\d{2}\/\d{4}$');
    return regex.hasMatch(date.trim());
  }

  static DateTime getDateFromString(String date) {
    return DateFormat("dd/MM/yyyy").parse(date);
  }

  static getStringFromDate(DateTime date){
    return DateFormat("dd/MM/yyyy").format(date);
  }
}