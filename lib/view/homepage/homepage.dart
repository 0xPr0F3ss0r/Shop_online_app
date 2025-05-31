import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/homecontroller.dart';
import 'package:live_app/controller/profilepagecontroller.dart';
import 'package:live_app/view/profile/profile.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController profileController = Get.put(ProfilePageController());
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              controller.onExit(context);
            },
            icon: const Icon(
              size: 30,
              Icons.exit_to_app_outlined,
              color: Colors.red,
            ),
          ),
        ],
        title: _buildAppBarTitle(controller, profileController),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          if (profileController.type == "seller") {
            if (controller.isLive.value) {
              controller.stopLiveStream();
            } else {
              controller.startLiveStream();
            }
          } else {
            Get.snackbar(
              "Info",
              "Sorry, this option is allowed just for the seller. You should be a seller to use it.",
              colorText: Colors.red[200],
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: const Icon(Icons.videocam,
            color: const Color.fromARGB(255, 44, 42, 42)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.listenToLiveUpdates();
          await controller.fetchLiveStream();
          controller.checkLiveFollower();
          await controller.GetNumberOfFollowers();
        },
        child: controller.ListLiveStream.isEmpty
            ? Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Lottie.asset("assets/images/nolive.json",
                          height: 200),
                    )))
            : Padding(
                padding: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: controller.fetchLiveStream(),
                  builder: (context, snapshot) => ListView.builder(
                    itemCount: controller.ListLiveStream.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListItem(
                          controller, profileController, index, snapshot);
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildAppBarTitle(
      HomeController controller, ProfilePageController profileController) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProfilePage());
                  },
                  child: ClipOval(
                    child: profileController.Image != null &&
                            profileController.Image!.isNotEmpty
                        ? (profileController.Image!.startsWith('http')
                            ? Image.network(
                                profileController.Image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, size: 20),
                              )
                            : (() {
                                final file = File(profileController.Image!);
                                return file.existsSync()
                                    ? Image.file(file, fit: BoxFit.cover)
                                    : Icon(Icons.error, size: 20);
                              })())
                        : Image.network(
                            "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.to(ProfilePage());
                  },
                  child: Text(
                    controller.firstname ?? "name not found",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      HomeController controller,
      ProfilePageController profileController,
      int index,
      AsyncSnapshot<void> snapshot) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                controller
                    .joinLiveStream(controller.ListLiveStream[index]['Liveid']);
              },
              child: controller.ListLiveStream.length >= 1
                  ? Container(
                      height: 650,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          controller.ListLiveStream[index]['avatar'] != null &&
                                  controller.ListLiveStream[index]['avatar']
                                      .isNotEmpty
                              ? (controller.ListLiveStream[index]['avatar']
                                      .startsWith('http')
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        controller.ListLiveStream[index]
                                            ['avatar'],
                                        fit: BoxFit.fitHeight,
                                        height: 800,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.error, size: 20),
                                      ),
                                    )
                                  : (() {
                                      final file = File(controller
                                          .ListLiveStream[index]['avatar']);
                                      return file.existsSync()
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.file(file,
                                                  fit: BoxFit.fill))
                                          : const Icon(Icons.error, size: 20);
                                    })())
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          Positioned(
                            child: Obx(
                              () => controller.isLive.value
                                  ? Center(
                                      child: Lottie.asset(
                                          "assets/images/stream.json"))
                                  : Center(
                                      child: Image.asset(
                                          "assets/images/stream-offline.jpg")),
                            ),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Lottie.asset("assets/images/nolive.json",
                          height: 200)),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: MaterialButton(
              onPressed: () {
                Future.delayed(Duration(seconds: 5));
                controller
                    .checkFollower(controller.ListLiveStream[index]['Email']);
              },
              child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: controller.followersOfUser!
                                .containsKey(controller.emailCurrentUser) &&
                            controller.followersOfUser![
                                    controller.emailCurrentUser] ==
                                true
                        ? const Text("unfollow")
                        : const Text("follow")),
              ),
            ),
          ),
          Positioned(
            left: 7,
            top: 25,
            child: GestureDetector(
              onTap: () async {
                String email =
                    controller.ListLiveStream[index]['Email'] ?? 'none';
                await controller.fetchUserWithProducts(email);
                controller.GoToProfileProductInfo(controller.UserWithProduct);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: controller.ListLiveStream[index]['avatar'] != null &&
                          controller.ListLiveStream[index]['avatar'].isNotEmpty
                      ? (controller.ListLiveStream[index]['avatar']
                              .startsWith('http')
                          ? Image.network(
                              controller.ListLiveStream[index]['avatar'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, size: 20),
                            )
                          : (() {
                              final file = File(
                                  controller.ListLiveStream[index]['avatar']);
                              return file.existsSync()
                                  ? Image.file(file, fit: BoxFit.cover)
                                  : const Icon(Icons.error, size: 20);
                            })())
                      : Image.network(
                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59094701-stock-illustration-businessman-profile-icon.jpg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 60,
            child: Text(
              "${controller.ListLiveStream[index]['FullName']}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 50,
            left: 60,
            child: Text(
              "${controller.ListLiveStream[index]['followers']} followers",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
