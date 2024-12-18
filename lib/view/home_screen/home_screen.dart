import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/main.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:news_app/view/saved_screen/saved_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<TopstoryController>().getTopHeadlinesbyVariousSources();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final headlineProvider = context.watch<TopstoryController>();
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 167, 208, 242),
     
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 3, 62),
        leadingWidth: 190,
        toolbarHeight: 65,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10,left: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:8,top: 5),
                child: VerticalDivider(
                  width: 20,
                  thickness: 2,
                  color: Colors.white,
                ),
              ),
              Text(" Daily Pulse",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
            ],
          )
        ),

        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedScreen()));
          },
           icon:Padding(
             padding: const EdgeInsets.all(8.0),
             child: Icon(Icons.save,color: Colors.white,),
           ))
        ],
      ),


      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorHeight: 18,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                  prefixIcon: Icon(Icons.search,color: Colors.grey,size: 16,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none
                  )
                ),
              ),
              SizedBox(height: 20,),
              Text("Breaking Headlines",style: TextStyle(color: const Color.fromARGB(255, 1, 31, 55),fontWeight: FontWeight.bold,fontSize: 22),),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                },
                child: CarouselSlider(
                  
                   items: [
                  Container(
                              
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                              image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      
                      "https://images.pexels.com/photos/14733032/pexels-photo-14733032.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"
                      
                      )),
                     
                  ),
                  child: Column(
                   
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0),
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.9),
                  
                  ])
                              ),
                              child: Padding(
                  padding: const EdgeInsets.only(top: 70,bottom: 35,left: 37,right: 37),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        "You want Authentic, here you go!",
                        style:TextStyle( color: Colors.white,fontSize: 34,fontWeight: FontWeight.w600),
                        
                        
                        ),
                    ]
                  ),
                              )
                          
                              ),
                          ]
                          ),
                              
                    
                  ) 
                   ],
                
                   options: CarouselOptions(
                    
                
                aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                   )
                 ),
              ),
              SizedBox(height: 20,),
              Text("Top Stories From Trusted Sources",style: TextStyle(color: const Color.fromARGB(255, 1, 13, 55),fontWeight: FontWeight.bold,fontSize: 22),),
              SizedBox(height: 20,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: headlineProvider.headlineList?.articles?.length ,
                itemBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(headlineProvider.headlineList?.articles?[index].urlToImage ?? ""))
                            ),
                          ) ,
                          SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text("title",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("title",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600)),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.source,size: 16,),
                                  SizedBox(width: 10,),
                                  Text("source name",style: TextStyle(color: Colors.black,fontSize: 10,),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.date_range,size: 16,),
                                  SizedBox(width: 10,),
                                  Text("date",style: TextStyle(color: Colors.black,fontSize: 10,),),
                                ],
                              ),
                            ],
                          ),
                           
                           
                          ],
                      ),
                    ),
                  ),
                )
                )
            ],
          ),
        ),
      ),
    );
  }
}