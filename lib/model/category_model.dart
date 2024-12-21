// import 'dart:convert';

// CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));


// class CategoryModel {
//     List<Source>? sources;

//     CategoryModel({
//         this.sources,
//     });

//     factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         sources: json["sources"] == null ? [] : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
//     );

   
// }

// class Source {
//     String? id;
//     String? name;
//     String? description;
//     String? url;
//     String? category;
//     String? language;
//     String? country;

//     Source({
//         this.id,
//         this.name,
//         this.description,
//         this.url,
//         this.category,
//         this.language,
//         this.country,
//     });

//     factory Source.fromJson(Map<String, dynamic> json) => Source(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         url: json["url"],
//         category: json["category"],
//         language: json["language"],
//         country: json["country"],
//     );

    
// }




// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String status;
  int totalResults;
  List<Article> articles;

  CategoryModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"] ?? "",  // Default empty string if null
    totalResults: json["totalResults"] ?? 0,  // Default 0 if null
    articles: json["articles"] != null 
        ? List<Article>.from(json["articles"].map((x) => Article.fromJson(x))) 
        : [],  // Default to empty list if 'articles' is null
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Source source;
  dynamic author;  // Allow null or missing value
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime? publishedAt;  // Allow null values for DateTime
  String content;

  Article({
    required this.source,
    this.author,  // Allow author to be null
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.publishedAt,  // Allow publishedAt to be null
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"] ?? {}),
    author: json["author"],  // No need to provide default for nullable dynamic
    title: json["title"] ?? "",  // Default empty string if null
    description: json["description"] ?? "",  // Default empty string if null
    url: json["url"] ?? "",  // Default empty string if null
    urlToImage: json["urlToImage"] ?? "",  // Default empty string if null
    publishedAt: json["publishedAt"] != null 
        ? DateTime.tryParse(json["publishedAt"]) // Safely parse DateTime
        : null,
    content: json["content"] ?? "",  // Default empty string if null
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),  // Handle null DateTime
    "content": content,
  };
}

class Source {
  dynamic id;
  String name;

  Source({
    this.id,  // Allow id to be null
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],  // Allow id to be null
    name: json["name"] ?? "",  // Default empty string if null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
