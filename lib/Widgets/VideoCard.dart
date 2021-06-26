import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtubeuiflutter/data.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:youtubeuiflutter/screens/ImportScreens.dart';

class VideoCard extends StatelessWidget {
final Video video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read(selectedVideoProvider).state = video;
        context.read(miniPlayerControllerProvider).state.animateToHeight(state: PanelState.MAX);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(video.thumbnailUrl, height: 220,
              width: double.infinity,
               fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: Text(video.duration),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(video.author.profileImageUrl),
                ),
                SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text(video.title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
                      maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text('${video.author.username} • ${video.viewCount} • ${timeAgo.format(video.timestamp)}',
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),)
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: (){ print('More');},
                    child: Icon(Icons.more_vert))
              ],
            ),
          )
        ],
      ),
    );
  }
}
