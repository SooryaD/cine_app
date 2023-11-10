import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'query.dart';

class MainController extends GetxController {
  final RxList<dynamic> categ = [].obs;
  // final RxList<dynamic> mylist = [].obs;
  final RxList<dynamic> series = [].obs;
  // final RxList<dynamic> favorites = [].obs;
  final RxList<dynamic> plan = [].obs;

  Future GetPlans(BuildContext context) async {
    final _client = GraphQLProvider.of(context).value;

    final QueryResult result = await _client.query(QueryOptions(
      document: gql(get_mst_Plans),
    ));
    if (!result.hasException) {}
    if (result.data != null) {
      final List<Map<String, dynamic>> planData =
          (result.data?["streamify_mst_plans"] as List<dynamic>)
              .cast<Map<String, dynamic>>();

      plan.value = planData;

      log("subscription________________________${plan.value}");
    }
  }

  Future GetGenersCategory(BuildContext context) async {
    final _client = GraphQLProvider.of(context).value;

    final QueryResult result = await _client.query(QueryOptions(
      document: gql(getCategories),
    ));
    if (!result.hasException) {}
    if (result.data != null) {
      final List<Map<String, dynamic>> genersData =
          (result.data?['streamify_mst_categories'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      categ.value = genersData;
      // log("menu____________________________${categ.value}");
    }
  }

  // Future<void> GetMyList(BuildContext context) async {
  //   final _client = GraphQLProvider.of(context).value;

  //   final QueryResult result = await _client.query(
  //     QueryOptions(
  //       document: gql(getMyList),
  //     ),
  //   );

  //   if (!result.hasException) {
  //     if (result.data != null) {
  //       final List<Map<String, dynamic>>? mylistmovies =
  //           (result.data?["streamify_mst_movies"] as List<dynamic>?)
  //               ?.cast<Map<String, dynamic>>();

  //       if (mylistmovies != null) {
  //         mylist.value = mylistmovies;
  //         log("menu____________________________${mylist.value}");
  //       }
  //     }
  //   }
  // }

  Future GetSeries(BuildContext context) async {
    final _client = GraphQLProvider.of(context).value;

    final QueryResult result = await _client.query(QueryOptions(
      document: gql(getSeries),
    ));
    if (!result.hasException) {}
    if (result.data != null) {
      final List<Map<String, dynamic>> seriesData =
          (result.data?["streamify_mst_series"] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      series.value = seriesData;

      // log("seriessss_________________________${series.value}");
    }
  }

  // Future GetFavorites(BuildContext context) async {
  //   final _client = GraphQLProvider.of(context).value;

  //   final QueryResult result = await _client.query(QueryOptions(
  //     document: gql(getFavorites),
  //   ));
  //   if (!result.hasException) {}
  //   if (result.data != null) {

  //     final List<Map<String, dynamic>> favoritesData =
  //         (result.data?["streamify_mst_favorites"] as List<dynamic>)
  //             .cast<Map<String, dynamic>>();

  //     favorites.value = favoritesData;

  //     log("favorietsss___________________________${favorites.value}");
  //   }
  // }
}
