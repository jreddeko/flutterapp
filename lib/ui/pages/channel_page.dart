import 'package:flutter/material.dart';
import 'package:card_example/services/youtube/i_youtube_service.dart';
import 'package:card_example/di/dependancy_injection.dart';
import 'package:googleapis/youtube/v3.dart';

class ChannelPage extends StatefulWidget {
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  Channel _channel;
  ScrollController _scrollController = new ScrollController();
  final IYoutubeService _youtubeService = new Injector().youtubeService;
  String _nextPageToken;

  @override
  void initState() {
    super.initState();
    _channel = new Channel();
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
    ChannelListResponse response = await _youtubeService.getChannel(_nextPageToken);
    setState(() {
      _channel = response.items[0];
      _nextPageToken = response.nextPageToken;
    });
  }

Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));

    setState(() {
      _nextPageToken = '';
      _channel = new Channel();
      _getData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(_channel.brandingSettings.image.bannerMobileImageUrl),
      ]),
      onRefresh: _handleRefresh,
    );
  }

}