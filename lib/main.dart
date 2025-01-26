import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/pages/root/root_page.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/multi_value_listenable.dart';
import 'package:monophony/widgets/my_mini_player.dart';

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
      home: OverlayPage(),
    );
  }
}

class OverlayPage extends StatelessWidget {
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final songNotifier = getIt<SongNotifier>();
    final miniPlayerController = getIt<MyMiniPlayerController>();
    bool shouldAnimate = true;

    return Scaffold(
      body: ListenableBuilder(
        listenable: MultiValueListenable([
          songNotifier,
          miniPlayerController.dragDownPercentage,
          miniPlayerController.playerExpandProgress,
        ]),
        child: const RootPage(),
        builder: (context, child) {
          final dragDownPercentage =
              miniPlayerController.dragDownPercentage.value;
          final playerExpandProgress =
              miniPlayerController.playerExpandProgress.value;
          final currentSong = songNotifier.currentSong;

          Duration duration = Duration.zero;
          if (shouldAnimate && currentSong != null) {
            duration = Durations.medium3;
            shouldAnimate = false;
          }
          if (!shouldAnimate && dragDownPercentage == 1) {
            shouldAnimate = true;
          }

          return Stack(
            children: [
              child!,
              AnimatedPositioned(
                duration: duration,
                curve: const Cubic(0.32, 0.72, 0, 1),
                right: 0,
                left: 0,
                bottom: 50 + playerExpandProgress * (1 - dragDownPercentage),
                child: CustomPaint(
                  painter: MyMiniPlayerPainter(radius: 50),
                ),
              ),
              AnimatedPositioned(
                duration: Durations.medium3,
                curve: const Cubic(0.32, 0.72, 0, 1),
                left: 0,
                right: 0,
                bottom: currentSong == null
                    ? -90 - MediaQuery.of(context).viewPadding.bottom
                    : 0,
                child: const MyMiniPlayer(),
              )
            ],
          );
        },
      ),
    );
  }
}
