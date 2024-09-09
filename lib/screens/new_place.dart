// import 'package:favorite_places/models/place.dart';
// import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerWidget {
  const NewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    // var enteredTitle = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Place'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Title must be between 1 and 50 charachters long.';
                }
                return null;
              },
              onSaved: (value) {
                // enteredTitle = value!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save(); //executes all onSaved()
                }
                // ref
                //     .read(favoritePlacesProvider.notifier)
                //     .addFavoritePlace(Place(title: enteredTitle));

                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 76,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add Place'),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
