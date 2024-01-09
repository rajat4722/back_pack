import 'package:back_pack/constants/font_weight.dart';
import 'package:back_pack/presentation/screens/navigation_screen/meetup_screen/meetups/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetupScreen extends StatefulWidget {
  const MeetupScreen({super.key});

  @override
  State<MeetupScreen> createState() => _MeetupScreenState();
}

class _MeetupScreenState extends State<MeetupScreen> {
  List imageList = [
    {"id": 1, "image_path": 'assets/pngs/rectangle_6.png'},
    {"id": 2, "image_path": 'assets/pngs/rectangle_1.png'},
    {"id": 3, "image_path": 'assets/pngs/rectangle_5.png'}
  ];
  List imagesList = [
    {"id": 4, "image_path": 'assets/pngs/rectangle_2.png'},
    {"id": 5, "image_path": 'assets/pngs/rectangle_4.png'},
    {"id": 6, "image_path": 'assets/pngs/rectangle_7.png'},
    {"id": 7, "image_path": 'assets/pngs/rectangle_8.png'},
    {"id": 8, "image_path": 'assets/pngs/rectangle_9.png'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: const Text('Individual Meetup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              SearchBar(
                shape:
                    MaterialStateProperty.all(const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                )),
                side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xff002a53)),
                ),
                hintText: 'Search',
                hintStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.grey)),
                leading: const Icon(
                  Icons.search,
                  color: Color(0xff002a53),
                ),
                trailing: [
                  IconButton(
                    color: const Color(0xff002a53),
                    icon: const Icon(Icons.keyboard_voice),
                    onPressed: () {
                      print('Use voice command');
                    },
                  ),
                ],
                elevation: MaterialStateProperty.all(
                    0), // Adjust elevation value as desired
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                (item) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    item['image_path'],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ),
                              )
                              .toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
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
              const SizedBox(height: 20),
              commonText(
                  "Trending Popular People", const Color(0xff002a53), 16, bold),
              const SizedBox(height: 5),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    // children: <Widget>[
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.circle_sharp,
                                    size: 24.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonText("Author",
                                            const Color(0xff002a53), 16, bold),
                                        commonText(
                                            "1,028 Meetups",
                                            const Color(0xff808080),
                                            12,
                                            normal),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.person_2_sharp,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'See more',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  // ],
                ),
              ),
              const SizedBox(height: 20),
              commonText(
                  "Top Trending Meetups", const Color(0xff002a53), 16, bold),
              const SizedBox(height: 5),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DescriptionScreen(),
                            ),
                          );
                        },
                        child: CarouselSlider(
                          items: imagesList
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    item['image_path'],
                                    fit: BoxFit.fill,
                                    width: 250,
                                  ),
                                ),
                              )
                              .toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currenIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imagesList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currenIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: currenIndex == entry.key
                                    ? const Color(0xff002a53)
                                    : Colors.grey),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
