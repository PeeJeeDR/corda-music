import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({Key? key, required this.song}) : super(key: key);

  final Video song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      leading: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(song.thumbnails.lowResUrl),
          ),
          () {
            // if (_loading) {
            //   return Positioned(
            //     left: 0,
            //     right: 0,
            //     top: 0,
            //     bottom: 0,
            //     child: Container(
            //       child: const Center(
            //         child: SizedBox(
            //           width: 25,
            //           height: 25,
            //           child: CircularProgressIndicator(
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       decoration: BoxDecoration(
            //         color: Colors.black.withOpacity(0.5),
            //         borderRadius: BorderRadius.circular(6),
            //       ),
            //     ),
            //   );
            // }

            return const SizedBox.shrink();
          }()
        ],
      ),
      title: Text(song.title),
      onTap: () => print(song),
    );
  }
}
