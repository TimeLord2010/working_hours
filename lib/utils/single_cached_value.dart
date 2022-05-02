class SingleCachedValue<T> {
  final T Function() getter;
  final Duration? timeout;
  DateTime? _retriveDate;
  T? _cache;

  SingleCachedValue({
    required this.getter,
    this.timeout,
  });

  bool get hasValue => _cache != null;

  void clear() {
    _cache = null;
  }

  bool get _timeoutExpired {
    if (timeout == null) {
      return false;
    }
    final expireDate = _retriveDate!.add(timeout!);
    final now = DateTime.now();
    return now.isAfter(expireDate);
  }

  T get retrive {
    if (_cache == null || _timeoutExpired) {
      _cache = getter();
      if (timeout != null) _retriveDate = DateTime.now();
    }
    return _cache!;
  }
}
