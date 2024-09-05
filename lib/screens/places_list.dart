import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});

  @override
  ConsumerState<PlacesListScreen> createState() {
    return _PlacesListScreenState();
  }
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  void _addPlace() async {
    final newPlace = await Navigator.of(context).push<Place>(
      MaterialPageRoute(
        builder: (ctx) => const NewPlaceScreen(),
      ),
    );
    if (newPlace == null) {
      return;
    }
    // setState(() {
    //   _groceryItems.add(newPlace);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(favoritePlacesProvider);

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
          itemCount: places.length,
          itemBuilder: (ctx, index) => Text(places[index].title));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places List'),
        actions: [
          IconButton(
            onPressed: _addPlace,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
