import 'dart:ffi';

class Restaurant {
  int? id;
  Attributes? attributes;

  Restaurant({this.id, this.attributes});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Restaurant.fromJsonRecommended(Map<String, dynamic> json) {
    id = json['id'];
    attributes =
        json['attributes'] != null && json['attributes']['recommended'] == true
            ? new Attributes.fromJson(json['attributes'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? name;
  String? email;
  int? phoneNumber;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  Item? item;
  RestaurantImage? restaurantImage;

  Attributes({
    this.name,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.item,
    this.restaurantImage,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    restaurantImage = json['Image'] != null
        ? new RestaurantImage.fromJson(json['Image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.restaurantImage != null) {
      data['Image'] = this.restaurantImage!.toJson();
    }
    return data;
  }
}

class Item {
  Null data;

  Item({this.data});

  Item.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}

class RestaurantImage {
  RestaurantImageData? data;

  RestaurantImage({this.data});

  RestaurantImage.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new RestaurantImageData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RestaurantImageData {
  int? id;
  ImageAttributes? attributes;

  RestaurantImageData({this.id, this.attributes});

  RestaurantImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new ImageAttributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class ImageAttributes {
  String? name;
  Null alternativeText;
  Null caption;
  int? width;
  int? height;
  Formats? formats;
  String? hash;
  String? ext;
  String? mime;
  String? url;
  Null previewUrl;
  String? provider;
  Null providerMetadata;
  String? createdAt;
  String? updatedAt;

  ImageAttributes({
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  ImageAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats =
        json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    providerMetadata = json['provider_metadata'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    if (this.formats != null) {
      data['formats'] = this.formats!.toJson();
    }
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    data['provider_metadata'] = this.providerMetadata;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Formats {
  Thumbnail? thumbnail;

  Formats({this.thumbnail});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String? name;
  String? hash;
  String? ext;
  String? mime;
  Null path;
  int? width;
  int? height;
  double? size;
  int? sizeInBytes;
  String? url;

  Thumbnail({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.path,
    this.width,
    this.height,
    this.size,
    this.sizeInBytes,
    this.url,
  });

  Thumbnail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    path = json['path'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    sizeInBytes = json['sizeInBytes'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['path'] = this.path;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['sizeInBytes'] = this.sizeInBytes;
    data['url'] = this.url;
    return data;
  }
}
