void main() {
  // Creating a Set to store pairs of integers
  Set<List<int>> pairSet = {
    [1, 2],
    [3, 4],
    [5, 6],
  };

  // Adding a new pair
  pairSet.add([7, 8]);

  // Checking if a pair is in the set
  bool containsPair = pairSet.contains([1, 2]);
  print('Set contains [1, 2]: $containsPair');

  // Printing all pairs in the set
  print('All pairs in the set:');
  pairSet.forEach((pair) {
    print(pair);
  });
}
