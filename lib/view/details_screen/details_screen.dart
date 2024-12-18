import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

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

                "https://images.pexels.com/photos/518543/pexels-photo-518543.jpeg?auto=compress&cs=tinysrgb&w=600",
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
                onPressed: () {
                 
                },
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.black),
                onPressed: () {
                 
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
                        "Breaking News: Major Discovery in Science",
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
                            "News Agency",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            "December 15, 2024",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Divider(thickness: 1, height: 30),
                      Text(
                        "By John Doe",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "In a groundbreaking discovery, scientists have uncovered new evidence that could change the course of human history. The discovery, made in a remote region of the Arctic, reveals ancient relics that suggest early civilizations may have existed much earlier than previously thought. This unexpected finding has sparked a wave of excitement among archaeologists and historians alike.\n\n"
                        "Experts are now analyzing the artifacts, which include tools and pottery, to understand how these early humans lived and interacted with their environment. Some scientists believe this discovery could lead to a reevaluation of human history and challenge long-held assumptions about the development of ancient cultures.\n\n"
                        "The archaeological team that made the discovery is currently working around the clock to gather more information. With the help of advanced technology, they are carefully documenting every detail of the site and processing the artifacts to learn more about their origins and significance.\n\n"
                        "This new revelation has already begun to make waves in the scientific community. Conferences and discussions are being scheduled to present the findings, and the media is buzzing with excitement. As more information becomes available, the world eagerly waits to learn more about the implications of this extraordinary discovery.",
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
}
