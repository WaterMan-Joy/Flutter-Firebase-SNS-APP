import 'package:flutter/material.dart';
import 'package:flutter_firebase_sns_app/features/auth/screens/login_screen.dart';
import 'package:flutter_firebase_sns_app/features/community/screens/community_screen.dart';
import 'package:flutter_firebase_sns_app/features/community/screens/create_community_screen.dart';
import 'package:flutter_firebase_sns_app/features/community/screens/edit_community_screen.dart';
import 'package:flutter_firebase_sns_app/features/community/screens/mod_tools.screen.dart';
import 'package:flutter_firebase_sns_app/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {'/': (route) => MaterialPage(child: LoginScreen())});

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => MaterialPage(child: HomeScreen()),
    '/create-community': (route) =>
        MaterialPage(child: CreateCommunityScreen()),
    '/r/:name': (route) => MaterialPage(
            child: CommunityScreen(
          name: route.pathParameters['name'] ?? '',
        )),
    '/mod-tools/:name': (routeData) => MaterialPage(
            child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        )),
    '/edit-community/:name': (route) => MaterialPage(
            child: EditCommunityScreen(
          name: route.pathParameters['name']!,
        )),
  },
);
