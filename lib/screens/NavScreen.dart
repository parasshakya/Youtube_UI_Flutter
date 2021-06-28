import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtubeuiflutter/Widgets/Responsive.dart';
import 'package:youtubeuiflutter/screens/ImportScreens.dart';

import '../data.dart';
final selectedVideoProvider = StateProvider<Video?>((ref) => null);
final miniPlayerControllerProvider = StateProvider<MiniplayerController>((ref) => MiniplayerController());

class NavScreen extends StatefulWidget {

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  double _playerMinHeight = 60.0;
  final _screens = [
    HomeScreen(),
    const Scaffold(body: Center(child: Text('Explore'),),),
    const Scaffold(body: Center(child: Text('Add'),),),
    const Scaffold(body: Center(child: Text('Subscriptions'),),),
    const Scaffold(body: Center(child: Text('Library'),),),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      body: Consumer(
        builder: (context,watch,_){
          final selectedVideo = watch(selectedVideoProvider).state;
          final _miniPlayerController = watch(miniPlayerControllerProvider).state;
          print(selectedVideo);
         return Stack(
            children:
            _screens.asMap().map((i,screen) => MapEntry(i, Offstage(
              child: screen,
              offstage: _selectedIndex != i,
            ))).values.toList()..add(
              Offstage(
                offstage: selectedVideo == null ,
                child: Miniplayer(
                  controller: _miniPlayerController,
                  minHeight: _playerMinHeight ,
                  maxHeight: MediaQuery.of(context).size.height,
                  builder: (height,percentage){
                    if(height <= _playerMinHeight + 50.0) {
                      return Container(
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  selectedVideo!.thumbnailUrl,
                                  height: _playerMinHeight - 4,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8.0,),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Flexible(child: Text(
                                        selectedVideo.title, style: Theme
                                          .of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Text('${selectedVideo.author.username}',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),)
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    context
                                        .read(selectedVideoProvider)
                                        .state = null;
                                  },
                                )
                              ],
                            ),
                            const LinearProgressIndicator(
                              value: 0.6,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            )
                          ],
                        ),
                      );
                    }else {
                      return VideoScreen();
                    }
                    },
                ),
              )
            ),

          );
        },

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
         currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        unselectedFontSize: 10.0,
        selectedFontSize: 10.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: 'Subscriptions'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: 'Library'
          )
        ],
      ),
    );
  }
}
