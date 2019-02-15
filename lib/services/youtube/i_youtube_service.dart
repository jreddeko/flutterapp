import 'dart:async';
import 'package:googleapis/youtube/v3.dart';

abstract class IYoutubeService {
  Future<SearchListResponse> getChannelVideos(String channelId, String nextPageToken);
  Future<ChannelListResponse> getChannel(String channelId);
  Future<VideoListResponse> getVideoListResponseAsync(String videoIds);
  Future<PlaylistListResponse> getChannelPlaylists(String channelId, String nextPageToken);
  Future<PlaylistItemListResponse> getPlaylistItems(String playlistId, String nextPageToken);
  void launchYoutubeVideo(String videoId);
}
