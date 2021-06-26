import 'package:flutter/material.dart';
import 'package:youtubeuiflutter/Widgets/Youtube_Sliver_AppBar.dart';
import 'package:youtubeuiflutter/Widgets/widgetsImport.dart';
import '../data.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
              YoutubeAppBar(),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 65.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context,index){
                        final Video video = videos[index];
                        return VideoCard(video: video);
                      },
                      childCount: videos.length,

                  ),

                ),
              )
          ],
        ),
      ),
    );
  }
}
