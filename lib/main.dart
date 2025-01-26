import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';
import 'package:monophony/pages/root/root_page.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/multi_value_listenable.dart';
import 'package:monophony/widgets/my_mini_player.dart';
import 'dart:ui';

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

          final minPlayerHeight =
              84 + MediaQuery.of(context).viewPadding.bottom + 14;
          final maxPlayerHeight = MediaQuery.of(context).size.height * 4 / 5;

          // Calculate thresholds
          final blurThreshold = maxPlayerHeight * 0.9;
          final opacityThreshold = maxPlayerHeight * 0.75;

          // Only show hint when fully expanded
          final isFullyExpanded = playerExpandProgress >= maxPlayerHeight;

          // Calculate other progress values
          final blurProgress = playerExpandProgress > blurThreshold
              ? (playerExpandProgress - blurThreshold) /
                  (maxPlayerHeight - blurThreshold)
              : 0.0;
          final opacityProgress = playerExpandProgress > opacityThreshold
              ? (playerExpandProgress - opacityThreshold) /
                  (maxPlayerHeight - opacityThreshold)
              : 0.0;

          return Stack(
            children: [
              Transform.translate(
                  offset: Offset(
                    0,
                    currentSong == null
                        ? 0
                        : -playerExpandProgress + minPlayerHeight,
                  ),
                  child: Stack(
                    children: [
                      child!,
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: !isFullyExpanded,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX:
                                  currentSong == null ? 0 : 32 * blurProgress,
                              sigmaY:
                                  currentSong == null ? 0 : 32 * blurProgress,
                            ),
                            child: Container(
                              color: Colors.white.withAlpha((currentSong == null
                                      ? 0
                                      : 200 * opacityProgress)
                                  .toInt()),
                            ),
                          ),
                        ),
                      ),
                      SwipeHint(isFullyExpanded: isFullyExpanded)
                    ],
                  )),
              AnimatedPositioned(
                duration: Durations.medium3,
                curve: const Cubic(0.32, 0.72, 0, 1),
                left: 0,
                right: 0,
                bottom: currentSong == null
                    ? -84 - MediaQuery.of(context).viewPadding.bottom - 14
                    : 0,
                child: const MyMiniPlayer(),
              ),
              AnimatedPositioned(
                duration: duration,
                curve: const Cubic(0.32, 0.72, 0, 1),
                right: 0,
                left: 0,
                bottom: MediaQuery.viewPaddingOf(context).top +
                    playerExpandProgress * (1 - dragDownPercentage),
                child: CustomPaint(
                  painter: MyMiniPlayerPainter(
                    radius: MediaQuery.viewPaddingOf(context).top,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SwipeHint extends StatelessWidget {
  const SwipeHint({
    super.key,
    required this.isFullyExpanded,
  });

  final bool isFullyExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 0,
      right: 0,
      bottom: isFullyExpanded
          ? MediaQuery.sizeOf(context).height * 0.2
          : MediaQuery.sizeOf(context).height * 0.15,
      duration: Durations.medium3,
      curve: const Cubic(0.32, 0.72, 0, 1),
      child: AnimatedOpacity(
        opacity: isFullyExpanded ? 1 : 0,
        duration: Durations.medium3,
        curve: const Cubic(0.32, 0.72, 0, 1),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.swipe_down_outlined,
              color: Colors.grey[600],
              size: 18,
            ),
            Text(
              'Desliza hacia abajo',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
