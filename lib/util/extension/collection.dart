import 'dart:math';

/// Provides convenient List extensions
extension ListExtension<E> on List<E> {
  /// Maps each element of this list to a new value and returns a new list.
  /// This is equivalent to `map(generator).toList()`.
  List<T> to<T>(T Function(E e) generator) => map(generator).toList();

  /// Returns a new list containing elements at even indices.
  List<E> evenList() => [for (int i = 0; i < length; i += 2) this[i]];

  /// Returns a new list containing elements at odd indices.
  List<E> oddList() => [for (int i = 1; i < length; i += 2) this[i]];

  /// Safely returns the element at the given [index].
  /// Returns null if the index is out of bounds.
  E? safeGet(int index) => (index >= 0 && index < length) ? this[index] : null;

  /// Adds [item] to the list if [item] is not null.
  void addIfNotNull(E? item) {
    if (item != null) add(item);
  }

  /// Adds all items from [items] to the list if [items] is not null or empty.
  void addAllIfNotNull(List<E>? items) {
    if (items != null && items.isNotEmpty) addAll(items);
  }

  /// Returns a new list containing elements that satisfy the given [test].
  List<E> whereToList(bool Function(E e) test) => where(test).toList();

  /// Returns true if any element in the list satisfies the given [test].
  bool any(bool Function(E e) test) => where(test).isNotEmpty;

  /// Returns true if all elements in the list satisfy the given [test].
  bool all(bool Function(E e) test) => where(test).length == length;

  /// Returns a new list containing elements from this list up to, but not including, [end].
  List<E> takeUpTo(int end) => take(end).toList();

  /// Returns a new list containing elements from this list starting from [start].
  List<E> skipFrom(int start) => skip(start).toList();

  /// Returns a new list containing chunks of the original list with the specified [chunkSize].
  List<List<E>> chunk(int chunkSize) {
    if (chunkSize <= 0) throw ArgumentError('chunkSize must be positive');
    List<List<E>> chunks = [];
    for (int i = 0; i < length; i += chunkSize) {
      chunks.add(takeUpTo(i + chunkSize).skipFrom(i));
    }
    return chunks;
  }

  /// Safely returns a random element from the list.
  /// Returns null if the list is empty.
  E? randomElement() {
    return isEmpty ? null : this[Random().nextInt(length)];
  }

  /// Swaps the elements at [index1] and [index2].
  /// Throws a RangeError if indices are out of bounds.
  void swap(int index1, int index2) {
    if (index1 < 0 || index1 >= length || index2 < 0 || index2 >= length) {
      throw RangeError('Indices are out of bounds');
    }
    final temp = this[index1];
    this[index1] = this[index2];
    this[index2] = temp;
  }
}
