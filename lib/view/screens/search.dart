import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apioperation.dart';
import 'package:wallpaperapp/models/photomodel.dart';
import 'package:wallpaperapp/view/widget/catBlock.dart';
import 'package:wallpaperapp/view/widget/customappbar.dart';
import 'package:wallpaperapp/view/widget/searchbar.dart';
class SearchScreen extends StatefulWidget {
  String SearchQuery;
 SearchScreen ({super.key,
   required this.SearchQuery
 });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotoModel> searchedWallList;
  bool isLoading=true;
  Search() async
  {
  searchedWallList = await ApiOperation.searchWallpaper(widget.SearchQuery);
  print(searchedWallList);
  setState(() {
    isLoading=false;
  });
  }
  @override
  void initState() {
    // TODO: implement initState
    Search();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
        centerTitle:true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:CustomAppBar(word1: "Ultra",word2: "Wall",),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
      :SingleChildScrollView(
        child: Column(
          children: [

               Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:SearchBarWidget(),
              ),

          SizedBox(height: 15,),
            //gridview
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),

              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,//height of the box of grid
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ) ,
                itemCount: searchedWallList.length,
                itemBuilder: (context,index)
                {

                  return Hero(
                    tag: "fullscreenAnimation",
                    child: Container(
                      height: 400,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amberAccent,
                      ),

                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            height: 400,
                            width: 50,
                            fit: BoxFit.cover,
                            searchedWallList[index].imgSrc??
                            "https://img.freepik.com/premium-psd/state-art-smartphone-design-mock-up_23-2149543586.jpg?w=740"),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}
