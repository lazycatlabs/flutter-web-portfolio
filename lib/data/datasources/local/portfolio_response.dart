class PortfolioResponse {
  PortfolioResponse({
    this.data,
  });

  PortfolioResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? data;

  PortfolioResponse copyWith({
    List<Data>? data,
  }) =>
      PortfolioResponse(
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.title,
    this.descriptions,
    this.images,
    this.playStore,
    this.appStore,
    this.tag,
    this.onClick = false,
    this.onHover = false,
    this.activeIndex = 0,
  });

  Data.fromJson(dynamic json) {
    title = json['title'] as String?;
    descriptions = json['descriptions'] as String?;
    images = json['images'] != null
        ? json['images'].cast<String>() as List<String>?
        : [];
    playStore = json['playStore'] as String?;
    appStore = json['appStore'] as String?;
    tag =
        json['tag'] != null ? json['tag'].cast<String>() as List<String>? : [];
  }

  String? title;
  String? descriptions;
  List<String>? images;
  String? playStore;
  String? appStore;
  List<String>? tag;
  bool onHover = false;
  bool onClick = false;
  int activeIndex = 0;

  Data copyWith({
    String? title,
    String? descriptions,
    List<String>? images,
    String? playStore,
    String? appStore,
    List<String>? tag,
  }) =>
      Data(
        title: title ?? this.title,
        descriptions: descriptions ?? this.descriptions,
        images: images ?? this.images,
        playStore: playStore ?? this.playStore,
        appStore: appStore ?? this.appStore,
        tag: tag ?? this.tag,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['descriptions'] = descriptions;
    map['images'] = images;
    map['playStore'] = playStore;
    map['appStore'] = appStore;
    map['tag'] = tag;
    return map;
  }
}
