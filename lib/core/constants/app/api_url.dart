class ApiUrl {
//  static String baseUrl = 'http://api.zubabi.com';
  // static String baseUrl = 'https://api.terapizone.com';
  static String baseUrl = 'http://tpbookserver.herokuapp.com';

  /* auth */
  static String getBookList = baseUrl + '/books';

  static String getSingleBook({required String id}) => baseUrl + '/book/$id';
}
