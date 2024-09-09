import 'package:favorite_places/screens/add_place.dart';
// import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {

  /// Following Solution Video 240, implemented the anonymous function, in build(), 
  /// below to use screens/add_place.dart instead of my self implemented 
  /// screens/new_place.dart which is called in this function.
  // @Deprecated('No longer used.  Using screens/add_place.dart instead.')
  // void _addNewPlace() async {
  //   final newPlace = await Navigator.of(context).push<Place>(
  //     MaterialPageRoute(
  //       builder: (ctx) => const NewPlaceScreen(),
  //     ),
  //   );
  //   if (newPlace == null) {
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places List'),
        actions: [
          IconButton(
            // onPressed: _addNewPlace, ///Removed b/c of explanation above ^^
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: PlacesList(places: places),
    );
  }
}
