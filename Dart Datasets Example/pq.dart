void main() {
  // Example domains map
  Map<List<int>, Set<int>> domains = {
    [0, 1]: {1, 9},
    [1, 2]: {1, 4, 9},
    [2, 4]: {2, 4},
    // ... add more entries as needed
  };

  // Convert entries to a list
  List<MapEntry<List<int>, Set<int>>> entryList = domains.entries.toList();

  // Sort the list based on the size of the sets
  entryList.sort((a, b) => a.value.length.compareTo(b.value.length));

  // Print the sorted list
  print_SortedList(entryList);
}

void print_SortedList(List<MapEntry<List<int>, Set<int>>> sortedList) {
  print("Sorted List (based on set size):");
  for (var entry in sortedList) {
    print("${entry.key}: ${entry.value}");
  }
}
