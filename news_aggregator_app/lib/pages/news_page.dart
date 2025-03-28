// Importing necessary Flutter and custom packages
import 'package:flutter/material.dart';
import 'package:news_aggregator_app/model/article.dart';
import 'package:news_aggregator_app/model/news_card.dart';
import 'package:news_aggregator_app/services/news_service.dart';
// Stateful widget for the News List Page
class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  // Future to hold the list of articles fetched from the API
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    // Fetching news articles when the widget is initialized
    futureArticles = NewsApiService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'), // AppBar title
        backgroundColor: const Color(0xFF00796B), // AppBar background color
        foregroundColor: Colors.white, // AppBar text color
      ),
      body: FutureBuilder<List<Article>>(
        future: futureArticles, // Future to build the UI based on its state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if an error occurs
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Display the list of articles if data is available
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length, // Number of articles
              itemBuilder: (context, index) {
                final article = articles[index];
                // Render a NewsCard for each article
                return NewsCard(article: article);
              },
            );
          } else {
            // Show message if no data is found
            return const Center(child: Text('No News Found'));
          }
        },
      ),
    );
  }
}
