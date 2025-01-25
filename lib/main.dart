import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monophony/pages/quick_access_page.dart';
import 'package:monophony/pages/songs_page.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/custom_vertical_page_view.dart';
import 'package:monophony/widgets/navigation_button.dart';
import 'package:monophony/controllers/page_controller.dart';

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
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 20.0),
              child: ListenableBuilder(
                listenable: getIt<AppPageController>(),
                builder: (context, _) {
                  final currentPage = getIt<AppPageController>().currentPage;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: const Offset(6, 0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_outlined),
                        ),
                      ),
                      const SizedBox(height: 40),
                      NavigationButton(
                        text: 'Acceso rápido',
                        active: currentPage == 0,
                        icon: Icons.auto_awesome_rounded,
                        quarterTurns: 3,
                        onPressed: () =>
                            getIt<AppPageController>().changePage(0),
                      ),
                      NavigationButton(
                        text: 'Canciones',
                        active: currentPage == 1,
                        icon: Icons.music_note_rounded,
                        onPressed: () =>
                            getIt<AppPageController>().changePage(1),
                      ),
                      NavigationButton(
                        text: 'Listas',
                        active: currentPage == 2,
                        icon: Icons.playlist_play_rounded,
                        onPressed: () =>
                            getIt<AppPageController>().changePage(2),
                      ),
                      NavigationButton(
                        text: 'Artistas',
                        active: currentPage == 3,
                        icon: Icons.person_rounded,
                        onPressed: () =>
                            getIt<AppPageController>().changePage(3),
                      ),
                      NavigationButton(
                        text: 'Álbumes',
                        icon: Icons.album_rounded,
                        active: currentPage == 4,
                        onPressed: () =>
                            getIt<AppPageController>().changePage(4),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: CustomVerticalPageView(
              controller: getIt<AppPageController>(),
              pages: [
                QuickAccessPage(),
                SongsPage(),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text('Página 3',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
