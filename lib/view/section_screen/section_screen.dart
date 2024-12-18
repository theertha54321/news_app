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
    "All",
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
      await context.read<CategoryModelController>().getCategories(null);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final sectionProvider  = context.watch<CategoryModelController>();
    return DefaultTabController(
      length: 8,
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
           _buildCategoryNews()
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
              itemCount: sectionProvider.newsList?.sources?.length,
              itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 167, 208, 242),
                    
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: double.infinity,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("data:image/jpeg;base64,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"))
                        ),
                      ) ,
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                         
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              sectionProvider.newsList?.sources?[index].description ?? "",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600)),
                          Spacer(),
                          Row(
                                  children: [
                                    Icon(Icons.source,size: 14,),
                                    
                                    Text(sectionProvider.newsList?.sources?[index].name ?? "",style: TextStyle(color: Colors.black,fontSize: 9,),),
                                    Spacer(),
                                    Icon(Icons.date_range,size: 14,),
                                    
                                    Text(sectionProvider.newsList?.sources?[index].country ?? "",style: TextStyle(color: Colors.black,fontSize: 9,),),
                                  ],
                                ),
                          ],
                        ),
                      ),
                       Spacer(),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                             
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                
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