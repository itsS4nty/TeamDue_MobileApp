class Usuario {
  late int id;
  late String nombre;
  late String apellido1;
  late String apellido2;
  late String correo;
  late String usuario;
  late String password;
  late DateTime fechaRegistro;
  late bool premium;
  late bool validado;
  late String token;

  Usuario(id, nombre, apellido1, apellido2, correo, usuario, password,
      fechaRegistro, premium, validado, token) {
    this.id = id;
    this.nombre = nombre;
    this.apellido1 = apellido1;
    this.apellido2 = apellido2;
    this.correo = correo;
    this.usuario = usuario;
    this.password = password;
    this.fechaRegistro = fechaRegistro;
    this.premium = premium;
    this.validado = validado;
    this.token = token;
  }
}
