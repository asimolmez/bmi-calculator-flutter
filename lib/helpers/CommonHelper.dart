class CommonHelper {
  
  static double getBMI(weight, height) {
    return double.parse(weight) /
        ((double.parse(height) / 10) *
            (double.parse(height) / 10)) *
        100;
  }
}