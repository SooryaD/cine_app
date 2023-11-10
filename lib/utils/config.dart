import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final HttpLink httpLink =
      HttpLink('https://gentle-jay-70.hasura.app/v1/graphql', defaultHeaders: {
    'x-hasura-admin-secret':
        'lFzdfKderyPmB5fTy1OMERjaAGb0abBp3ZdeiH0aU3eTB07anRryEPcTsMK4t5DI'
  });
  static ValueNotifier<GraphQLClient> getLink() {
    final Link link = httpLink;

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(),
      ),
    );
    return client;
  }
}
