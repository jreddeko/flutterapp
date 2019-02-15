class YoutubeResponse {
  String kind;
  String etag;
  String nextPageToken;
  String regionCode;
  PageInfo pageInfo;
  List<YoutubeSearchResultItem> items;

  YoutubeResponse(this.kind, this.etag, this.nextPageToken, this.regionCode, this.pageInfo, this.items);

  YoutubeResponse.fromJson(Map<String, dynamic> json) {   
    this.kind = json['kind'];
    this.etag = json['etag'];
    this.nextPageToken = json['nextPageToken'];
    this.regionCode = json['regionCode'];
    this.pageInfo = new PageInfo.fromJson(json['pageInfo']);
    this.items = new List<YoutubeSearchResultItem>();
    (json['items'] as List).forEach((i) {
        if (i['kind'] == 'youtube#searchResult')
          this.items.add(new YoutubeSearchResultItem.fromJson(i));
      }
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'kind': kind,
      'etag': etag,
      'nextPageToken': nextPageToken,
      'regionCode': regionCode,
      'items': items,
    };
}

class PageInfo {
  final int totalResults;
  final int resultsPerPage;

  PageInfo(this.totalResults, this.resultsPerPage);

  PageInfo.fromJson(Map<String, dynamic> json)
      : totalResults = json['totalResults'],
        resultsPerPage = json['resultsPerPage'];

  Map<String, dynamic> toJson() =>
    {
      'totalResults': totalResults,
      'resultsPerPage': resultsPerPage,
    };
}
class YoutubeItem {
  String kind;
  String etag;

}
class YoutubeSearchResultItem extends YoutubeItem {
  Id id;
  Snippet snippet;

  YoutubeSearchResultItem(kind, etag, this.id, this.snippet) {
    this.kind = kind;
    this.etag = etag;
  }

  YoutubeSearchResultItem.fromJson(Map<String, dynamic> json) {
    this.kind = json['kind'];
    this.etag = json['etag'];
    this.id = new Id.fromJson(json['id']);
    this.snippet = new Snippet.fromJson(json['snippet']);
  }

  Map<String, dynamic> toJson() =>
    {
      'kind': kind,
      'etag': etag,
      'id': id,
      'snippet': snippet,
    };
}
class Snippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String liveBroadcastContent;

  Snippet(this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent);

  Snippet.fromJson(Map<String, dynamic> json) {
    this.publishedAt = json['publishedAt'];
    this.channelId = json['channelId'];
    this.title = json['title'];
    this.description = json['description'];
    this.thumbnails = new Thumbnails.fromJson(json['thumbnails']);
    this.channelTitle = json['channelTitle'];
    this.liveBroadcastContent = json['liveBroadcastContent'];
  }

  Map<String, dynamic> toJson() =>
    {
      'publishedAt': publishedAt,
      'channelId': channelId,
      'title': title,
      'description': description,
      'thumbnails': thumbnails,
      'channelTitle': channelTitle,
      'liveBroadcastContent': liveBroadcastContent,
    };
}

class Thumbnails {
  final Thumbnail defaultThumbnail;
  final Thumbnail mediumThumbnail;
  final Thumbnail highThumbnail;

  Thumbnails(this.defaultThumbnail, this.mediumThumbnail, this.highThumbnail);
  
  Thumbnails.fromJson(Map<String, dynamic> json)
    : defaultThumbnail = new Thumbnail.fromJson(json['default']),
    mediumThumbnail = new Thumbnail.fromJson(json['medium']),
    highThumbnail = new Thumbnail.fromJson(json['high']);

  Map<String, dynamic> toJson() =>
    {
      'default': defaultThumbnail,
      'medium': mediumThumbnail,
      'high': highThumbnail,
    };
}

class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail(this.url, this.width, this.height);
  
  Thumbnail.fromJson(Map<String, dynamic> json)
    : url = json['url'],
    width = json['width'],
    height = json['height'];

  Map<String, dynamic> toJson() =>
    {
      'url': url,
      'width': width,
      'height': height,
    };

}
class Id {
  final String kind;
  final String videoId;

  Id(this.kind, this.videoId);

  Id.fromJson(Map<String, dynamic> json)
    : kind = json['kind'],
    videoId = json['videoId'];

  Map<String, dynamic> toJson() =>
    {
      'kind': kind,
      'videoId': videoId,
    };

}