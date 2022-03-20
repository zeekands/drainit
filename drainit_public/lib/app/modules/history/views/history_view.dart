import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text_poppins.dart';
import '../../../routes/app_pages.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildList() {
      final List<Widget> listItems = [];

      for (int i = 0; i < controller.list.length; i++) {
        final isBanjir = controller.list[i].tipePengaduan == 'banjir';
        listItems.add(
          GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.DETAIL,
                arguments: [controller.list[i].id, controller.list[i].geometry],
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image(
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            width: 100.w,
                            height: 100.h,
                            color: Colors.white,
                            child: Center(
                              child: TextPoppinsBold(
                                text: "cannot load image",
                                fontSize: 8.sp,
                              ),
                            ),
                          );
                        },
                        image: CachedNetworkImageProvider(Routes.IMAGEURL +
                            (controller.list[i].foto ??
                                "defaultpengaduan.png")),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextPoppinsBold(
                        text: controller.list[i].tipePengaduan.toString(),
                        fontSize: 14.sp,
                        textColour: Colors.black,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextPoppinsRegular(
                        text: controller.list[i].createdAt.toString(),
                        fontSize: 12.sp,
                        textColour: Colors.grey,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextPoppinsRegular(
                        text: "Jl. Bukitsari no.9a",
                        fontSize: 12.sp,
                        textColour: Colors.grey,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextPoppinsBold(
                        text: "${controller.list[i].statusPengaduan}",
                        fontSize: 12.sp,
                        textColour: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return listItems.isEmpty
          ? [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/svg/il_no_data.svg",
                        width: Get.width / 2,
                        height: Get.height / 2,
                      ),
                    ),
                    TextPoppinsBold(
                      text: "Tidak ada data laporan",
                      fontSize: 16.sp,
                      textColour: Colors.black,
                    ),
                  ],
                ),
              ),
            ]
          : listItems;
    }

    return ScreenUtilInit(
      designSize: designSize,
      builder: () => Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => RefreshIndicator(
            onRefresh: () {
              return controller.loadHistory();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: Size(Get.width, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPoppinsBold(
                              text: "Riwayat Laporan",
                              fontSize: 20.sp,
                              textColour: Colors.black,
                            ),
                            SizedBox(height: 10.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: .2,
                                      ),
                                    ),
                                    child: Center(
                                      child: TextPoppinsRegular(
                                        text: "Semua",
                                        fontSize: 9.sp,
                                        textColour: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Container(
                                      height: 25.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: .2,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextPoppinsRegular(
                                          text: "Laporan selesai",
                                          fontSize: 9.sp,
                                          textColour: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Container(
                                      height: 25.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: .2,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextPoppinsRegular(
                                          text: "Sedang diproses",
                                          fontSize: 9.sp,
                                          textColour: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Container(
                                      height: 25.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: .2,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextPoppinsRegular(
                                          text: "Laporan terbaru",
                                          fontSize: 9.sp,
                                          textColour: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Container(
                                      height: 25.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: .2,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextPoppinsRegular(
                                          text: "Laporan terlama",
                                          fontSize: 9.sp,
                                          textColour: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: ScreenUtil().setHeight(80),
                  collapsedHeight: ScreenUtil().setHeight(80),
                  backgroundColor: white,
                  // ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    _buildList(),
                  ),
                ),
              ],
            ),
          ),
          onLoading: Center(
            child: CupertinoActivityIndicator(
              radius: 20.w,
            ),
          ),
          onError: (err) => GestureDetector(
            onTap: () => controller.loadHistory(),
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
                  TextPoppinsBold(
                    text: "Tidak dapat menjangkau internet",
                    fontSize: 16.sp,
                    textColour: black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextPoppinsRegular(
                    text: "Ketuk untuk mencoba lagi!",
                    fontSize: 12.sp,
                    textColour: Colors.black38,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget historyItem(
    String foto,
    String status,
    String jenis,
    String lokasi,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.r, 10.r, 20.r, 10.r),
          child: SizedBox(
            width: 414.w,
            height: 150.h,
            child: Stack(
              children: [
                Container(
                  width: 414.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: kBackgroundInput,
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/Frame.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image(
                          width: 167.w,
                          height: 110.h,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) {
                            return SizedBox(
                              width: 167.w,
                            );
                          },
                          image: CachedNetworkImageProvider(imagePath() + foto),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jenis,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: kTextPurple,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              lokasi,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: kBackgroundInput,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}