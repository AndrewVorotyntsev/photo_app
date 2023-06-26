class AppStrings {
  static const photos = 'Photos';
  static const backLabel = '< Back';
  static const refreshIntent = 'Обновить данные';
  static const loadingError = 'Произошла ошибка во время загрузки данных.';

  static String like(int qty) => qty == 1 ? 'like' : 'likes';
}
