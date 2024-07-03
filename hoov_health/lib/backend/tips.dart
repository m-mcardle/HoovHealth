import 'state.dart';

enum Severity {
  Low,
  Medium,
  High
}

class Tip {
  MetricType type;
  String tip;
  Severity severity;

  Tip(this.type, this.tip, this.severity);
}
