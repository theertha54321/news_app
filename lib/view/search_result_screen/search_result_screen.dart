import 'package:flutter/material.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_app/controller/topstory_controller.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For images

class SearchResultsScreen extends StatelessWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<TopstoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$query"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: searchProvider.searchResults?.articles.length ?? 0,
                itemBuilder: (context, index) {
                  
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      leading: CachedNetworkImage(
                        imageUrl: searchProvider.searchResults?.articles[index].urlToImage ?? '',
                         height: double.infinity,
                            width: 120,
                       
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Text(searchProvider.searchResults?.articles[index].title ?? 'No Title'),
                      subtitle: Text(searchProvider.searchResults?.articles[index].source.name ?? 'No Description'),
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              articleUrl: searchProvider.searchResults?.articles[index].url ?? '',
                              title: searchProvider.searchResults?.articles[index].title ?? '',
                              description: searchProvider.searchResults?.articles[index].description ?? '',
                              imageUrl: searchProvider.searchResults?.articles[index].urlToImage ?? '',
                              date: searchProvider.searchResults?.articles[index].publishedAt.toString() ?? '',
                              content: searchProvider.searchResults?.articles[index].content ?? '',
                              source: searchProvider.searchResults?.articles[index].source.name ?? '',
                              author: searchProvider.searchResults?.articles[index].author ?? '',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
