// To parse this JSON data, do
//
//     final covid19Model = covid19ModelFromJson(jsonString);

import 'dart:convert';

class Covid19Model {
  Covid19Model({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.dailySummary,
    this.dailyTimeSeries,
    this.image,
    this.source,
    this.countries,
    this.countryDetail,
    this.lastUpdate,
  });

  Confirmed confirmed;
  Confirmed recovered;
  Confirmed deaths;
  String dailySummary;
  CountryDetail dailyTimeSeries;
  String image;
  String source;
  String countries;
  CountryDetail countryDetail;
  DateTime lastUpdate;

  Covid19Model loading({
    Confirmed confirmed,
    Confirmed recovered,
    Confirmed deaths,
    String dailySummary,
    CountryDetail dailyTimeSeries,
    String image,
    String source,
    String countries,
    CountryDetail countryDetail,
    DateTime lastUpdate,
  }) =>
      Covid19Model(
        confirmed: Confirmed().loading(),
        recovered: Confirmed().loading(),
        deaths: Confirmed().loading(),
        dailySummary: 'Loading...',
        dailyTimeSeries: CountryDetail().loading(),
        image: 'Loading...',
        source: 'Loading...',
        countries: 'Loading...',
        countryDetail: CountryDetail().loading(),
        lastUpdate: null,
      );

  Covid19Model copyWith({
    Confirmed confirmed,
    Confirmed recovered,
    Confirmed deaths,
    String dailySummary,
    CountryDetail dailyTimeSeries,
    String image,
    String source,
    String countries,
    CountryDetail countryDetail,
    DateTime lastUpdate,
  }) =>
      Covid19Model(
        confirmed: confirmed ?? this.confirmed,
        recovered: recovered ?? this.recovered,
        deaths: deaths ?? this.deaths,
        dailySummary: dailySummary ?? this.dailySummary,
        dailyTimeSeries: dailyTimeSeries ?? this.dailyTimeSeries,
        image: image ?? this.image,
        source: source ?? this.source,
        countries: countries ?? this.countries,
        countryDetail: countryDetail ?? this.countryDetail,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );

  factory Covid19Model.fromRawJson(String str) =>
      Covid19Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Covid19Model.fromJson(Map<String, dynamic> json) => Covid19Model(
        confirmed: json["confirmed"] == null
            ? null
            : Confirmed.fromJson(json["confirmed"]),
        recovered: json["recovered"] == null
            ? null
            : Confirmed.fromJson(json["recovered"]),
        deaths:
            json["deaths"] == null ? null : Confirmed.fromJson(json["deaths"]),
        dailySummary:
            json["dailySummary"] == null ? null : json["dailySummary"],
        dailyTimeSeries: json["dailyTimeSeries"] == null
            ? null
            : CountryDetail.fromJson(json["dailyTimeSeries"]),
        image: json["image"] == null ? null : json["image"],
        source: json["source"] == null ? null : json["source"],
        countries: json["countries"] == null ? null : json["countries"],
        countryDetail: json["countryDetail"] == null
            ? null
            : CountryDetail.fromJson(json["countryDetail"]),
        lastUpdate: json["lastUpdate"] == null
            ? null
            : DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed == null ? null : confirmed.toJson(),
        "recovered": recovered == null ? null : recovered.toJson(),
        "deaths": deaths == null ? null : deaths.toJson(),
        "dailySummary": dailySummary == null ? null : dailySummary,
        "dailyTimeSeries":
            dailyTimeSeries == null ? null : dailyTimeSeries.toJson(),
        "image": image == null ? null : image,
        "source": source == null ? null : source,
        "countries": countries == null ? null : countries,
        "countryDetail": countryDetail == null ? null : countryDetail.toJson(),
        "lastUpdate": lastUpdate == null ? null : lastUpdate.toIso8601String(),
      };
}

class Confirmed {
  Confirmed({
    this.value,
    this.detail,
  });

  int value;
  String detail;

  Confirmed loading({
    int value,
    String detail,
  }) =>
      Confirmed(
        value: 1,
        detail: 'Loading...',
      );

  Confirmed copyWith({
    int value,
    String detail,
  }) =>
      Confirmed(
        value: value ?? this.value,
        detail: detail ?? this.detail,
      );

  factory Confirmed.fromRawJson(String str) =>
      Confirmed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
        value: json["value"] == null ? null : json["value"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "detail": detail == null ? null : detail,
      };
}

class CountryDetail {
  CountryDetail({
    this.pattern,
    this.example,
  });

  String pattern;
  String example;

  CountryDetail loading({
    String pattern,
    String example,
  }) =>
      CountryDetail(
        pattern: 'Loading...',
        example: 'Loading...',
      );

  CountryDetail copyWith({
    String pattern,
    String example,
  }) =>
      CountryDetail(
        pattern: pattern ?? this.pattern,
        example: example ?? this.example,
      );

  factory CountryDetail.fromRawJson(String str) =>
      CountryDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryDetail.fromJson(Map<String, dynamic> json) => CountryDetail(
        pattern: json["pattern"] == null ? null : json["pattern"],
        example: json["example"] == null ? null : json["example"],
      );

  Map<String, dynamic> toJson() => {
        "pattern": pattern == null ? null : pattern,
        "example": example == null ? null : example,
      };
}
