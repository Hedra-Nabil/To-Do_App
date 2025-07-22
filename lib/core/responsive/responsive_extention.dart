import 'package:to_do_app/core/responsive/responsice_calculation.dart';

extension ResponsiveExtention on num {
  double get h => ResponsiveCalculation.calculateHeight(toDouble());

  double get w => ResponsiveCalculation.calculateWidth(toDouble());
}
