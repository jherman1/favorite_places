
import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  void addFavoritePlace(Place place) {

    state = [...state, place];

  }
}

final favoritePlacesProvider = StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});