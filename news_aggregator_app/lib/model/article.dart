/// Represents an article with details such as source, author, title, description, URL, 
/// image URL, and publication date.
class Article {
  /// The source of the article, which may include an ID and name.
  final Source? source;

  /// The author of the article. This can be null if the author is not provided.
  final String? author;

  /// The title of the article. This is a required field.
  final String title;

  /// A brief description of the article. This is a required field.
  final String description;

  /// The URL of the article. This is a required field.
  final String url;

  /// The URL of the image associated with the article. This can be null.
  final String? urlToImage;

  /// The publication date of the article in ISO 8601 format. This is a required field.
  final String publishedAt;

  /// Constructs an [Article] object with the given details.
  ///
  /// All fields marked as `required` must be provided.
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  /// Creates an [Article] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the article's data.
  /// If the `source` field is present, it is parsed into a [Source] object.
  /// Default values are provided for nullable fields if they are not present in the JSON.
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      author: json['author'] ?? 'Unknown Author',
      title: json['title'] ?? 'No Title Available',
      description: json['description'] ?? 'No Description Available',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'], // Keeping nullable as it might be null
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}

/// Represents the source of an article, including an optional ID and a name.
class Source {
  /// The unique identifier of the source. This can be null.
  final String? id;

  /// The name of the source. This is a required field.
  final String name;

  /// Constructs a [Source] object with the given details.
  ///
  /// The [id] field is optional, but the [name] field is required.
  Source({
    required this.id,
    required this.name,
  });

  /// Creates a [Source] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the source's data.
  /// Default values are provided for nullable fields if they are not present in the JSON.
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'], // Keeping nullable as 'id' can be null in API response
      name: json['name'] ?? 'Unknown Source',
    );
  }
}
