import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtubeuiflutter/data.dart';
import 'package:youtubeuiflutter/screens/ImportScreens.dart';
import 'package:youtubeuiflutter/Widgets/widgetsImport.dart';
class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController?.dispose();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read(miniPlayerControllerProvider).state.animateToHeight(state: PanelState.MAX),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomScrollView(
              controller: _scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context,watch,_){
                      final _selectedVideo = watch(selectedVideoProvider).state;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Image.network(_selectedVideo!.thumbnailUrl,
                              height: 220.0,
                              width: double.infinity,
                              fit: BoxFit.cover,),
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () => context.read(miniPlayerControllerProvider).state.animateToHeight(
                                  state: PanelState.MIN
                                ),
                              )
                            ],
                          ),
                          const LinearProgressIndicator(
                            value: 0.6,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red),
                          ),
                          VideoInfo(video: _selectedVideo),
                        ],
                      );
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context,index){
                        final Video video = suggestedVideos[index];
                        return VideoCard(video: video, hasPadding: true, onTap:
                        () => _scrollController?.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut)
                          );
                      },
                    childCount: suggestedVideos.length,

                )

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
