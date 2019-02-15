import 'dart:async';
import 'package:nghe_phap/services/network_service.dart';
import 'package:nghe_phap/services/rest_client.dart';
import 'package:nghe_phap/services/youtube/i_youtube_service.dart';
import 'package:nghe_phap/utils/uidata.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

class YoutubeService extends NetworkService implements IYoutubeService {

  final Client client = clientViaApiKey(UIData.youtubeApiKey);
  YoutubeService(RestClient rest) : super(rest);

  @override Future<PlaylistItemListResponse> getPlaylistItems(String playlistId, String nextPageToken) async {
    var youtubeApi = new YoutubeApi(client);
    return youtubeApi.playlistItems.list('snippet,contentDetails', playlistId: playlistId, pageToken: nextPageToken);
  }

  @override Future<PlaylistListResponse> getChannelPlaylists(String channelId, String nextPageToken) async {
    var youtubeApi = new YoutubeApi(client);
    return youtubeApi.playlists.list('contentDetails, id, snippet, player', channelId: channelId, pageToken: nextPageToken);
  }
  @override
  Future<SearchListResponse> getChannelVideos(String channelId, String nextPageToken) async {
    var youtubeApi = new YoutubeApi(client);
    return youtubeApi.search.list('snippet,id', channelId: channelId, pageToken: nextPageToken, maxResults: 10, order: 'date');
  }

  @override
  Future<ChannelListResponse> getChannel(String channelId) async {
    var youtubeApi = new YoutubeApi(client);
    return youtubeApi.channels.list('brandingSettings, snippet, statistics', id: channelId, pageToken: '');
  }

  @override
  Future<VideoListResponse> getVideoListResponseAsync(String videoIds) async {
    var youtubeApi = new YoutubeApi(client);
    return youtubeApi.videos.list('snippet, statistics', id: videoIds);
  }
  
  @override
  void launchYoutubeVideo(String videoId) async {
    FlutterYoutube.playYoutubeVideoById(
      apiKey: UIData.youtubeApiKey,
      videoId: videoId,
    );
  }
}
