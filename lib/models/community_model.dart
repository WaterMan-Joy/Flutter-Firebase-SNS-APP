// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Community {
  final String id;
  final String name;
  final String bannder;
  final String avater;
  final List<String> members;
  final List<String> mods;
  Community({
    required this.id,
    required this.name,
    required this.bannder,
    required this.avater,
    required this.members,
    required this.mods,
  });

  Community copyWith({
    String? id,
    String? name,
    String? bannder,
    String? avater,
    List<String>? members,
    List<String>? mods,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      bannder: bannder ?? this.bannder,
      avater: avater ?? this.avater,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bannder': bannder,
      'avater': avater,
      'members': members,
      'mods': mods,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      bannder: map['bannder'] ?? '',
      avater: map['avater'] ?? '',
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Community(id: $id, name: $name, bannder: $bannder, avater: $avater, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(covariant Community other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.bannder == bannder &&
        other.avater == avater &&
        listEquals(other.members, members) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        bannder.hashCode ^
        avater.hashCode ^
        members.hashCode ^
        mods.hashCode;
  }
}
