import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imanage/services/firebase_authetication.dart';
import 'package:imanage/services/hive.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/view/screens/home_screen.dart';
import 'package:imanage/view/screens/login_screen.dart';
import 'package:imanage/view/screens/profile_screen.dart';
import 'package:imanage/view/screens/registration_screen.dart';
import 'package:imanage/view/screens/select_avatar_screen.dart';
import 'package:imanage/view/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'splash',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        if (hiveServices.isSet()) {
          return StreamBuilder(
            stream: authServices.authChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  backgroundColor: primaryBgColor,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: btnBgColor,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return const HomeScreen();
              }
              return const LoginScreen();
            },
          );
        }
        return const SplashScreen();
      },
      routes: <RouteBase>[
        // GoRoute(
        //   name: 'login',
        //   path: 'login',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return StreamBuilder(
        //       stream: authServices.authChanges(),
        //       builder: (context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return const Scaffold(
        //             backgroundColor: primaryBgColor,
        //             body: Center(
        //               child: CircularProgressIndicator(
        //                 color: btnBgColor,
        //               ),
        //             ),
        //           );
        //         }
        //         if (snapshot.hasData) {
        //           return const HomeScreen();
        //         }
        //         return LoginScreen();
        //       },
        //     );
        //   },
        // ),
        GoRoute(
          name: 'home',
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              name: 'selectavatar',
              path: 'selectavatar',
              builder: (BuildContext context, GoRouterState state) {
                return const SelectAvatarScreen();
              },
            ),
            GoRoute(
              name: 'profile',
              path: 'profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileScreen();
              },
            ),
          ],
        ),
        GoRoute(
          name: 'login',
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),

        GoRoute(
          name: 'register',
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegistrationScreen();
          },
        ),
      ],
    ),
  ],
);
