enum LottieAnimation {
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error'),
  dataNotFound(name: 'data_not_found');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
