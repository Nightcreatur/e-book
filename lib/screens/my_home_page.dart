import 'dart:convert';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  List? popularBooks;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((value) {
      setState(() {
        popularBooks = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 255, 254, 254),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                child: Text(
                  'Popular Books',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: -160,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 180,
                        width: double.infinity,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: .4),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          popularBooks![index]["img"]),
                                      fit: BoxFit.contain),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 15),
                            child: TabBar(
                                tabs: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: const Text(
                                      'New',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: const Text(
                                      'New',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: const Text(
                                      'New',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                                labelPadding: const EdgeInsets.only(right: 15),
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                indicatorPadding: const EdgeInsets.all(8),
                                isScrollable: true),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(controller: _tabController, children: const [
                    Material(
                      child: ListTile(
                        title: Text('Content'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        title: Text('Content'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        title: Text('Content'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
