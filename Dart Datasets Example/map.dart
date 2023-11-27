void main() {
  // Creating a Map with keys as lists of integers and values as lists of integers
  Map<List<int>, List<int>> mapOfLists = {
    [1, 2, 3]: [4, 5, 6],
    [7, 8, 9]: [10, 11, 12],
  };

  // Adding a new key-value pair
  mapOfLists[List<int>.generate(3, (index) => index + 13)] = List<int>.generate(3, (index) => index + 16);

  // Accessing values using keys
  print('Values for key [1, 2, 3]: ${mapOfLists[[1, 2, 3]]}');

  // Printing all key-value pairs
  print('All key-value pairs:');
  mapOfLists.forEach((key, value) {
    print('$key: $value');
  });
}
