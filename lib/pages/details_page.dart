import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int numberOfPeoples = 1;

  @override
  Widget build(BuildContext context) {
    // Transparent Status Bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        if (state is DetailState) {
          var info = state.place;
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
              children: [
                // Image Background
                Positioned(
                  top: 0,
                  height: 300,
                  // width: double.maxFinite, // Not Applicable in Positioned
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(info.img, fit: BoxFit.fill),
                ),

                // Menu Bar
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Press
                      IconButton(
                          onPressed: () =>
                              BlocProvider.of<AppCubits>(context).goHome(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.grey[50],
                          )),

                      // Vertical Menu
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey[50],
                      ),
                    ],
                  ),
                ),

                // Container
                Positioned(
                  top: 200,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title
                            Text(info.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                )),

                            // Price
                            Text("\$ ${info.price}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5d69b3),
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Location
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Color(0xFF5d69b3),
                            ),
                            const SizedBox(width: 5),
                            Text(info.location,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF989acd),
                                )),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Ratings
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: (index < info.stars)
                                      ? const Color(0xFFe7bb4e)
                                      : const Color(0xFF878593),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '(${info.stars.toDouble().toString()})',
                              style: const TextStyle(color: Color(0xFF878593)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 23),

                        // People Text
                        const Text("People",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                        const SizedBox(height: 5),
                        const Text("Number of people in your group",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            )),
                        const SizedBox(height: 15),

                        // Peoples Option
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  numberOfPeoples = index + 1;
                                });
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: (numberOfPeoples == (index + 1))
                                      ? const Color(0xFF2e2e31)
                                      : Colors.grey.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (numberOfPeoples == (index + 1))
                                          ? Colors.grey[50]
                                          : const Color(0xFF2e2e31),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23),

                        // Description Title
                        const Text("Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                        const SizedBox(height: 10),

                        // Description Text
                        Text(info.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            )),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // Booking Row
                Positioned(
                  bottom: 15,
                  left: 25,
                  right: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Fav Button
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF5d69b3),
                              width: 2,
                            )),
                        child: const Center(
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Color(0xFF5d69b3),
                          ),
                        ),
                      ),

                      // Book Button
                      Flexible(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF5d69b3),
                          ),
                          child: Center(
                            child: Text(
                              "Book Trip Now",
                              style: TextStyle(
                                  color: Colors.grey[50],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
