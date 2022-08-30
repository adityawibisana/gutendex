import 'package:dio/dio.dart';
import 'package:gutendex/data/provider/gutendex_service.dart';
import '../model/gutendex_books.dart';

class GutendexServiceWeb implements GutendexService {
  final String url = 'https://gutendex.com';
  final Dio dio;
  GutendexServiceWeb(this.dio);
  @override
  Future<String> getBooks(int page) async {
    try {
      final response = await dio.get(
        '$url/books/?page=$page',
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
      // await http.
      return response.toString();
    } catch (e) {
      rethrow;
    }
  }
}
