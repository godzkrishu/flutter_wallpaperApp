import 'package:flutter/material.dart';
import 'package:wallpaperapp/view/screens/search.dart';
class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  TextEditingController _searchController = TextEditingController(); //it is use to fetch data from TextField
  //"_" is use for constant
  @override
  Widget build(BuildContext context) {
    return
       Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(//decorate the container box
          color: Color.fromARGB(66, 192, 192, 192),
          border: Border.all(color: Color.fromARGB(33, 13, 5, 5)),
          borderRadius: BorderRadius.circular(25)
        ),
       child: Row(
          children: [
            Expanded(// allow to enter unlimited length charater beyond the screen7
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Wallpapers",
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>SearchScreen(SearchQuery: _searchController.text)));
              },
              child: Icon(Icons.search),
            ),
          ],
        )

      );

  }
}
