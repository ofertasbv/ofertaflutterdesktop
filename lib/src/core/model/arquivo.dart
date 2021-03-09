
class Arquivo {
  int id;
  String foto;

  Arquivo({this.id, this.foto});

  Arquivo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto'] = this.foto;
    return data;
  }
}