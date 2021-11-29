class EE {
  EE({
    required String a,
  }) : _a = a;

  final String _a;

  void printA() {
    // ignore: avoid_print
    print(_a);
  }
}
