import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/saved_screen_controller.dart';
import 'package:news_app/view/saved_screen/saved_screen.dart';
import 'package:news_app/view/search_result_screen/search_result_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart'; 
 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int carouselIndex = 0;
  final List sources = ['bbc-news', 'abc-news'];
  TextEditingController _searchController = TextEditingController(); 



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<TopstoryController>().getStories(sources[0]);
      await context.read<TopstoryController>().getHeadlines();
    });
    super.initState();
  }

 


  void _onSearch(String query) {
    if (query.isNotEmpty) {
     
      context.read<TopstoryController>().searchNews(query);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(query: query), // New screen
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<TopstoryController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 208, 242),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 3, 62),
        leadingWidth: 190,
        toolbarHeight: 65,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 5),
                child: VerticalDivider(
                  width: 20,
                  thickness: 2,
                  color: Colors.white,
                ),
              ),
              Text(
                " Daily Pulse",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<SavedScreenController>().getSavedArticles();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SavedScreen()));
            },
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          ),
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
                controller: _searchController,
                cursorHeight: 18,
                cursorColor: Colors.grey,
               
                onFieldSubmitted: (query) {
                 
                  _onSearch(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Breaking Headlines",
                style: TextStyle(color: const Color.fromARGB(255, 1, 31, 55), fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 20),
             
               InkWell(
                onTap: () {
                  
                  if (homeProvider.list?.articles.isNotEmpty ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                           articleUrl:homeProvider.list?.articles[carouselIndex].url ?? "" ,
                          title: homeProvider.list?.articles[carouselIndex].title ?? "",
                          description: homeProvider.list?.articles[carouselIndex].description ?? "",
                          imageUrl: homeProvider.list?.articles[carouselIndex].urlToImage ?? "",
                          date: homeProvider.list?.articles[carouselIndex].publishedAt.toString() ?? "",
                          content: homeProvider.list?.articles[carouselIndex].content ?? "",
                          source: homeProvider.list?.articles[carouselIndex].source.name ?? "",
                          author: homeProvider.list?.articles[carouselIndex].author ?? "",
                        ),
                      ),
                    );
                  }
                },
                child: homeProvider.isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : CarouselSlider(
                        items: List.generate(
                          homeProvider.list?.articles.length ?? 0,
                          (index) {
                            return homeProvider.isLoading == true
                                ? Center(child: CircularProgressIndicator())
                                : Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          homeProvider.list?.articles[index].urlToImage ?? "",
                                        ),
                                      ),
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
                                              colors: [
                                                Colors.black.withOpacity(0),
                                                Colors.black.withOpacity(.2),
                                                Colors.black.withOpacity(.6),
                                                Colors.black.withOpacity(.7),
                                              ],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 70, bottom: 35, left: 37, right: 37),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  homeProvider.list?.articles[index].title ?? "",
                                                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: carouselIndex,
                          reverse: false,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              carouselIndex = index; 
                            });
                          },
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Text(
                "Top Stories From Trusted Sources",
                style: TextStyle(color: const Color.fromARGB(255, 1, 13, 55), fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 20),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (index) async {
                        await context.read<TopstoryController>().getStories(sources[index]);
                      },
                                labelColor:const Color.fromARGB(255, 1, 13, 55) ,
                                unselectedLabelColor: const Color.fromARGB(255, 1, 13, 55),
                                indicatorColor: const Color.fromARGB(255, 1, 13, 55),
                                tabs: [
                                  Tab(text: "BBC News"),
                                  Tab(text: "ABC News"),
                                  
                                ],
                    ),
                    Container(
                      height: 400,
                      child: TabBarView(
                                  children: [
                                    
                                    _buildNews(homeProvider),

                                    
                                    _buildNews(homeProvider),
                                    
                                  ],
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildNews(TopstoryController homeProvider) {
    return ListView.builder(
      itemCount: homeProvider.newList?.articles.length ?? 0,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            
            if (homeProvider.newList?.articles.isNotEmpty ?? false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    articleUrl:homeProvider.newList?.articles[index].url ?? "" ,
                    title: homeProvider.newList?.articles[index].title ?? "",
                    description: homeProvider.newList?.articles[index].description ?? "",
                    imageUrl: homeProvider.newList?.articles[index].urlToImage ?? "",
                    date: homeProvider.newList?.articles[index].publishedAt.toString() ?? "",
                    content: homeProvider.newList?.articles[index].content ?? "",
                    source: homeProvider.newList?.articles[index].source.name ?? "",
                    author: homeProvider.newList?.articles[index].author ?? "",
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: homeProvider.newList?.articles[index].urlToImage ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: double.infinity,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homeProvider.newList?.articles[index].title.toString() ?? "no title",
                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(height: 5),
                      Text(
                        homeProvider.newList?.articles[index].description.toString() ?? "no desc",
                        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.source, size: 16),
                          SizedBox(width: 10),
                          Text(
                            homeProvider.newList?.articles[index].source.name.toString() ?? "no title",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.date_range, size: 16),
                          SizedBox(width: 10),
                          Text(
                            homeProvider.newList?.articles[index].publishedAt.toString() ?? "",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

              