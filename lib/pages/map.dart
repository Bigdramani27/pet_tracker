import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class MapOfVeterinarian extends StatefulWidget {
  const MapOfVeterinarian({super.key});

  @override
  State<MapOfVeterinarian> createState() => _MapOfVeterinarianState();
}

class _MapOfVeterinarianState extends State<MapOfVeterinarian> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late GoogleMapsPlaces places;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Marker? userLocationMarker;

  @override
  void initState() {
    super.initState();
    String? baseUrl;

    baseUrl =
        'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api';

    places = GoogleMapsPlaces(
        apiKey: 'AIzaSyB_xLxnQ-NXFZ_nZnwtvbmshp6Aif1V75o', baseUrl: baseUrl);
    _initMap();
  }

  Future<void> _initMap() async {
    bool hasPermission = await _requestLocationPermission();
    if (hasPermission) {
      _getCurrentLocation();
    }
  }

  Future<bool> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show dialog
      await _showLocationPermissionDialog();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show dialog
        await _showLocationPermissionDialog();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show dialog
      await _showLocationPermissionDialog();
      return false;
    }

    return true;
  }

  Future<void> _showLocationPermissionDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: Container(
          width: 600,
          child: const Text(
              "If you're on a laptop, click the location icon on the right side of your search field, then choose 'Always Allow' and refresh the page. If you're on mobile, tap the icon on the left side of the search field, go to 'Permissions', and toggle on location."),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Update the camera position to the current location
    mapController.animateCamera(CameraUpdate.newLatLng(
      LatLng(position.latitude, position.longitude),
    ));

    // Add a marker for the user's current location
    final userIcon = await _getBitmapDescriptorFromAsset('images/ping.png',
        size: const Size(24, 24));
    setState(() {
      userLocationMarker = Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'My Location'),
        icon: userIcon,
      );
      markers.add(userLocationMarker!);
    });

    // Get nearby places using the current location
    _getNearbyPlaces(position.latitude, position.longitude);
  }

  Future<BitmapDescriptor> _getBitmapDescriptorFromAsset(String assetName,
      {Size size = const Size(24, 24)}) async {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: size * devicePixelRatio);
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(imageConfiguration, assetName);
    return bitmapDescriptor;
  }

  Future<void> _getNearbyPlaces(double lat, double lng) async {
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
      Location(lat: lat, lng: lng),
      1500,
      type: 'veterinary_care',
    );

    setState(() {
      markers.clear();
      // Add user location marker
      if (userLocationMarker != null) {
        markers.add(userLocationMarker!);
      }
      for (PlacesSearchResult result in response.results) {
        final placeId = result.placeId;
        final location = result.geometry!.location;
        final name = result.name;
        final latLng = LatLng(location.lat, location.lng);
        final googleMapsUrl =
            'https://www.google.com/maps/search/?api=1&query=${location.lat},${location.lng}';

        markers.add(
          Marker(
            markerId: MarkerId(placeId),
            position: latLng,
            infoWindow: InfoWindow(
              title: name,
              snippet: 'View on Google Maps',
              onTap: () {
                _launchURL(googleMapsUrl);
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed), // Red marker
          ),
        );
      }
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Map of Veterinarian')
            : null,
        drawer: const BigNav(currentPage: 'veterinarian'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? const BigNav(currentPage: 'veterinarian')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)
                    ? const SmallNav(currentPage: 'veterinarian')
                    : null,
              )),
            if (ResponsiveWidget.isSmallScreen(context)) Container(),
            Expanded(
                flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                child: SingleChildScrollView(
                  child: Container(
                      margin: ResponsiveWidget.isLargeScreen(context)
                          ? const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 120)
                          : ResponsiveWidget.isMediumScreen(context)
                              ? const EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 100)
                              : ResponsiveWidget.isSmallScreen(context)
                                  ? const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20)
                                  : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Map of Veterinarian',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 5),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Welcome to the Pet Location Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              text: 'The following ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\"Icons\"',
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                TextSpan(
                                    text: ' will tell you what the icon mean',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.location_on),
                              Text("This Icon shows your location")
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: thirdly,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 280),
                                child: Text(
                                  maxLines: 2,
                                  "This Icon shows the number of Veterinarian around you",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                color: Color.fromARGB(255, 78, 198, 253),
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 280),
                                child: Text(
                                  maxLines: 2,
                                  "if you see a big blue box kindly wait map is loading ",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 500,
                            child: (kIsWeb)
                                ? GoogleMap(
                                    initialCameraPosition: const CameraPosition(
                                      target: LatLng(0,
                                          0), // Placeholder, will be updated to current location
                                      zoom: 15,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      mapController = controller;
                                      // Move the camera to the current location when the map is created
                                      _getCurrentLocation();
                                    },
                                    markers: markers,
                                  )
                                : null,
                          ),
                        ],
                      )),
                )),
          ],
        ));
  }
}
