import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/providers/characters_data.dart';
import 'package:star_wars/screens/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  final HttpLink httpLink =
      HttpLink('https://swapi-graphql.netlify.app/.netlify/functions/index');

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CharactersProvider()),
        ],
        child: MaterialApp(
          title: 'Star Wars Characters',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
