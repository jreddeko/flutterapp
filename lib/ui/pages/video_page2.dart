import 'package:flutter/material.dart';
import 'package:card_example/services/youtube/i_youtube_service.dart';
import 'package:card_example/di/dependancy_injection.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:card_example/ui/widgets/video_tile.dart';
import 'package:card_example/utils/uidata.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoPage2 extends StatefulWidget {
  _VideoPageState2 createState() => _VideoPageState2();
}

class _VideoPageState2 extends State<VideoPage2> {
  List<Video> _items;
  ScrollController _scrollController = new ScrollController();
  String _nextPageToken;

  final IYoutubeService _youtubeService = new Injector().youtubeService;

  @override
  void initState() {
    super.initState();
    _items = new List<Video>();
    _getData();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _getData() async {
    SearchListResponse response = await _youtubeService.getChannelVideos(
        UIData.youtubeChannel1Key, _nextPageToken);
    var videoIdList = response.items.map((item) => item.id.videoId);
    var videoIds = videoIdList.reduce((value, item) => value + "," + item);
    var response2 = await _youtubeService.getVideoListResponseAsync(videoIds);
    setState(() {
      _items.addAll(response2.items);
      _nextPageToken = response.nextPageToken;
    });
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));

    setState(() {
      _nextPageToken = '';
      _items = new List<Video>();
      _getData();
    });

    return null;
  }

  Future<Channel> _loadChannelBrandingInformation() async {
    var channelListReponse =
        await _youtubeService.getChannel(UIData.youtubeChannel1Key);
    return channelListReponse.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: Column(
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.white54),
              )),
              child: SizedBox(
                  height: 190,
                  child: FutureBuilder(
                      future: _loadChannelBrandingInformation(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Channel> channel) {
                        if (channel.hasData) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Material(color: Colors.black),
                              Positioned(
                                top: 0,
                                left: 0,
                                height: 100,
                                child: Image.network(channel.data
                                    .brandingSettings.image.bannerImageUrl),
                              ),
                              Positioned(
                                top: 75,
                                left: 20,
                                child: new Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(channel
                                                .data
                                                .snippet
                                                .thumbnails
                                                .default_
                                                .url)))),
                              ),
                              Positioned(
                                top: 130,
                                left: 20,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  channel.data.snippet.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Positioned(
                                top: 160,
                                left: 20,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  channel.data.statistics.videoCount +
                                      ' videos',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return new Container();
                        }
                      }))),
          Flexible(
              child: Container(
                  child: Column(children: <Widget>[
            Expanded(
                child: GridView.builder(
              controller: _scrollController,
              itemCount: _items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.6,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: (context, i) {
                return new VideoTile(
                    _items[i].snippet.title,
                    _items[i].snippet.thumbnails.medium.url,
                    timeago.format(_items[i].snippet.publishedAt.toLocal()),
                    _items[i].statistics.viewCount + ' views',
                    _items[i].id,
                    _items[i].snippet.title);
              },
            ))
          ])))
        ],
      ),
      onRefresh: _handleRefresh,
    );
  }
}
