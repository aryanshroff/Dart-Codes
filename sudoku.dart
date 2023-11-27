void print_Matrix(List<List<int>> m) {
  for (var row in m) {
    print(row);
  }
}

void print_Unfilled(Map<int, List<List<int>>> x, var container_name) {
  print(container_name);
  x.forEach((key, value) {
    print('Key: $key');
    print('Value:');
    value.forEach((innerList) {
      print(innerList);
    });
    print(''); // Empty line between key-value pairs
  });
  print(" ");
}

void print_Domains(Map<List<int>, Set<int>> map) {
  print("domains: ");
  map.forEach((key, value) {
    print("$key: $value");
  });
}

void update_Unfilled(
    Map<int, List<List<int>>> unfilled, int key, List<int> newList) {
  if (unfilled.containsKey(key)) {
    // Key already exists, append the new list to the existing value
    unfilled[key]!.add(newList);
  } else {
    // Key does not exist, create a new entry
    unfilled[key] = [newList];
  }
}

int get_Nonet_ID(int i, int j) {
  List<List<int>> m = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  i = i ~/ 3;
  j = j ~/ 3;
  return m[i][j];
}

void unfilled_Maps(
    Map<int, List<List<int>>> unfilledRows,
    Map<int, List<List<int>>> unfilledCols,
    Map<int, List<List<int>>> unfilledNonets,
    List<List<int>> m,
    Map<List<int>, Set<int>> domains) {
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m.length; j++) {
      if (m[i][j] == 0) {
        List<int> v = [i, j];
        //to update the unfilledros map
        //key=i newlist=[i,j] unfilled=unfilled row
        update_Unfilled(unfilledRows, i, v);
        update_Unfilled(unfilledCols, j, v);
        int nonet = get_Nonet_ID(i, j);
        update_Unfilled(unfilledNonets, nonet, v);

        domains[v] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
      }
    }
  }
}

void remove_from_array(int val, Map<List<int>, Set<int>> domains,
    List<List<int>> modification_array) {
  for (int i = 0; i < modification_array.length; i++) {
    List<int> currentList = modification_array[i];
    Set<int>? currentSet = domains[currentList];

    if (currentSet != null) {
      // Remove the integer 3 from the set
      currentSet.remove(val);

      // Update the domains map
      domains[currentList] = currentSet;
    }
  }
}

void modify_Domains(
    Map<int, List<List<int>>> unfilledRows,
    Map<int, List<List<int>>> unfilledCols,
    Map<int, List<List<int>>> unfilledNonets,
    List<List<int>> m,
    Map<List<int>, Set<int>> domains) {
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      int val = m[i][j];
      if (val != 0) {
        //we have to remove val from domains of ith row,jth col,nth nonet
        //remove from row
        List<List<int>> modification_array = unfilledRows[i] ?? [];
        remove_from_array(val, domains, modification_array);
        modification_array = unfilledCols[j] ?? [];
        remove_from_array(val, domains, modification_array);
        int n = get_Nonet_ID(i, j);
        modification_array = unfilledNonets[n] ?? [];
        remove_from_array(val, domains, modification_array);
      }
    }
  }
}

void get_Set_size(
    Map<List<int>, Set<int>> domains, Map<List<int>, int> setSize) {
  domains.forEach((key, value) {
    int len = value.length;
    setSize[key] = len;
  });
}

void print_SetSize(Map<List<int>, int> setSize) {
  setSize.forEach((key, value) {
    print("$key: $value");
  });
}

List<int> getKeyWithLowestValue(Map<List<int>, int> setSize) {
  if (setSize.isEmpty) {
    // Return an empty list or handle the case when the map is empty
    return [];
  }

  // Find the entry with the lowest value using reduce
  List<int> keyWithLowestValue = setSize.entries.reduce((a, b) {
    return a.value < b.value ? a : b;
  }).key;

  return keyWithLowestValue;
}

void print_Metadata(
    int line,
    List<List<int>> m,
    Map<List<int>, Set<int>> domains,
    Map<int, List<List<int>>> unfilledRows,
    Map<int, List<List<int>>> unfilledCols,
    Map<int, List<List<int>>> unfilledNonets,
    Map<List<int>, int> setSize,
    List<int> cellWithSmallestDomain,
    int emptyCells) {
  print("Line number: $line");
  print("Current matrix:");
  print_Matrix(m);
  print_Unfilled(unfilledRows, "Unfilled Rows: ");
  print_Unfilled(unfilledCols, "Unfilled Cols: ");
  print_Unfilled(unfilledNonets, "Unfilled Nonets: ");
  print_Domains(domains);
  print_SetSize(setSize);
  print("Empty Cells Count: $emptyCells");
  print("Currently the cell with smallest domain: $cellWithSmallestDomain");
}

bool is_SudokuSolved(int emptyCells) {
  if (emptyCells == 0)
    return true;
  else
    return false;
}

void backTrack(
    List<List<int>> m,
    Map<List<int>, Set<int>> domains,
    Map<int, List<List<int>>> unfilledRows,
    Map<int, List<List<int>>> unfilledCols,
    Map<int, List<List<int>>> unfilledNonets,
    Map<List<int>, int> setSize,
    List<int> cellWithSmallestDomain,
    List<List<List<int>>> history,
    int emptyCells) {
  if (is_SudokuSolved(emptyCells) == true) {
    //store current matrix in history
  }
}

void solve(List<List<int>> m) {
  //part1: precompute step
  Map<List<int>, Set<int>> domains = {};
  Map<int, List<List<int>>> unfilledRows = {};
  Map<int, List<List<int>>> unfilledCols = {};
  Map<int, List<List<int>>> unfilledNonets = {};
  unfilled_Maps(unfilledRows, unfilledCols, unfilledNonets, m, domains);

  //domain modification step
  modify_Domains(unfilledRows, unfilledCols, unfilledNonets, m, domains);

  Map<List<int>, int> setSize = {};

  get_Set_size(domains, setSize);
  List<int> cellWithSmallestDomain = getKeyWithLowestValue(setSize);
  int emptyCells = setSize.length;
  print_Metadata(195, m, domains, unfilledRows, unfilledCols, unfilledNonets,
      setSize, cellWithSmallestDomain, emptyCells);

  //part2: backtrack step
}

void main() {
  List<List<int>> sudokuMatrix = [
    [3, 0, 6, 5, 0, 8, 4, 0, 0],
    [5, 2, 0, 0, 0, 0, 0, 0, 0],
    [0, 8, 7, 0, 0, 0, 0, 3, 1],
    [0, 0, 3, 0, 1, 0, 0, 8, 0],
    [9, 0, 0, 8, 6, 3, 0, 0, 5],
    [0, 5, 0, 0, 9, 0, 6, 0, 0],
    [1, 3, 0, 0, 0, 0, 2, 5, 0],
    [0, 0, 0, 0, 0, 0, 0, 7, 4],
    [0, 0, 5, 2, 0, 6, 3, 0, 0],
  ];

  // Print the matrix

  solve(sudokuMatrix);
}
