import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:visit_nepal/theme/theme_state.dart';
import 'screens/home.dart';

void main() async {
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink("https://tourism-nepal.herokuapp.com/");
  ValueNotifier<GraphQLClient> graphQlClient = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  runApp(GraphQLProvider(
      client: graphQlClient,
      child: ChangeNotifierProvider<ThemeState>(
        create: (_) => ThemeState(),
        child: MaterialApp(
          title: 'Welcome to Nepal',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      )));
}
