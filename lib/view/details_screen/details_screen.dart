import 'package:flutter/material.dart';
import 'package:news_app/controller/saved_screen_controller.dart';
import 'package:news_app/view/saved_screen/saved_screen.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  // Define the parameters for the article
  final String title;
  final String date;
  final String content;
  final String description;
  final String imageUrl;
  final String source;
  final String author;

  // Update the constructor to accept the passed arguments
  const DetailsScreen({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.source,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            floating: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl, // Use the passed image URL
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.bookmark_border, color: Colors.black),
                onPressed: () async {
                  // Check if the news article is already saved
                  bool isSaved = await _checkIfSaved(context);
                  if (isSaved) {
                    // If it's already saved, show a message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('This news article is already saved!')),
                    );
                  } else {
                    // Otherwise, save the news article
                    await context.read<SavedScreenController>().addNews(
                      title: title,
                      source: source,
                      image: imageUrl,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('News article saved!')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedScreen()),
                    );
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  // Handle share action
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, // Use the passed title
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            source, // Use the passed source
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            date, // Use the passed date
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Divider(thickness: 1, height: 30),
                      Text(
                        author, // Static text for author
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 16),
                      Text(
                        description, // Use the passed description
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Text(
                        content, // Use the passed description
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 14, 3, 58),
                          ),
                          child: Text("Read More", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // Check if the news article is already saved
  Future<bool> _checkIfSaved(BuildContext context) async {
    List<Map> savedNews = await context.read<SavedScreenController>().getSavedNews();
    for (var news in savedNews) {
      if (news['title'] == title) {
        return true; // News article is already saved
      }
    }
    return false; // News article is not saved yet
  }
}
