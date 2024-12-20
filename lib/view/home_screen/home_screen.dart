import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/main.dart';
import 'package:news_app/view/details_screen/details_screen.dart';
import 'package:news_app/view/saved_screen/saved_screen.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import this package

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int carouselIndex = 0;
  final List sources = ['bbc-news', 'abc-news', 'ansa'];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<TopstoryController>().getStories(sources[0]);
      await context.read<TopstoryController>().getHeadlines();
    });
    super.initState();
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedScreen()),
              );
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
                cursorHeight: 18,
                cursorColor: Colors.grey,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(title: homeProvider.list?.articles[carouselIndex].title ?? "No Title",
          date: homeProvider.list?.articles[carouselIndex].publishedAt.toString() ?? "No Date",
          description: homeProvider.list?.articles[carouselIndex].description ?? "No Description",
          imageUrl: homeProvider.list?.articles[carouselIndex].urlToImage ?? "",
          source: homeProvider.list?.articles[carouselIndex].source.name ?? "No Source",)));
                },
                child: CarouselSlider(
                  items: List.generate(
                    homeProvider.list?.articles.length ?? 0,
                    (index) {
                      return homeProvider.isLoading == true
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
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
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        carouselIndex = index; // Update the carousel index when it changes
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
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (index) async {
                        await context.read<TopstoryController>().getStories(sources[index]);
                      },
                      tabs: sources.map((e) => Tab(text: e)).toList(),
                    ),
                    Container(
                      height: 400, // Adjust this based on how many items you want to show
                      child: TabBarView(
                        children: [
                          _buildNews(homeProvider),
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
      itemCount: homeProvider.newList?.articles.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(title: homeProvider.list?.articles[index].title ?? "No Title",
          date: homeProvider.newList?.articles[index].publishedAt.toString() ?? "No Date",
          description: homeProvider.newList?.articles[index].description ?? "No Description",
          imageUrl: homeProvider.newList?.articles[index].urlToImage ?? "",
          source: homeProvider.newList?.articles[index].source.name ?? "No Source",)));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 150,
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
