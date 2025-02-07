// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
    final Info? info;
    final List<ResultLocation>? results;

    Location({
        this.info,
        this.results,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<ResultLocation>.from(json["results"]!.map((x) => ResultLocation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Info {
    final int? count;
    final int? pages;
    final String? next;
    final dynamic prev;

    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class ResultLocation {
    final int? id;
    final String? name;
    final String? type;
    final String? dimension;
    final List<String>? residents;
    final String? url;
    final DateTime? created;

    ResultLocation({
        this.id,
        this.name,
        this.type,
        this.dimension,
        this.residents,
        this.url,
        this.created,
    });

    factory ResultLocation.fromJson(Map<String, dynamic> json) => ResultLocation(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null ? [] : List<String>.from(json["residents"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents == null ? [] : List<dynamic>.from(residents!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}
