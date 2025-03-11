import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/controller/profileOfUser.dart';

// ignore: must_be_immutable
class ProfileOfUser extends StatelessWidget {
  Profileofuser controller = Get.put(Profileofuser());
  ProfileOfUser({super.key});

  @override
  Widget build(BuildContext context) {
    String name = controller.name?? "name not found";
    String email = controller.email?? "email not found";
    String profilepictureurl = controller.pictureUrl!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Ensures no parts are clipped
              children: [
                ClipPath(
                  clipper: SlantClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 250, // Increased height to make space for avatar
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.white,
                          Colors.blue,
                          //Color(0xFF243744),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160, // Position to keep avatar visible
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: CustomPaint(
                      painter: SlantedSemicircleBorderPainter(),
                      child: Container(
                        height: 120,
                        width: 120,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          // ignore: unnecessary_null_comparison
                          child:profilepictureurl == null?
                              const Icon(Icons.person, size: 60, color: Colors.blue):Image.asset("assets/images/default_avatar.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                 Positioned(
                  top: 50,
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 80,
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: Text(
                      'UX/UI Designer',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'UX/UI Designer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF243744)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF243744)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF243744)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: 330,
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: Text(
                      'There are many variations of passages of Lorem Ipsum available',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 380,
                  left: 0,
                  right: 0, // Center horizontally
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                'Posts',
                                style: TextStyle(
                                  //color: Colors.black,
                                  color: Colors.black26,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                '238',
                                style: TextStyle(
                                  color: Colors.black,
                                  //color: Color(0x73777C),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.rotate(
                          angle:
                              -1.55, // Angle of rotation for slanting the divider
                          child: Container(
                            width: 50, // Length of the divider
                            height: 2, // Thickness of the divider
                            color: Colors.black, // Color of the divider
                          ),
                        ),
                        //SizedBox(width: 10),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                'Followers',
                                style: TextStyle(
                                  //color: Colors.black,
                                  color: Colors.black26,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '238',
                                style: TextStyle(
                                  color: Colors.black,
                                  //color: Color(0x73777C),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.rotate(
                          angle:
                              -1.55, // Angle of rotation for slanting the divider
                          child: Container(
                            width: 50, // Length of the divider
                            height: 2, // Thickness of the divider
                            color: Colors.black, // Color of the divider
                          ),
                        ),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                'Following',
                                style: TextStyle(
                                  //color: Colors.black,
                                  color: Colors.black26,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '238',
                                style: TextStyle(
                                  color: Colors.black,
                                  //color: Color(0x73777C),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                 Positioned(
                  top: 450,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 30),
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined,color: Colors.blue,size: 35,),
                        const SizedBox(width: 10),
                        Text(email,style: const TextStyle(color: Colors.black),)
                      ],
                    ),
                  )),
                  const Positioned(
                  top: 450,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,top: 70),
                    child: Row(
                      children: [
                        Icon(Icons.cake,color: Colors.blue,size: 35,),
                        SizedBox(width: 10),
                        Text("March, 15, 1993",style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  )),
                  // const Positioned(
                  // top: 450,
                  // child: Padding(
                  //   padding: EdgeInsets.only(left: 20,top: 30),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.email_outlined,color: Colors.orange,size: 35,),
                  //       SizedBox(width: 10),
                  //       Text("hani_kr@gmail.com",style: TextStyle(color: Colors.black),)
                  //     ],
                  //   ),
                  // )),
                  Positioned(
                    top: 600,
                    left: 100,
                    child: Container(
                      width: 180,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: MaterialButton(
                        child: const Text("Follow",style: TextStyle(color: Colors.white),),
                        onPressed: () {}))),
                        const Positioned(
                          top: 680,
                          left: 10,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Row(
                                  children: [
                                    Text("Follow me on",style: TextStyle(color: Color.fromARGB(255, 12, 34, 52)),),
                                    SizedBox(width: 5,),
                                    FaIcon(FontAwesomeIcons.twitter,color: Color.fromARGB(255, 12, 34, 52),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 50),
                              Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Row(
                                  children: [
                                    Text("Follow me on",style: TextStyle(color: Color.fromARGB(255, 12, 34, 52)),),
                                    SizedBox(width: 5,),
                                    FaIcon(FontAwesomeIcons.instagram,color: Color.fromARGB(255, 12, 34, 52),)
                                  ],
                                ),
                              ),
                            ],
                          ))
              ],
            ),
            // Add more widgets here for the rest of the profile page
          ],
        ),
      ),
    );
  }
}

class SlantedSemicircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    final startAngle = 3.14; // Start from the left side
    final sweepAngle = -3.14; // Sweep 180 degrees

    // Apply a slant by rotating the canvas
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-0.17); // Adjust the angle as needed
    canvas.translate(-size.width / 2, -size.height / 2);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 1);
    path.lineTo(size.width, size.height - 61);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
