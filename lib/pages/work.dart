import 'package:flutter/material.dart';

import 'package:flutter_google_maps_webservices/places.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "<YOUR_API_KEY>");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Places'),
      ),
      body: FutureBuilder(
        future: searchNearbyPlaces(),
        builder: (context, AsyncSnapshot<List<PlacesSearchResult>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No places found nearby.'));
          } else {
            // Render your map and display pins for each place
            return Center(
              child: Text('Map with places will be shown here.'),
            );
          }
        },
      ),
    );
  }

  Future<List<PlacesSearchResult>> searchNearbyPlaces() async {
    final response = await places.searchNearbyWithRadius(
      Location(lat: 31.0424, lng: 42.421),
      500,
      type: 'restaurant', // You can specify the type of places you want to search for
    );

    if (response.isOkay) {
      return response.results;
    } else {
      throw response.errorMessage!;
    }
  }
}



// https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=5.5592846%2C-0.1974306&type=veterinary_care&radius=5000&key=AIzaSyB_xLxnQ-NXFZ_nZnwtvbmshp6Aif1V75o