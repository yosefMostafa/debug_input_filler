class MissMatchProfileIndex implements Exception {
  final int providedIndex;
  final int expectedIndex;

  MissMatchProfileIndex(this.providedIndex, this.expectedIndex);

  @override
  String toString() {
    return 'MissMatchProfileIndex: Provided index $providedIndex, but expected <= $expectedIndex';
  }
}
