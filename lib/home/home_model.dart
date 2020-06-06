import 'package:bt_mobile/base/model.dart';

class HomeModel extends Model {
  String salutation = '';
  String date = '';
  String degrees = '23°C';
  String city = 'Vancouver';

  // Stats card
  double percentage = 0.0;
  double topProgressWidth = 0.0;
  String term = '';
  String startDate = '';
  String endDate = '';
  String numericDayNumerator = '';
  String numericDayDenominator = '';
  String numericWeekNumerator = '';
  String numericWeekDenominator = '';
}
