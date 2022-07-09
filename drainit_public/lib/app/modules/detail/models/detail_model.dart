class Detail {
  String? id;
  String? idMasyarakat;
  String? namaPelapor;
  String? idAdmin;
  String? namaAdmin;
  String? namaJalan;
  String? foto;
  String? tipe;
  String? deskripsi;
  String? status;
  String? feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  List<Null>? petugas;
  int? upvote;
  int? downvote;

  Detail(
      {this.id,
      this.idMasyarakat,
      this.namaPelapor,
      this.idAdmin,
      this.namaAdmin,
      this.namaJalan,
      this.foto,
      this.tipe,
      this.deskripsi,
      this.status,
      this.feedbackMasyarakat,
      this.createdAt,
      this.updatedAt,
      this.geometry,
      this.petugas,
      this.upvote,
      this.downvote});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idMasyarakat = json['id_masyarakat'].toString();
    namaPelapor = json['nama_pelapor'].toString();
    idAdmin = json['id_admin'].toString();
    namaAdmin = json['nama_admin'].toString();
    namaJalan = json['nama_jalan'].toString();
    foto = json['foto'].toString();
    tipe = json['tipe'].toString();
    deskripsi = json['deskripsi'].toString();
    status = json['status'].toString();
    feedbackMasyarakat = json['feedback_masyarakat'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    geometry = json['geometry'].toString();
    if (json['petugas'] != null) {
      petugas = <Null>[];
      json['petugas'].forEach((v) {
        //petugas!.add(new Null.fromJson(v));
      });
    }
    upvote = json['upvote'] as int;
    downvote = json['downvote'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_masyarakat'] = this.idMasyarakat;
    data['nama_pelapor'] = this.namaPelapor;
    data['id_admin'] = this.idAdmin;
    data['nama_admin'] = this.namaAdmin;
    data['nama_jalan'] = this.namaJalan;
    data['foto'] = this.foto;
    data['tipe'] = this.tipe;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['feedback_masyarakat'] = this.feedbackMasyarakat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['geometry'] = this.geometry;
    if (this.petugas != null) {
      //data['petugas'] = this.petugas!.map((v) => v.toJson()).toList();
    }
    data['upvote'] = this.upvote;
    data['downvote'] = this.downvote;
    return data;
  }
}
