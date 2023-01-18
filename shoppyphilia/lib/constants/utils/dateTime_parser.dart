import 'package:intl/intl.dart';

class DateTimeHelper {
  String dateParser(date) {
   var parsedDate = DateFormat("EEEE, dd MMM, HH:mm a").format(DateTime.parse(date));
    return parsedDate;
  }
}
