import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_aggregator_app/model/article.dart';

class NewsApiService {
  final String apiKey = 'Your_api_key'; // Replace with your actual API key

  // Fetches news articles from the News API
  Future<List<Article>> fetchNews() async {
    // Define the API URL with query parameters
    final String apiUrl =
        'https://newsapi.org/v2/everything?q=tesla&from=2025-02-28&sortBy=publishedAt&apiKey=$apiKey';

    // Make an HTTP GET request to the API
    final response = await http.get(Uri.parse(apiUrl));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Check if the API response status is 'ok'
      if (data['status'] == 'ok') {
        print("data: ${data['articles']} ");
        print("status: ${data['status']}");
        List articles = data['articles'];

        // Map the JSON articles to a list of Article objects
        return articles.map((article) => Article.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load news ${response.statusCode}');
    }
  }
}
