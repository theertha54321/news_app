import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/category_model_controller.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:provider/provider.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
   final List<String> categories = [
    
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<CategoryModelController>().getCategories(categories[0]);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final sectionProvider  = context.watch<CategoryModelController>();
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: const Color.fromARGB(255, 2, 6, 53),
          title: Text("Your News,Categorized !",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
          bottom:TabBar(
                  onTap: (index) async {
                    
                    await context.read<CategoryModelController>().getCategories(categories[index]);
                  },
               
                labelPadding: EdgeInsets.only(right: 76),
                dividerColor: Colors.transparent,
                isScrollable: true,
                labelStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: categories.map((e) => Tab(text: e)).toList(),), 
        ),
        body: sectionProvider.isLoading==true ? 
        Center(child: CircularProgressIndicator(),)
        :
        
        
        Column(
          children: [
            SizedBox(height: 5,),
            Expanded(child:TabBarView(
          children: [
           _buildCategoryNews(),
           _buildCategoryNews(),
           _buildCategoryNews(),
           _buildCategoryNews(),
           _buildCategoryNews(),
           _buildCategoryNews(),
           _buildCategoryNews(),
          

          ]
        
        ),
         )
        ],
        )
      ),
    );
  }

  ListView _buildCategoryNews() {
    final sectionProvider  = context.watch<CategoryModelController>();
    return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: sectionProvider.newsList?.articles.length,
              itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 167, 208, 242),
                    
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: CachedNetworkImage(imageUrl: sectionProvider.newsList?.articles[index].urlToImage ?? "",
                        height: double.infinity,
                        width: 120,
                        fit: BoxFit.fill,
                        ),
                      ),
                      
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                         
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              sectionProvider.newsList?.articles[index].title ?? "",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600)),
                          Spacer(),
                                    Row(
                                      children:
                                      [
                                    Icon(Icons.source,size: 14,),
                                    SizedBox(width: 2,),
                                    Text(sectionProvider.newsList?.articles[index].source.name ?? "",style: TextStyle(color: Colors.black,fontSize: 12,),),
                                      ]),
                                    SizedBox(height: 8,),
                                    Row(children: [
                                      Icon(Icons.date_range,size: 14,),
                                     SizedBox(width: 2,),
                                    Text(sectionProvider.newsList?.articles[index].publishedAt.toString() ?? "",style: TextStyle(color: Colors.black,fontSize: 10,),),
                                    ],)
                                    
                                 
                          ],
                        ),
                      ),
                       Spacer(),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                             
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                            title: sectionProvider.newsList?.articles[index].title ?? "",
                    description: sectionProvider.newsList?.articles[index].description ?? "",
                    imageUrl: sectionProvider.newsList?.articles[index].urlToImage ?? "",
                    date: sectionProvider.newsList?.articles[index].publishedAt.toString() ?? "",
                    content: sectionProvider.newsList?.articles[index].content ?? "",
                    source: sectionProvider.newsList?.articles[index].source.name ?? "",
                    author: sectionProvider.newsList?.articles[index].author ?? "",
                           )));
                
                            },
                            child: Text("See more",style: TextStyle(color: Colors.blue,fontSize: 10,)))
                        ],
                       )
                      ],
                  ),
                ),
              )
              );
  }
}