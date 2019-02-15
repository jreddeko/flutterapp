import 'package:flutter/material.dart';
import 'package:nghe_phap/services/youtube/i_youtube_service.dart';
import 'package:nghe_phap/di/dependancy_injection.dart';

class VideoTile extends StatelessWidget {
  final String _title;
  final String _imageUrl;
  final String _uploadedDate;
  final String _views;
  final String _videoId;
  final String _channelTitle;
  final IYoutubeService _youtubeService = new Injector().youtubeService;

  VideoTile(this._title, this._imageUrl, this._uploadedDate, this._views,
      this._videoId, this._channelTitle);

  @override
  Widget build(BuildContext context) {
    Widget rowSection = Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: new Row(      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 8.0),
              child: Image.network(_imageUrl, fit: BoxFit.contain)
            )
          ],
        )),
        Expanded(
          flex: 4,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom:8.0),
                child: Text(
                  _title,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  _channelTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: new TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '$_uploadedDate - $_views',
                  softWrap: true,
                  style: new TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ],
          )),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: const Icon(Icons.more_vert),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          )
          ],
    ));

    return 
      new InkResponse(
        child: GridTile(
        child: rowSection,
      )
    , onTap: () => _youtubeService.launchYoutubeVideo(_videoId)
    );
  }
}