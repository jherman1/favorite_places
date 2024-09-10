import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  /// This code is from video 257 (using Google Static Maps API for getting an image of a location)
  /// For full implementation:
  ///   - Remove existing return value.
  ///   - Uncomment all other code
  ///   - add a valid googleMapsApiKey
  String get locationImage {
    // final lat = place.location.latitude;
    // final lng = place.location.longitude;
    // const googleMapsApiKey = 'YOUR_API_KEY';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$googleMapsApiKey';
    return 'https://media.istockphoto.com/id/1392356345/photo/city-street-map.jpg?s=1024x1024&w=is&k=20&c=z-TJvPqbiE1Ze0BAuxonLiu7fprN01zMY1HxU3vYrg8=';
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(locationImage),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Text(
              place.location.address,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          previewContent,
        ],
      ),
    );
  }
}
