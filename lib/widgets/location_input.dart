// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
import 'package:favorite_places/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSetPlaceLocation});

  final void Function(PlaceLocation placeLocation) onSetPlaceLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedPlaceLocation;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    /// The following code is from videos 252-... for implementing Google Maps API,
    /// which I didn't fully do as it requires creating an account and signing up with
    /// a credit card (although free use credits are provided upon sign-up).
    /// For Full Implementation:
    ///   - Uncomment code containing api key, url, get request, json decoding, and extracting the address
    ///   - Set googleMapsAPIKey with actual api key
    ///   - Uncomment imports for:
    ///       - 'dart:convert'
    ///       - 'package:http/http.dart' as http
    ///   - Add neccessary response error checks once implemented
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if(lat == null || lng == null) {
      return;
    }

    // const googleMapsApiKey = 'YOUR_API_KEY';
    // final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapsApiKey');
    // final response = await http.get(url);
    // final resData = json.decode(response.body);
    // final address = resData['results'][0]['formattted_address'];
    const address = '123 Fake Address Street, Nowheresville, Lala land';

    setState(() {
      _isGettingLocation = false;
      _pickedPlaceLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
    });

    widget.onSetPlaceLocation(_pickedPlaceLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_pickedPlaceLocation != null) {
      previewContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              Text(
                '${_pickedPlaceLocation!.latitude}, ${_pickedPlaceLocation!.longitude}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          Text(
            _pickedPlaceLocation!.address,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.primary),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
