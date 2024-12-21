import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/saved_screen_controller.dart';
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
    final savedscreenprovider= context.watch<SavedScreenController>();
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
            return Card(
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(imageUrl: savedscreenprovider.mylist[index]['image'].toString()),
                    ),
                    SizedBox(width: 16),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            savedscreenprovider.mylist[index]['title'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                            
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                savedscreenprovider.mylist[index]['source'].toString(), 
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
