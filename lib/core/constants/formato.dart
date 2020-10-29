import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const inputFormDecorador = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown, width: 2.0)),
);

TextStyle appBarTextStyle =
    GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold);

TextStyle fichasTextStyle =
    GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.normal);

TextStyle AppBarAnexosTextStyle =
    GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.bold);

TextStyle fichasBoldGrandeTextStyle =
    GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold);

TextStyle fichasBoldGrandeAlertaTextStyle = GoogleFonts.openSans(
    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepOrange);

TextStyle fichasBoldGrandeInfoTextStyle = GoogleFonts.openSans(
    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey);

const String homeCalidadRoute = '/screens/home/home_calidad';
const String homeCatastradorRoute = '/screens/home/home_catastrador';
const String homeClienteRoute = '/screens/home/home_cliente';
const String homeConstratistaRoute = '/screens/home/home_contratista';
const String homeVecinoRoute = '/screens/home/home_vecino';
const String homeUsuarioRoute = '/screens/home/home_usuario';
const String homeTestingRoute = '/screens/home/home_testing';
const String homeInscripcionRoute = '/screens/home/home_inscripcion';
const String homeSeleccionRoute = '/controladores/seleccion_usuario';
const MapStyleRetro = [
  {
    "elementType": "geometry",
    "stylers": [
      {"color": "#ebe3cd"}
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#523735"}
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {"color": "#f5f1e6"}
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {"color": "#c9b2a6"}
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {"color": "#dcd2be"}
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#ae9e90"}
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {"color": "#dfd2ae"}
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {"color": "#dfd2ae"}
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#93817c"}
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {"color": "#a5b076"}
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#447530"}
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {"color": "#f5f1e6"}
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {"color": "#fdfcf8"}
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {"color": "#f8c967"}
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {"color": "#e9bc62"}
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {"color": "#e98d58"}
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {"color": "#db8555"}
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#806b63"}
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {"color": "#dfd2ae"}
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#8f7d77"}
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {"color": "#ebe3cd"}
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {"color": "#dfd2ae"}
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {"color": "#b9d3c2"}
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {"color": "#92998d"}
    ]
  }
];
