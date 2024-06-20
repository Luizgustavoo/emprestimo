import 'package:intl/intl.dart';

class CustomServices {
  static String dateTimePtBr(String originalDateTime) {
    try {
      DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime dateTime = originalFormat.parseStrict(
          originalDateTime); // Usando parseStrict para validação rigorosa
      DateFormat newFormat = DateFormat('yyyy-MM-dd HH:mm');
      String formattedDateTime = newFormat.format(dateTime);
      return formattedDateTime;
    } catch (e) {
      return 'Data e hora inválida';
    }
  }
}
