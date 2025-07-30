// To parse this JSON data, do
//
//     final directionModel = directionModelFromJson(jsonString);

import 'dart:convert';

DirectionModel directionModelFromJson(String str) => DirectionModel.fromJson(json.decode(str));

String directionModelToJson(DirectionModel data) => json.encode(data.toJson());

class DirectionModel {
  List<double>? bbox;
  List<Route>? routes;
  Metadata? metadata;

  DirectionModel({
    this.bbox,
    this.routes,
    this.metadata,
  });

  factory DirectionModel.fromJson(Map<String, dynamic> json) => DirectionModel(
        bbox:
            json["bbox"] == null ? [] : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
        routes: json["routes"] == null
            ? []
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
        "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
        "metadata": metadata?.toJson(),
      };
}

class Metadata {
  String? attribution;
  String? service;
  double? timestamp;
  Query? query;
  Engine? engine;

  Metadata({
    this.attribution,
    this.service,
    this.timestamp,
    this.query,
    this.engine,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        attribution: json["attribution"],
        service: json["service"],
        timestamp: json["timestamp"]?.toDouble(),
        query: json["query"] == null ? null : Query.fromJson(json["query"]),
        engine: json["engine"] == null ? null : Engine.fromJson(json["engine"]),
      );

  Map<String, dynamic> toJson() => {
        "attribution": attribution,
        "service": service,
        "timestamp": timestamp,
        "query": query?.toJson(),
        "engine": engine?.toJson(),
      };
}

class Engine {
  String? version;
  DateTime? buildDate;
  DateTime? graphDate;
  DateTime? osmDate;

  Engine({
    this.version,
    this.buildDate,
    this.graphDate,
    this.osmDate,
  });

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        version: json["version"],
        buildDate: json["build_date"] == null ? null : DateTime.parse(json["build_date"]),
        graphDate: json["graph_date"] == null ? null : DateTime.parse(json["graph_date"]),
        osmDate: json["osm_date"] == null ? null : DateTime.parse(json["osm_date"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "build_date": buildDate?.toIso8601String(),
        "graph_date": graphDate?.toIso8601String(),
        "osm_date": osmDate?.toIso8601String(),
      };
}

class Query {
  List<List<double>>? coordinates;
  String? profile;
  String? profileName;
  String? format;

  Query({
    this.coordinates,
    this.profile,
    this.profileName,
    this.format,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        coordinates: json["coordinates"] == null
            ? []
            : List<List<double>>.from(
                json["coordinates"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        profile: json["profile"],
        profileName: json["profileName"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "profile": profile,
        "profileName": profileName,
        "format": format,
      };
}

class Route {
  RouteSummary? summary;
  List<Segment>? segments;
  List<double>? bbox;
  String? geometry;
  List<double>? wayPoints;
  List<Warning>? warnings;
  Extras? extras;

  Route({
    this.summary,
    this.segments,
    this.bbox,
    this.geometry,
    this.wayPoints,
    this.warnings,
    this.extras,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        summary: json["summary"] == null ? null : RouteSummary.fromJson(json["summary"]),
        segments: json["segments"] == null
            ? []
            : List<Segment>.from(json["segments"]!.map((x) => Segment.fromJson(x))),
        bbox:
            json["bbox"] == null ? [] : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
        geometry: json["geometry"],
        wayPoints: json["way_points"] == null
            ? []
            : List<double>.from(json["way_points"]!.map((x) => x?.toDouble())),
        warnings: json["warnings"] == null
            ? []
            : List<Warning>.from(json["warnings"]!.map((x) => Warning.fromJson(x))),
        extras: json["extras"] == null ? null : Extras.fromJson(json["extras"]),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary?.toJson(),
        "segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x.toJson())),
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
        "geometry": geometry,
        "way_points": wayPoints == null ? [] : List<dynamic>.from(wayPoints!.map((x) => x)),
        "warnings": warnings == null ? [] : List<dynamic>.from(warnings!.map((x) => x.toJson())),
        "extras": extras?.toJson(),
      };
}

class Extras {
  Roadaccessrestrictions? roadaccessrestrictions;

  Extras({
    this.roadaccessrestrictions,
  });

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        roadaccessrestrictions: json["roadaccessrestrictions"] == null
            ? null
            : Roadaccessrestrictions.fromJson(json["roadaccessrestrictions"]),
      );

  Map<String, dynamic> toJson() => {
        "roadaccessrestrictions": roadaccessrestrictions?.toJson(),
      };
}

class Roadaccessrestrictions {
  List<List<double>>? values;
  List<SummaryElement>? summary;

  Roadaccessrestrictions({
    this.values,
    this.summary,
  });

  factory Roadaccessrestrictions.fromJson(Map<String, dynamic> json) => Roadaccessrestrictions(
        values: json["values"] == null
            ? []
            : List<List<double>>.from(
                json["values"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        summary: json["summary"] == null
            ? []
            : List<SummaryElement>.from(json["summary"]!.map((x) => SummaryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "summary": summary == null ? [] : List<dynamic>.from(summary!.map((x) => x.toJson())),
      };
}

class SummaryElement {
  double? value;
  double? distance;
  double? amount;

  SummaryElement({
    this.value,
    this.distance,
    this.amount,
  });

  factory SummaryElement.fromJson(Map<String, dynamic> json) => SummaryElement(
        value: json["value"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "distance": distance,
        "amount": amount,
      };
}

class Segment {
  double? distance;
  double? duration;
  List<Step>? steps;

  Segment({
    this.distance,
    this.duration,
    this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}

class Step {
  double? distance;
  double? duration;
  double? type;
  String? instruction;
  String? name;
  List<double>? wayPoints;

  Step({
    this.distance,
    this.duration,
    this.type,
    this.instruction,
    this.name,
    this.wayPoints,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        type: json["type"]?.toDouble(),
        instruction: json["instruction"],
        name: json["name"],
        wayPoints: json["way_points"] == null
            ? []
            : List<double>.from(json["way_points"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
        "type": type,
        "instruction": instruction,
        "name": name,
        "way_points": wayPoints == null ? [] : List<dynamic>.from(wayPoints!.map((x) => x)),
      };
}

class RouteSummary {
  double? distance;
  double? duration;

  RouteSummary({
    this.distance,
    this.duration,
  });

  factory RouteSummary.fromJson(Map<String, dynamic> json) => RouteSummary(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
      };
}

class Warning {
  double? code;
  String? message;

  Warning({
    this.code,
    this.message,
  });

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        code: json["code"]?.toDouble(),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
