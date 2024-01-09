import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'package:back_pack/constants/font_weight.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  List imageList = [
    {"id": 1, "image_path": 'assets/pngs/pot_6.jpg'},
    {"id": 2, "image_path": 'assets/pngs/pot_1.jpg'},
    {"id": 3, "image_path": 'assets/pngs/pot_5.jpg'},
    {"id": 4, "image_path": 'assets/pngs/pot_4.jpg'},
    {"id": 5, "image_path": 'assets/pngs/pot_3.jpg'},
    {"id": 6, "image_path": 'assets/pngs/pot_2.jpg'},
    {"id": 7, "image_path": 'assets/pngs/pot_7.jpg'},
    {"id": 8, "image_path": 'assets/pngs/pot_8.jpg'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  int mycount = 0;

  final String _content =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum diam ipsum, lobortis quis ultricies non, lacinia at justo.';

  void _shareContent() {
    Share.share(_content);
  }

  bool readMore = false;

  String get text =>
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: const Text('Description'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(currentIndex);
                                },
                                child: CarouselSlider(
                                  items: imageList
                                      .map(
                                        (item) => Image.asset(
                                          item['image_path'],
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      )
                                      .toList(),
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: true,
                                    aspectRatio: 0.82,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      imageList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => carouselController
                                          .animateToPage(entry.key),
                                      child: Container(
                                        width:
                                            currentIndex == entry.key ? 7 : 7,
                                        height: 7.0,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: currentIndex == entry.key
                                                ? const Color(0xff002a53)
                                                : Colors.grey),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.file_download_outlined,
                                          size: 30),
                                      onPressed: () {
                                        print(
                                            'Download image: ${imageList[currentIndex]["image_path"]}');
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.bookmark_border_outlined,
                                          size: 30),
                                      onPressed: () {
                                        print(
                                            'Bookmark image: ${imageList[currentIndex]["image_path"]}');
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          size: 30),
                                      onPressed: () {
                                        print(
                                            'Favorite image: ${imageList[currentIndex]["image_path"]}');
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.fullscreen_outlined,
                                          size: 30),
                                      onPressed: () {
                                        print(
                                            'Fullscreen image: ${imageList[currentIndex]["image_path"]}');
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.star_border_outlined,
                                          size: 30),
                                      onPressed: () {
                                        print(
                                            'Star image: ${imageList[currentIndex]["image_path"]}');
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.share_outlined,
                                        size: 30,
                                      ),
                                      onPressed: _shareContent,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.bookmark_border_outlined,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5),
                            Text('1034'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const Row(
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5),
                            Text('1034'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            FivePointedStar(
                              size: const Size(15, 15),
                              // color: Colors.blue,
                              onChange: (count) {
                                Colors.blue;
                                setState(() {
                                  mycount = count;
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            Text(
                              mycount.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    commonText("Actor Name", const Color(0xff002a53), 16, bold),
                    const SizedBox(
                      height: 5,
                    ),
                    commonText(
                        "Indian Actress", const Color(0xff808080), 16, normal),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        commonText("Duration 20 Mins", const Color(0xff808080),
                            16, normal),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        commonText("Total Average Fees \u{20B9}9,999",
                            const Color(0xff808080), 16, normal),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    commonText("About", const Color(0xff002a53), 16, bold),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        Text(
                          text,
                          style: const TextStyle(color: Color(0xff808080)),
                          maxLines: readMore ? 10 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(6),
                          child: GestureDetector(
                            child: Text(
                              readMore ? "See less" : "See more",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              setState(() {
                                readMore = !readMore;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ]))),
    );
  }

  Text commonText(
    text,
    color,
    double size,
    weight,
  ) =>
      Text(
        text,
        style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: color, fontSize: size, fontWeight: weight)),
      );
}
