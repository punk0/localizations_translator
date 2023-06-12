
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';

class GoogleTranslatorRepository {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://translation.googleapis.com/language/translate/v2"));

  GoogleTranslatorRepository() {
    // Set cache data for Dio
    _dio
      ..interceptors.add(DioCacheManager(CacheConfig(
          baseUrl:
          "https://translation.googleapis.com/language/translate/v2"))
          .interceptor);
  }

  Future<String> translate(
      {required String source,
        required String target,
        required String apiKey,
        required Duration cacheDuration,
        required String text}) async {
    try {
      Response response = await _dio.post("?key=$apiKey",
          data: {
            "q": text,
            "source": source,
            "target": target,
            "format": "text"
          },
          options: buildCacheOptions(cacheDuration));

      if (response.statusCode == 200 &&
          response.data?["data"]?["translations"] != null &&
          response.data["data"]?["translations"]?.length > 0) {
        text = response.data["data"]?["translations"].first["translatedText"];
      }
    } catch (e) {
      print(e);
    }
    return text;
  }
}
