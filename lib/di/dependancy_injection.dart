import 'package:card_example/services/youtube/i_youtube_service.dart';
import 'package:card_example/services/youtube/youtube_service.dart';
import 'package:card_example/services/rest_client.dart';

enum Flavor { MOCK, PRO }

//Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) async {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  IYoutubeService get youtubeService {
    switch (_flavor) {
      case Flavor.MOCK:
        return null;
      default:
        return YoutubeService(new RestClient());
    }
  }
}
