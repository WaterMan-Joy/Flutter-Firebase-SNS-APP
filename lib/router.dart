import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/features/auth/screens/login_screen.dart';
import 'package:flutter_firebase_sns_app/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {'/': (route) => MaterialPage(child: LoginScreen())});

final loggedInRoute =
    RouteMap(routes: {'/': (route) => MaterialPage(child: HomeScreen())});
