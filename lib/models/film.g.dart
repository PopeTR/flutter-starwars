// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Film _$FilmFromJson(Map<String, dynamic> json) => Film(
      title: json['title'] as String,
      releaseDate: json['release_date'] as String?,
      openingCrawl: json['opening_crawl'] as String?,
      episodeId: json['episode_id'] as num?,
    );

Map<String, dynamic> _$FilmToJson(Film instance) => <String, dynamic>{
      'title': instance.title,
      'release_date': instance.releaseDate,
      'opening_crawl': instance.openingCrawl,
      'episode_id': instance.episodeId,
    };
