import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

Usuario usuarioCompletoFromJson(String str) => Usuario.infoCompleta(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.usuarioNic,
    this.usuarioContrasenia,
    this.usuarioNombre,
    this.usuarioCorreo,
    this.usuarioCelular,
  });

  Usuario.completo({
    this.idUser,
    this.idPadreUser,
    this.nicUsuario,
    this.claveUser,
    this.nombreUser,
    this.correoUser,
    this.celularUser,
    this.activoUser = '1',
    this.perfilUser = '',
    this.postUser = '',
    this.sidUser = '',
    this.correoVerficadoUser = '',
    this.celudarVerificadoUser = '',
  });

  int idUser;
  dynamic idPadreUser;
  String nicUsuario;
  String claveUser;
  String nombreUser;
  String correoUser;
  String celularUser;
  dynamic activoUser;
  dynamic perfilUser;
  dynamic postUser;
  dynamic sidUser;
  dynamic correoVerficadoUser;
  dynamic celudarVerificadoUser;

  //campos para crear usuario administrador
  String usuarioNic;
  String usuarioContrasenia;
  String usuarioNombre;
  String usuarioCorreo;
  String usuarioCelular;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuarioNic: json["usuario_nic"],
        usuarioContrasenia: json["usuario_contrasenia"],
        usuarioNombre: json["usuario_nombre"],
        usuarioCorreo: json["usuario_correo"],
        usuarioCelular: json["usuario_celular"],
      );

  Map<String, dynamic> toJson() => {
        "usuario_nic": usuarioNic,
        "usuario_contrasenia": usuarioContrasenia,
        "usuario_nombre": usuarioNombre,
        "usuario_correo": usuarioCorreo,
        "usuario_celular": usuarioCelular,
      };

  factory Usuario.infoCompleta(Map<String, dynamic> json) => Usuario.completo(
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
      );
}
