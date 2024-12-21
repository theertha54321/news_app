import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/saved_screen_controller.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<SavedScreenController>().getNews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final savedscreenprovider = context.watch<SavedScreenController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: savedscreenprovider.mylist.length,
          itemBuilder: (context, index) {
            var newsItem = savedscreenprovider.mylist[index];
            return InkWell(
              onTap: () {
                // Navigate to DetailsScreen with the added fields
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      articleUrl: newsItem['url'],
                      title: newsItem['title'],
                      imageUrl: newsItem['image'],
                      source: newsItem['source'],
                      author: newsItem['author'],
                      content: newsItem['content'],
                      description: newsItem['description'],
                      date: newsItem['publishedAt'],
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: newsItem['image'].toString(),
                          fit: BoxFit.cover,
                          height: 70,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsItem['title'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'By ${newsItem['author']}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              newsItem['description'].toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                         await context.read<SavedScreenController>().removeNews(savedscreenprovider.mylist[index]['id']);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
