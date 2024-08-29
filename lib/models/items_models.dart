// Define the Item model
class ItemModel {
  final List<ItemData> data;
  final Meta meta;

  ItemModel({required this.data, required this.meta});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      data: List<ItemData>.from(
          json['data'].map((item) => ItemData.fromJson(item))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

// Define the ItemData model
class ItemData {
  final int id;
  final ItemAttributes attributes;

  ItemData({required this.id, required this.attributes});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      id: json['id'],
      attributes: ItemAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
    };
  }
}

// Define the ItemAttributes model
class ItemAttributes {
  final String name;
  final List<Description> description;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final Image1 image;
  final Restaurant1 restaurant;

  ItemAttributes({
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.image,
    required this.restaurant,
  });

  factory ItemAttributes.fromJson(Map<String, dynamic> json) {
    return ItemAttributes(
      name: json['Name'],
      description: json['Description'],
      price: json['Price'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      image: Image1.fromJson(json['Image']),
      restaurant: Restaurant1.fromJson(json['restaurant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Description': description.map((desc) => desc.toJson()).toList(),
      'Price': price,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'publishedAt': publishedAt.toIso8601String(),
      'Image': image.toJson(),
      'restaurant': restaurant.toJson(),
    };
  }
}

// Define the Description model
class Description {
  final String type;
  final List<DescriptionChildren> children;

  Description({required this.type, required this.children});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      type: json['type'],
      children: List<DescriptionChildren>.from(
          json['children'].map((child) => DescriptionChildren.fromJson(child))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }
}

// Define the DescriptionChildren model
class DescriptionChildren {
  final String type;
  final String text;

  DescriptionChildren({required this.type, required this.text});

  factory DescriptionChildren.fromJson(Map<String, dynamic> json) {
    return DescriptionChildren(
      type: json['type'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text,
    };
  }
}

// Define the Image model
class Image1 {
  final List<ImageData> data;

  Image1({required this.data});

  factory Image1.fromJson(Map<String, dynamic> json) {
    return Image1(
      data: List<ImageData>.from(
          json['data'].map((img) => ImageData.fromJson(img))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((img) => img.toJson()).toList(),
    };
  }
}

// Define the ImageData model
class ImageData {
  final int id;
  final ImageAttributes attributes;

  ImageData({required this.id, required this.attributes});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      attributes: ImageAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
    };
  }
}

// Define the ImageAttributes model
class ImageAttributes {
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final Map<String, ImageFormats> formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final String? providerMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageAttributes({
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageAttributes.fromJson(Map<String, dynamic> json) {
    return ImageAttributes(
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      formats: (json['formats'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(
                key,
                ImageFormats.fromJson(value),
              )),
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      size: json['size'],
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      providerMetadata: json['provider_metadata'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'alternativeText': alternativeText,
      'caption': caption,
      'width': width,
      'height': height,
      'formats': formats.map((key, value) => MapEntry(key, value.toJson())),
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'size': size,
      'url': url,
      'previewUrl': previewUrl,
      'provider': provider,
      'provider_metadata': providerMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// Define the ImageFormats model
class ImageFormats {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final String? path;
  final int width;
  final int height;
  final double size;
  final int sizeInBytes;
  final String url;

  ImageFormats({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    this.path,
    required this.width,
    required this.height,
    required this.size,
    required this.sizeInBytes,
    required this.url,
  });

  factory ImageFormats.fromJson(Map<String, dynamic> json) {
    return ImageFormats(
      name: json['name'],
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      path: json['path'],
      width: json['width'],
      height: json['height'],
      size: json['size'],
      sizeInBytes: json['sizeInBytes'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'path': path,
      'width': width,
      'height': height,
      'size': size,
      'sizeInBytes': sizeInBytes,
      'url': url,
    };
  }
}

// Define the Restaurant model
class Restaurant1 {
  final dynamic data;

  Restaurant1({required this.data});

  factory Restaurant1.fromJson(Map<String, dynamic> json) {
    return Restaurant1(
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}

// Define the Meta model
class Meta {
  final Pagination pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination.toJson(),
    };
  }
}

// Define the Pagination model
class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      pageSize: json['pageSize'],
      pageCount: json['pageCount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'pageCount': pageCount,
      'total': total,
    };
  }
}
