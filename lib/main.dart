import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/pages/root/root_page.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/mini_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final SongNotifier songNotifier = getIt<SongNotifier>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: ListenableBuilder(
        listenable: songNotifier,
        builder: (context, _) {
          final hasCurrentSong = songNotifier.currentSong != null;
          return Scaffold(
            body: Stack(
              children: [
                const RootPage(),
                AnimatedPositioned(
                  duration: Durations.medium3,
                  curve: Cubic(0.32, 0.72, 0, 1),
                  bottom: hasCurrentSong
                      ? 0
                      : -140 - MediaQuery.of(context).padding.bottom,
                  left: 0,
                  right: 0,
                  child: MiniPlayer(
                      hasCurrentSong: hasCurrentSong,
                      songNotifier: songNotifier),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
