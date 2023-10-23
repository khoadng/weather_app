import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.suggestionsBuilder,
    required this.onSelected,
  });

  final Future<List<String>> Function(String query) suggestionsBuilder;
  final void Function(String value) onSelected;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: (context, controller) => widget
            .suggestionsBuilder(
              controller.value.text,
            )
            .then((value) => value.map(
                  (suggestion) => ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      setState(() {
                        controller.closeView(suggestion);
                      });
                      widget.onSelected(suggestion);
                    },
                  ),
                )));
  }
}
