import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    var selectedFilter = controller.selectedFilter.value;
    return Scaffold(
      appBar: AppBar(
        title: TextBold(
          text: "Riwayat Laporan",
          fontSize: ScreenUtil().setSp(25),
          textColour: black,
        ),
        elevation: 0,
        backgroundColor: white,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => controller.getHistory(),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => showSearch(
                        context: context,
                        delegate: HistorySearchDelegate(controller),
                      ),
                      child: Container(
                        width: 0.6.sw,
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cari",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(Icons.search),
                          ],
                        ).paddingAll(10.r),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(50),
                      width: 0.15.sw,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(15),
                        ),
                      ),
                      child: Center(
                        child: PopupMenuButton(
                          icon: const Icon(Icons.sort_outlined, color: black),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          onSelected: (value) {
                            if (value == "semua") {
                              selectedFilter = "semua";
                              controller.sortHistory(value.toString());
                            } else if (value == "terbaru") {
                              selectedFilter = "terbaru";

                              controller.sortHistory(value.toString());
                            } else if (value == "terlama") {
                              selectedFilter = "terlama";

                              controller.sortHistory(value.toString());
                            } else if (value == "status") {
                              selectedFilter = "status";

                              controller.sortHistory(value.toString());
                            } else if (value == "jenis") {
                              selectedFilter = "jenis";
                              controller.sortHistory(value.toString());
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'semua',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color:
                                      selectedFilter == "semua" ? green : white,
                                ),
                                child: Text(
                                  'Semua',
                                  style: TextStyle(
                                    color: selectedFilter == "semua"
                                        ? white
                                        : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'terbaru',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color: selectedFilter == "terbaru"
                                      ? green
                                      : white,
                                ),
                                child: Text(
                                  'Terbaru',
                                  style: TextStyle(
                                    color: selectedFilter == "terbaru"
                                        ? white
                                        : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'terlama',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color: selectedFilter == "terlama"
                                      ? green
                                      : white,
                                ),
                                child: Text(
                                  'Terlama',
                                  style: TextStyle(
                                    color: selectedFilter == "terlama"
                                        ? white
                                        : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'status',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color: selectedFilter == "status"
                                      ? green
                                      : white,
                                ),
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    color: selectedFilter == "status"
                                        ? white
                                        : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'jenis',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color:
                                      selectedFilter == "jenis" ? green : white,
                                ),
                                child: Text(
                                  'Jenis',
                                  style: TextStyle(
                                    color: selectedFilter == "jenis"
                                        ? white
                                        : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(50),
                      width: 0.15.sw,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(15),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,
                Divider(
                  height: 1.h,
                  color: Colors.grey[500],
                ),
                15.verticalSpace,
              ],
            ).paddingAll(10.r),
            Flexible(
              child: FutureBuilder<List<HistoryModel>>(
                future: controller.getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextSemiBold(
                              text: "${snapshot.data!.length} laporan",
                              fontSize: 18.sp,
                              textColour: black,
                            ),
                            Row(
                              children: [
                                Icon(Icons.sort_outlined,
                                    size: 15.sp, color: Colors.grey[500]),
                                10.horizontalSpace,
                                TextSemiBold(
                                  text: "Urutkan: ",
                                  fontSize: 15.sp,
                                  textColour: Colors.grey[500],
                                ),
                                TextSemiBold(
                                  text: "Semua",
                                  fontSize: 15.sp,
                                  textColour: black,
                                )
                              ],
                            ),
                          ],
                        ).paddingOnly(left: 20.r, right: 20.r),
                        Flexible(
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: CachedNetworkImage(
                                          imageUrl: Routes.IMAGEURL +
                                              snapshot.data![index].foto!,
                                          width: 1.sw,
                                          height: 1.sw / 2,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.r,
                                          vertical: 5.r,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.r),
                                          ),
                                          color: getStatusColor(
                                            snapshot
                                                .data![index].statusPengaduan!,
                                          ),
                                        ),
                                        width: 100.w,
                                        height: 30.h,
                                        child: FittedBox(
                                          child: Text(
                                            snapshot
                                                .data![index].statusPengaduan!,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                      ).paddingOnly(left: 20.w, top: 20.h),
                                    ],
                                  ).marginOnly(bottom: 10.r),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextBold(
                                            text: snapshot.data![index]
                                                    .tipePengaduan ??
                                                "no data",
                                            fontSize: 18.sp,
                                          ),
                                          Text(
                                            timeAgoSinceDate(snapshot
                                                .data![index].createdAt!),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(left: 10.w, right: 10.w),
                                      10.verticalSpace,
                                      TextSemiBold(
                                        text: snapshot.data![index].namaJalan!
                                                .split(",")[0] ??
                                            "no data",
                                        textColour: Colors.grey,
                                      ).paddingOnly(left: 10.w, right: 10.w),
                                      10.verticalSpace,
                                      Row(
                                        children: [
                                          RoundedButton(
                                            text: "Lihat Detail",
                                            textColor: black,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                            press: () {
                                              Get.toNamed(
                                                Routes.DETAIL,
                                                arguments:
                                                    snapshot.data![index].id,
                                              );
                                            },
                                            height: 50.h,
                                            width: 0.7.sw,
                                            borderRadius: 10.r,
                                          ),
                                          10.horizontalSpace,
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: Colors.amberAccent,
                                            ),
                                            height: 50.h,
                                            width: 0.2.sw,
                                            child: Center(
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.map_outlined,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  await MapsLauncher
                                                      .launchCoordinates(
                                                          37.4220041,
                                                          -122.0862462);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      20.verticalSpace,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ).paddingAll(15.r),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return GestureDetector(
                      onTap: () => controller.getHistory(),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/il_no_internet.svg',
                              height: Get.height / 3,
                              width: Get.width / 3,
                            ),
                            SizedBox(height: 20.h),
                            TextBold(
                              text: "Tidak dapat menjangkau internet",
                              fontSize: 16.sp,
                              textColour: black,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            TextRegular(
                              text: "Ketuk untuk mencoba lagi!",
                              fontSize: 12.sp,
                              textColour: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 300.h,
                        width: 300.w,
                        child: Lottie.asset(
                          "assets/lottie/loading_animation.json",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildHistoryList extends StatelessWidget {
  const BuildHistoryList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.foundList.value.length,
      itemBuilder: (context, index) => controller.foundList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 10.r,
              ),
              isThreeLine: true,
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: controller.foundList.value[index].id,
                );
              },
              title: Text(
                " ${controller.foundList.value[index].namaJalan!}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ).paddingAll(5.r),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: controller
                                      .foundList.value[index].tipePengaduan! ==
                                  "Banjir"
                              ? Colors.lightBlue
                              : Colors.brown,
                        ),
                        child: Text(
                          controller.foundList.value[index].tipePengaduan!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: white,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.foundList.value[index].statusPengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.foundList.value[index].statusPengaduan!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Text(
                    timeAgoSinceDate(
                        controller.foundList.value[index].createdAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
              trailing: Image(
                image: CachedNetworkImageProvider(
                    Routes.IMAGEURL + controller.foundList.value[index].foto!),
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            )
          : Center(
              child: Text(
                "Tidak ada laporan yang ditemukan",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}

class BuildSortedHistoryList extends StatelessWidget {
  const BuildSortedHistoryList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.sortedList.value.length,
      itemBuilder: (context, index) => controller.sortedList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 10.r,
              ),
              isThreeLine: true,
              onTap: () {
                Get.offNamed(Routes.DETAIL,
                    arguments: controller.sortedList.value[index].id);
              },
              title: TextBold(
                text: " ${controller.sortedList.value[index].namaJalan!}",
              ).paddingAll(5.r),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        alignment: Alignment.center,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.sortedList.value[index].tipePengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.sortedList.value[index].tipePengaduan!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: white,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        alignment: Alignment.center,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.sortedList.value[index].statusPengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.sortedList.value[index].statusPengaduan!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: Routes.IMAGEURL +
                          controller.sortedList.value[index].foto!,
                      fit: BoxFit.cover,
                      width: 1.sw,
                      height: 1.sw / 2,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator.adaptive(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    timeAgoSinceDate(
                        controller.sortedList.value[index].createdAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
            )
          : Center(
              child: Text(
                "Tidak ada laporan yang ditemukan",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}
