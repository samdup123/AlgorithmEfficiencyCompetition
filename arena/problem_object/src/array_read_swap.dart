class array_read_swap {

  var _array;

  array_read_swap(var array) {
    _array = array;
  }

  int read(index) {
    return _array[index];
  }

  void swap(index1, index2) {
    final tmp = _array[index1];
    _array[index1] = _array[index2];
    _array[index2] = tmp;
  }

  void get array => _array;
}
