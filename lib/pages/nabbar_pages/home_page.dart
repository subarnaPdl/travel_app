import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const Map<String, String> exploreItems = {
    "Trekking": "assets/images/trekking.png",
    "Rafting": "assets/images/rafting.png",
    "Swimming": "assets/images/swimming.png",
    "Balloning": "assets/images/balloning.png",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            var info = state.places;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menu Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.menu, size: 30, color: Colors.black54),
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //Discover text
                    const Text("Discover",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 15),

                    // TabBar
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.only(right: 20),
                      labelPadding: const EdgeInsets.only(right: 20),
                      tabs: const [
                        Tab(text: "Places"),
                        Tab(text: "Inspiration"),
                        Tab(text: "Emotions"),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // TabBar View
                    Container(
                      height: 230,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Places Tab
                          ListView.builder(
                              itemCount: info.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AppCubits>(context)
                                        .detailPage(info[index]);
                                  },
                                  child: Container(
                                    height: 250,
                                    width: 170,
                                    margin: const EdgeInsets.only(right: 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        info[index].img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),

                          // Inspiration Tab
                          const Text('Inspiration Tab View'),

                          // Emotions Tab
                          const Text('Emotions Tab View'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Explore Menu Bar
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Explore more",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("See all",
                              style: TextStyle(
                                  color: Color(0xFF989acd),
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Explorer
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    exploreItems.values.elementAt(index),
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(exploreItems.keys.elementAt(index)),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
