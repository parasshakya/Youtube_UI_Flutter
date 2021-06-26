import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtubeuiflutter/screens/ImportScreens.dart';
import 'package:youtubeuiflutter/Widgets/widgetsImport.dart';
class VideoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
