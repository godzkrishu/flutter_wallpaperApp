import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apioperation.dart';
import 'package:wallpaperapp/models/categoryModel.dart';
import 'package:wallpaperapp/models/photomodel.dart';
import 'package:wallpaperapp/view/screens/fullscreen.dart';
import 'package:wallpaperapp/view/widget/catBlock.dart';
import 'package:wallpaperapp/view/widget/customappbar.dart';
import 'package:wallpaperapp/view/widget/searchbar.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen ({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotoModel> trendingWallList;
  late List<CategoryModel> catWallList;
  bool isWallLoading=true;
  bool isCatLoading=true;
  getCatWall() async
  {
    catWallList=await ApiOperation.catWallpaper();
    setState(() {
      isCatLoading=false;
    });
  }
  GetTrendingWall() async
  {
    trendingWallList= await ApiOperation.getWallpaper();
    setState(() {
      isWallLoading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetTrendingWall();
    getCatWall();
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
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(//for
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:SearchBarWidget(),
          ),


          // for category scroller
          isCatLoading
              ? Center(child: CircularProgressIndicator()) :Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 100,
              width:MediaQuery.of(context).size.width,
              child:
                  SizedBox(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: catWallList.length,
                          itemBuilder: ((context,index)=>CatBlock(
                            imgUrl: catWallList[index].catImgUrl,
                            catName: catWallList[index].catName,
                          )),),
                  )
            ),

          ),


    SizedBox(height: 20,),

          ///gridview list
          isWallLoading
              ? Center(child: CircularProgressIndicator()) : Container(
            margin: EdgeInsets.symmetric(horizontal:10),

            height:MediaQuery.of(context).size.height,
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,//height of the box of grid
                        crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ) ,
                itemCount: trendingWallList.length,
                itemBuilder: (context,index)
              {

                return InkWell(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl: trendingWallList[index].imgSrc,)));
                  },
                  child: Hero(
                    tag: "fullscreenAnimation",// animate when this url is open
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
                            trendingWallList[index].imgSrc ??
                            "https://img.freepik.com/premium-psd/state-art-smartphone-design-mock-up_23-2149543586.jpg?w=740"),
                      ),
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
