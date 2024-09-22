import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_aggregator_app/model/article.dart';

class NewsApiService {
  final String apiKey =
      'ecbf995ee31b478795a4fcf72dd58d69'; // Replace with your actual API key

  Future<List<Article>> fetchNews() async {
    final String apiUrl =
        'https://newsapi.org/v2/everything?q=Technology&from=2024-09-10&sortBy=popularity&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'ok') {
        List articles = data['articles'];
        return articles.map((article) => Article.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}
