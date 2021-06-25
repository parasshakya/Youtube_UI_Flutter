import 'package:flutter/material.dart';

import '../data.dart';

class YoutubeAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset('assets/yt_logo_dark.png'),
      ),
      actions: [
        IconButton(icon: const Icon( Icons.cast), onPressed: (){},),
        IconButton(icon: const Icon( Icons.notifications_outlined), onPressed: (){},),
        IconButton(icon: const Icon( Icons.search), onPressed: (){},),
        IconButton(icon: CircleAvatar(
          foregroundImage: NetworkImage(currentUser.profileImageUrl),
        ), onPressed: (){}, iconSize: 40.0,),
      ],
    );
  }
}
