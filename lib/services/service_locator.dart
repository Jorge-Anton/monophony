import 'package:get_it/get_it.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/my_mini_player_controller.dart';
import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/controllers/page_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register InnerTube as a singleton
  getIt.registerSingleton<InnerTube>(InnerTube());
  getIt.registerSingleton<AppPageController>(AppPageController());
  getIt.registerLazySingleton<SongNotifier>(() => SongNotifier());
  getIt.registerLazySingleton(() => MyMiniPlayerController());
  getIt.registerLazySingleton(() => MiniplayerController());
}
