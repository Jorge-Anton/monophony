import 'package:get_it/get_it.dart';
import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/controllers/page_controller.dart';
import 'package:monophony/controllers/song_notifier.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register InnerTube as a singleton
  getIt.registerLazySingleton<InnerTube>(() => InnerTube());
  getIt.registerLazySingleton<AppPageController>(() => AppPageController());
  getIt.registerLazySingleton<SongNotifier>(() => SongNotifier());
}
