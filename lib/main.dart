import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/providers/characters_data.dart';
import 'package:star_wars/providers/films_data.dart';
import 'package:star_wars/screens/splash.dart';

const Color seedColor = Color.fromARGB(255, 0, 0, 0);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color starWarsYellow = Color.fromARGB(255, 255, 225, 0);
var kColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: seedColor, background: seedColor);

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: seedColor,
      titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 225, 0),
          fontWeight: FontWeight.bold,
          fontSize: 20),
    ),
    textTheme: const TextTheme(
        bodyLarge:
            TextStyle(color: starWarsYellow, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(color: white)));

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
  const MyApp({super.key, required this.client});
  final ValueNotifier<GraphQLClient> client;
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CharactersProvider()),
          ChangeNotifierProvider(create: (context) => FilmsProvider()),
        ],
        child: MaterialApp(
          title: 'Star Wars Characters',
          theme: theme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
