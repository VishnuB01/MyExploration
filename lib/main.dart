import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

var h = 0.0.obs, w = 0.0.obs;
var h1 = 0.0.obs, w1 = 0.0.obs;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final showContent = true.obs;
  GlobalKey _containerKey = GlobalKey();
  double _containerHeight = 0.0;
  double _containerWidth = 0.0;
  String textGold = '1'; // The text you want to change dynamically
  String textSilver = '2';
  String textBronze = '3';
  String svgGold = '';
  String svgSilver = '';
  String svgBronze = '';
  bool _isFlipped = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _containerKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _containerHeight = renderBox.size.height + 300;
        _containerWidth = renderBox.size.width;
      });
    });
    _loadSvg();

  }

  // Load the SVG file as a string
  Future<void> _loadSvg() async {
    svgGold = await rootBundle.loadString('assets/medal_gold.svg');
    svgSilver = await rootBundle.loadString('assets/medal_silver.svg');
    svgBronze = await rootBundle.loadString('assets/medal_bronze.svg');
    setState(() {});
  }

  // Update the SVG text dynamically
  String _updateSvgText(String svg, String newText) {
    final regex = RegExp(r'<text[^>]*>(.*?)<\/text>');
    return svg.replaceAllMapped(regex, (match) {
      return match.group(0)!.replaceFirst(match.group(1)!, newText);
    });
  }

  void _flip() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = 0.0.obs;
    var width = 0.0.obs;
    // print("$h,$w");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter custom clipper example"),
      ),
      body: Obx(
        () => true
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // height: 400,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: _flip,
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context,child) {
                                return Transform(
                                  transform: Matrix4.rotationY(_controller.value*3.14159),
                                  child: Container(
                                    key: _containerKey,
                                    color: Theme.of(context).colorScheme.primary,
                                    child: _isFlipped ?(
                                      child: Stack(
                                        children: [
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              // Adjust the text size based on the available width
                                              double textSize = constraints.maxWidth *
                                                  0.1; // 10% of the available width
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: constraints.maxWidth * 0.4,
                                                    top: 20,
                                                    left:
                                                        20), // 20% padding from the right
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Vishnu Prakash",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                        ?.copyWith(
                                                          fontSize: textSize,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: ClipPath(
                                              clipper: ShapedContainer(),
                                              child: Container(
                                                //this container height and width
                                                padding: EdgeInsets.fromLTRB(
                                                    0, h.value * 0.1, 0, 0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(20),
                                                    topRight: Radius.circular(20),
                                                  ),
                                                ),
                                                // Generated code for this Row Widget...
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                        8.0),
                                                                child: Container(
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape:
                                                                        BoxShape.circle,
                                                                  ),
                                                                  child: Image.network(
                                                                    'https://picsum.photos/seed/533/600',
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                        8),
                                                                child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors.grey
                                                                        .withOpacity(0.4),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            8),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      Center(
                                                                        child: Text(
                                                                          'Score',
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(5),
                                                                        child: Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.blue,
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                        8),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(5),
                                                                            child: Center(
                                                                              child: Text(
                                                                                '0',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize.max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text('Event',style: Theme.of(context).textTheme.titleMedium,),
                                                                      Text('Days',style: Theme.of(context).textTheme.titleMedium,),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            5, 0, 5, 0),
                                                                    child: const Divider(
                                                                      thickness: 1,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 100,
                                                                    // Fixed height for the ListView.builder
                                                                    child:
                                                                        ListView.builder(
                                                                      padding:
                                                                          EdgeInsets.zero,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      itemCount: 10,

                                                                      // Replace with the actual number of items
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Align(
                                                                          alignment:
                                                                              AlignmentDirectional(
                                                                                  0, -1),
                                                                          child:
                                                                              IntrinsicHeight(
                                                                            child: Row(
                                                                              mainAxisSize:
                                                                                  MainAxisSize
                                                                                      .max,
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceEvenly,
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment
                                                                                      .start,
                                                                              children: [
                                                                                Expanded(
                                                                                    child:
                                                                                        Text(
                                                                                  '${index + 1}',
                                                                                  textAlign:
                                                                                      TextAlign.center,
                                                                                          style: Theme.of(context).textTheme.titleMedium,
                                                                                )),
                                                                                Container(
                                                                                  color: Colors
                                                                                      .black,
                                                                                  // height: 30,
                                                                                  width:
                                                                                      1,
                                                                                ),
                                                                                Expanded(
                                                                                    child:
                                                                                        Text(
                                                                                          '${index + 1}',
                                                                                  textAlign:
                                                                                      TextAlign.center,
                                                                                          style: Theme.of(context).textTheme.titleMedium,
                                                                                )),
                                                                                // Replace '5' with your dynamic content
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            5, 0, 5, 0),
                                                                    child: LayoutBuilder(
                                                                      builder: (context,
                                                                          constraints) {
                                                                        return Container(
                                                                          margin: EdgeInsets
                                                                              .only(
                                                                                  top: 2),
                                                                          // Adjust the space between the text and the underline
                                                                          height: 1,
                                                                          // Thickness of the underline
                                                                          width: constraints
                                                                                  .maxWidth *
                                                                              0.4,
                                                                          color: Colors
                                                                              .black, // Color of the underline
                                                                        );
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0, 40, 0, 0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                 Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize.max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Event',style: Theme.of(context).textTheme.titleMedium,
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .start,

                                                                        ),
                                                                        Text(
                                                                          'Group',style: Theme.of(context).textTheme.titleMedium,
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .start,
                                                                        ),
                                                                        Text(
                                                                          'Level',style: Theme.of(context).textTheme.titleMedium,
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .start,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                                  5,
                                                                                  0,
                                                                                  0,
                                                                                  0),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        children: [
                                                                          Text(
                                                                            ':',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                          Text(
                                                                            ':',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                          Text(
                                                                            ':',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                                  5,
                                                                                  0,
                                                                                  0,
                                                                                  0),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Text(
                                                                            '100 m',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                          Text(
                                                                            '1',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                          Text(
                                                                            'Beginner',style: Theme.of(context).textTheme.titleMedium,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0, 10, 0, 0),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                    10),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .green)),
                                                                    child: const Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(10, 0,
                                                                              10, 0),
                                                                      child: Text(
                                                                        'In training',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0, 10, 0, 0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize.max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      if (svgGold
                                                                          .isNotEmpty)
                                                                        SvgPicture.string(
                                                                          _updateSvgText(
                                                                              svgGold,
                                                                              textGold),
                                                                        ),
                                                                      if (svgSilver
                                                                          .isNotEmpty)
                                                                        SvgPicture.string(
                                                                          _updateSvgText(
                                                                              svgSilver,
                                                                              textSilver),
                                                                        ),
                                                                      if (svgBronze
                                                                          .isNotEmpty)
                                                                        SvgPicture.string(
                                                                          _updateSvgText(
                                                                              svgBronze,
                                                                              textBronze),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(0,
                                                                                20, 0, 0),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              'Certificate',
                                                                              style:  Theme.of(context).textTheme.titleMedium,
                                                                            ),
                                                                            Text(
                                                                              '12',
                                                                              style: Theme.of(context).textTheme.titleMedium,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        LayoutBuilder(
                                                                          builder: (context,
                                                                              constraints) {
                                                                            return Container(
                                                                              margin: EdgeInsets
                                                                                  .only(
                                                                                      top:
                                                                                          2),
                                                                              // Adjust the space between the text and the underline
                                                                              height: 1,
                                                                              // Thickness of the underline
                                                                              width: constraints
                                                                                      .maxWidth *
                                                                                  0.6,
                                                                              color: Colors
                                                                                  .black, // Color of the underline
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets.fromLTRB(
                                                                  8, 20, 8, 0),
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text('Assign'),
                                                            style:
                                                                ElevatedButton.styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  10)),
                                                              backgroundColor:
                                                                  Theme.of(context)
                                                                      .colorScheme
                                                                      .primary,
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )),
                                                      ],
                                                    ),
                                                     Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 10, 10, 2),
                                                          child: Text("High Score",style: Theme.of(context).textTheme.bodyMedium,),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: ClipPath(
                                                        clipper: BottomRight(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.fromLTRB(
                                                                  0, 0, 3, 3),
                                                          child: Container(
                                                            height: h.value * 0.1,
                                                            width: w.value * 0.4,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 2),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                        topRight: Radius
                                                                            .circular(15),
                                                                        bottomRight:
                                                                            Radius
                                                                                .circular(
                                                                                    15)),
                                                                color: Colors.blue),
                                                            child:  Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets.fromLTRB(
                                                                        30, 0, 0, 0),
                                                                child: Text(
                                                                  '14.5 s',
                                                                 style: Theme.of(context).textTheme.titleLarge,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: Container(child: const Text("No Players"))),
      ),
    );
  }
}

class ShapedContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      h.value = size.height;
      w.value = size.width;
    });
    const cornerRadius = Radius.circular(10);
    const double radius = 10;
    Path path = Path();
    print("${size.height},${size.width}");
    path.moveTo(0, size.height * 0.1 + radius);
    path.arcToPoint(
      Offset(radius, size.height * 0.1),
      radius: cornerRadius,
      clockwise: true,
    );
    path.lineTo(size.width * 0.6, size.height * 0.1); // for this edge
    path.lineTo(size.width * 0.8, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width * 0.8, size.height);

    path.lineTo(size.width * 0.6, size.height * 0.9);

    path.lineTo(0 + radius, size.height * 0.9);
    path.arcToPoint(
      Offset(0, size.height * 0.9 - radius),
      radius: cornerRadius,
      clockwise: true,
    );
    // path.lineTo(0, size.height * 0.9);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Or true if you need the clip to be recalculated
  }
}

class BottomRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      h1.value = size.height;
      w1.value = size.width;
    });
    var path = Path();
    // path.lineTo(0, 0);
    // path.lineTo(size.width * 0.5, 0);
    path.moveTo(size.width * 0.05, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo((size.width * 0.55), size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Or true if you need the clip to be recalculated
  }
}
