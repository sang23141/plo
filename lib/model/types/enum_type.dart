enum ReturnTypeENUM {
  success,
  failure;

  @override
  String toString() {
    switch (this) {
      case ReturnTypeENUM.success:
        return 'success';
      case ReturnTypeENUM.failure:
        return 'failure';
    }
  }
}
