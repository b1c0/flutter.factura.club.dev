import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.usuarioNic,
    this.usuarioContrasenia,
    this.usuarioNombre,
    this.usuarioCorreo,
    this.usuarioCelular,
  });

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
}

// "usuario_nic": "test2",
// "usuario_contrasenia": "123456",
// "usuario_nombre": "test2",
// "usuario_correo": "test@test.com",
// "usuario_celular": "0987654321"
