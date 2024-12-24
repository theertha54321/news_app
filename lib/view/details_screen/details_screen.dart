import 'package:flutter/material.dart';
import 'package:news_app/controller/saved_screen_controller.dart';
import 'package:news_app/view/bottom_nav/bottom_nav.dart';
import 'package:news_app/view/saved_screen/saved_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String date;
  final String content;
  final String description;
  final String imageUrl;
  final String source;
  final String author;
  final String articleUrl;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.source,
    required this.author,
    required this.articleUrl,
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
                imageUrl,
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
                onPressed: () async 
                
                {
                   bool isSaved = await context.read<SavedScreenController>().isArticleSaved(title);
                   if (isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This news article is already saved!')),
      );
    } else {
      await context.read<SavedScreenController>().addNews(
        title: title,
        image: imageUrl,
        source: source,
        author: author,
        content: content,
        description: description,
        publishedAt: date,
        url: articleUrl,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('News article saved!')),
      );

     
      await Future.delayed(Duration(seconds: 1));
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
                  Share.share(articleUrl);
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
                        title,
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
                            source,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Divider(thickness: 1, height: 30),
                      Text(
                        author,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 16),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await canLaunch(articleUrl)) {
                              await launch(articleUrl);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Could not open the article URL!')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 14, 3, 58),
                          ),
                          child: Text(
                            "Read More",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
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

 
  
}
