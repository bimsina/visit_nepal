import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'modals/graphQlConstant.dart';
import 'screens/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: graphQlClient,
        child: MaterialApp(
          title: 'Welcome to Nepal',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
