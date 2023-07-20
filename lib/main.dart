import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/providers/characters_data.dart';
import 'package:star_wars/providers/films_data.dart';
import 'package:star_wars/providers/music_data.dart';
import 'package:star_wars/screens/splash.dart';
import 'package:star_wars/widgets/app_lifecycle_observer.dart';

const Color seedColor = Color.fromARGB(255, 0, 0, 0);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color starWarsYellow = Color.fromARGB(255, 255, 225, 0);
const Color transparentStarWarsYellow = Color.fromARGB(255, 155, 137, 33);
var kColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: seedColor, background: seedColor);

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: seedColor,
      titleTextStyle: const TextStyle(
          color: starWarsYellow, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: starWarsYellow,
        hintStyle: TextStyle(color: starWarsYellow),
        focusColor: starWarsYellow,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: starWarsYellow)),
        labelStyle: TextStyle(color: starWarsYellow)),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: starWarsYellow,
      selectionHandleColor: starWarsYellow,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(color: starWarsYellow),
      selectedItemColor: starWarsYellow,
      unselectedItemColor: transparentStarWarsYellow,
      backgroundColor: Color.fromARGB(184, 50, 50, 50),
      selectedIconTheme: IconThemeData(color: starWarsYellow),
      unselectedIconTheme: IconThemeData(color: transparentStarWarsYellow),
      unselectedLabelStyle: TextStyle(color: starWarsYellow),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.client});
  final ValueNotifier<GraphQLClient> client;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  late LifecycleObserver lifecycleObserver;

  @override
  void initState() {
    super.initState();
    lifecycleObserver = LifecycleObserver(audioPlayer: audioPlayer);
    WidgetsBinding.instance.addObserver(lifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(lifecycleObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CharactersProvider()),
          ChangeNotifierProvider(create: (context) => FilmsProvider()),
          ChangeNotifierProvider(create: (context) => MusicProvider()),
        ],
        child: MaterialApp(
          title: 'Star Wars Characters',
          theme: theme,
          home: SplashScreen(audioPlayer),
        ),
      ),
    );
  }
}
