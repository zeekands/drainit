// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:photo_view/photo_view.dart';

List<double> geoToLatlong(String string) {
  final String substring = string.substring(34, string.length - 2);
  final List<String> latlong = substring.split(',');
  return [
    double.parse(latlong[1]),
    double.parse(
      latlong[0],
    ),
  ];
}

Future<void> getImage(
  ImageSource imageSource,
  RxString selectedImagePath,
  RxString selectedImageSize,
  RxString cropImagePath,
  RxString cropImageSize,
  RxString bytes64Image,
) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          '${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';

      // Crop
      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: selectedImagePath.value,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 512,
        maxHeight: 512,
      );
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          '${(File(cropImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';
      final _bytes = File(cropImagePath.value).readAsBytesSync();
      bytes64Image.value = base64Encode(_bytes);
    } else {
      showErrorSnackBar("Gagal mengambil gambar!");
    }
  } catch (e) {
    showErrorSnackBar("Terjadi kesalahan saat mengambil gambar!");
  }
}

Future<void> openFilePickerImage(
  RxString selectedImagePath,
  RxString bytes64Image,
) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpeg'],
  );

  if (result != null) {
    final File file = File(result.files.single.path.toString());
    selectedImagePath.value = file.path;
    final _bytes = File(selectedImagePath.value).readAsBytesSync();
    bytes64Image.value = base64Encode(_bytes);
  } else {
    // User canceled the picker
    return;
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case "NOT_YET_VERIFIED":
      return primary;
    case "ON_PROGRESS":
      return Colors.purple.shade300;
    case "REFUSED":
      return Colors.red.shade300;
    case "DONE":
      return Colors.green.shade300;
    case "BANJIR":
      return Colors.blue.shade300;
    case "DRAINASE RUSAK":
      return Colors.brown.shade300;
    default:
      return Colors.grey.shade300;
  }
}

Container appBarGradient() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primary,
            white,
          ],
        ),
      ),
    );

Future<LatLng> getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
    await getPosition();
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted) {
      throw 'No GPS permissions';
    }
    await getPosition();
  }
  final LocationData data = await location.getLocation();
  return LatLng(data.latitude!, data.longitude!);
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foto Laporan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
        ),
      ),
    );
  }
}

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
  final DateTime reportDate = DateTime.parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(reportDate);

  if (difference.inDays > 60) {
    return '2 months ago';
  }
  if (difference.inDays > 30) {
    return '1 month ago';
  }
  if (difference.inDays > 21) {
    return '4 weeks ago';
  }
  if (difference.inDays > 15) {
    return '3 weeks ago';
  }
  if (difference.inDays > 8) {
    return '2 weeks ago';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return numericDates ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return numericDates ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return numericDates ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return numericDates ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}

String imagePath() =>
    "https://gis-drainase.pocari.id/storage/app/public/images/";

void showErrorSnackBar(String error) {
  Get.snackbar(
    'Error',
    error,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showSuccessSnackBar(String body) {
  Get.snackbar(
    'Berhasil',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showInfoSnackBar(String body) {
  Get.snackbar(
    'Info',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showWarningSnackBar(String body) {
  Get.snackbar(
    'Warning',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.orange,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showConfirmDialog(
  String title,
  String body,
  Function() onConfirm,
  Function() onCancel, {
  String confirmText = 'Ya',
  String cancelText = 'Tidak',
}) {
  Get.dialog(
    AlertDialog(
      title: TextPoppinsBold(
        text: title,
        fontSize: 16,
      ),
      content: TextPoppinsRegular(
        text: body,
        fontSize: 14,
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: TextPoppinsBold(
            text: cancelText,
            fontSize: 16,
          ),
        ),
        FlatButton(
          onPressed: () {
            Get.back();
            onConfirm();
          },
          child: TextPoppinsBold(
            text: confirmText,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

extension ExtendedDouble on double {
  Widget get sizedHeight => SizedBox(
        height: this,
      );
  Widget get sizedWidget => SizedBox(
        width: this,
      );
}

const String mapStyles = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
