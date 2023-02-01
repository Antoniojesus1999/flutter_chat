// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usuario {
  bool online;
  String email;
  String nombre;
  String uid;

  Usuario({
    required this.online,
    required this.email,
    required this.nombre,
    required this.uid,
  });

  Usuario copyWith({
    bool? online,
    String? email,
    String? nombre,
    String? uid,
  }) {
    return Usuario(
      online: online ?? this.online,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'online': online,
      'email': email,
      'nombre': nombre,
      'uid': uid,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      online: map['online'] as bool,
      email: map['email'] as String,
      nombre: map['nombre'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(online: $online, email: $email, nombre: $nombre, uid: $uid)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;

    return other.online == online &&
        other.email == email &&
        other.nombre == nombre &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return online.hashCode ^ email.hashCode ^ nombre.hashCode ^ uid.hashCode;
  }
}
