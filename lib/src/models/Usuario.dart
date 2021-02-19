import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.idUser,
    this.idPadreUser,
    this.nicUsuario,
    this.claveUser,
    this.nombreUser,
    this.correoUser,
    this.celularUser,
    this.activoUser,
    this.perfilUser,
    this.postUser,
    this.sidUser,
    this.correoVerficadoUser,
    this.celudarVerificadoUser,
    this.createdAt,
    this.createdBy,
    this.modifiedAt,
    this.modifiedBy,
    this.deletedAt,
    this.deletedBy,
  });

  int idUser;
  int idPadreUser;
  String nicUsuario;
  String claveUser;
  String nombreUser;
  String correoUser;
  String celularUser;
  String activoUser;
  String perfilUser;
  String postUser;
  String sidUser;
  String correoVerficadoUser;
  String celudarVerificadoUser;
  DateTime createdAt;
  int createdBy;
  DateTime modifiedAt;
  int modifiedBy;
  DateTime deletedAt;
  int deletedBy;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUser: json["idUser"],
        idPadreUser: json["idPadreUser"],
        nicUsuario: json["nicUsuario"],
        claveUser: json["claveUser"],
        nombreUser: json["nombreUser"],
        correoUser: json["correoUser"],
        celularUser: json["celularUser"],
        activoUser: json["activoUser"],
        perfilUser: json["perfilUser"],
        postUser: json["postUser"],
        sidUser: json["sidUser"],
        correoVerficadoUser: json["correoVerficadoUser"],
        celudarVerificadoUser: json["celudarVerificadoUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
        deletedAt: DateTime.parse(json["deletedAt"]),
        deletedBy: json["deletedBy"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "idPadreUser": idPadreUser,
        "nicUsuario": nicUsuario,
        "claveUser": claveUser,
        "nombreUser": nombreUser,
        "correoUser": correoUser,
        "celularUser": celularUser,
        "activoUser": activoUser,
        "perfilUser": perfilUser,
        "postUser": postUser,
        "sidUser": sidUser,
        "correoVerficadoUser": correoVerficadoUser,
        "celudarVerificadoUser": celudarVerificadoUser,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "modifiedAt": modifiedAt.toIso8601String(),
        "modifiedBy": modifiedBy,
        "deletedAt": deletedAt.toIso8601String(),
        "deletedBy": deletedBy,
      };
}
