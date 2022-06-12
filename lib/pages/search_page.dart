import 'package:corda_music/main.dart';
import 'package:corda_music/services/search_service.dart';
import 'package:corda_music/widgets/widget_tile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchService = getIt.get<SearchService>();

    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 40,
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 25,
                top: 20,
                bottom: 20,
                right: 20,
              ),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              labelText: 'Search for music',
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            onChanged: (query) => searchService.searchMusic(query),
          ),
          StreamBuilder(
            stream: searchService.searchResults$,
            builder: (context, snap) {
              return Expanded(
                child: ListView.builder(
                  itemCount: searchService.searchResults.length,
                  itemBuilder: (context, index) {
                    return MusicTile(song: searchService.searchResults[index]);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
