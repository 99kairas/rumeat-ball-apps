// To parse this JSON data, do
//
//     final detailPaymentResponse = detailPaymentResponseFromJson(jsonString);

import 'dart:convert';

DetailPaymentResponse detailPaymentResponseFromJson(String str) => DetailPaymentResponse.fromJson(json.decode(str));

String detailPaymentResponseToJson(DetailPaymentResponse data) => json.encode(data.toJson());

class DetailPaymentResponse {
    String message;
    DetailPayment data;

    DetailPaymentResponse({
        required this.message,
        required this.data,
    });

    factory DetailPaymentResponse.fromJson(Map<String, dynamic> json) => DetailPaymentResponse(
        message: json["message"],
        data: DetailPayment.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class DetailPayment {
    String idPembayaran;
    String idSpp;
    String noIndukSiswa;
    dynamic tanggalBayar;
    String jumlahBayar;
    String fotoPembayaran;
    int status;
    Siswa siswa;
    Spp spp;

    DetailPayment({
        required this.idPembayaran,
        required this.idSpp,
        required this.noIndukSiswa,
        this.tanggalBayar,
        required this.jumlahBayar,
        required this.fotoPembayaran,
        required this.status,
        required this.siswa,
        required this.spp,
    });

    factory DetailPayment.fromJson(Map<String, dynamic> json) => DetailPayment(
        idPembayaran: json["id_pembayaran"],
        idSpp: json["id_spp"],
        noIndukSiswa: json["no_induk_siswa"],
        tanggalBayar: json["tanggal_bayar"],
        jumlahBayar: json["jumlah_bayar"],
        fotoPembayaran: json["foto_pembayaran"],
        status: json["status"],
        siswa: Siswa.fromJson(json["siswa"]),
        spp: Spp.fromJson(json["spp"]),
    );

    Map<String, dynamic> toJson() => {
        "id_pembayaran": idPembayaran,
        "id_spp": idSpp,
        "no_induk_siswa": noIndukSiswa,
        "tanggal_bayar": tanggalBayar,
        "jumlah_bayar": jumlahBayar,
        "foto_pembayaran": fotoPembayaran,
        "status": status,
        "siswa": siswa.toJson(),
        "spp": spp.toJson(),
    };
}

class Siswa {
    String namaSiswa;
    String kelas;

    Siswa({
        required this.namaSiswa,
        required this.kelas,
    });

    factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        namaSiswa: json["nama_siswa"],
        kelas: json["kelas"],
    );

    Map<String, dynamic> toJson() => {
        "nama_siswa": namaSiswa,
        "kelas": kelas,
    };
}

class Spp {
    String tahun;
    String bulan;
    String jumlah;

    Spp({
        required this.tahun,
        required this.bulan,
        required this.jumlah,
    });

    factory Spp.fromJson(Map<String, dynamic> json) => Spp(
        tahun: json["tahun"],
        bulan: json["bulan"],
        jumlah: json["jumlah"],
    );

    Map<String, dynamic> toJson() => {
        "tahun": tahun,
        "bulan": bulan,
        "jumlah": jumlah,
    };
}
