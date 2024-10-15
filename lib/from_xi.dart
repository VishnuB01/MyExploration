import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      home: PlayerCardScreen(),
    );
  }
}

class PlayerCardScreen extends StatefulWidget {
  @override
  State<PlayerCardScreen> createState() => _PlayerCardScreen();
}

class _PlayerCardScreen extends State<PlayerCardScreen>
    with SingleTickerProviderStateMixin {
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
  var _controller = Rx<AnimationController?>(null);
  var _isFlipped = true.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _containerKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _containerHeight = renderBox.size.height + 300;
        _containerWidth = renderBox.size.width;
      });
    });
    _controller.value = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _loadSvg();
  }

  void _flip() {
    print('$_isFlipped');
    if (_isFlipped.value) {
      _controller.value?.reverse();
    } else {
      _controller.value?.forward();
    }
    _isFlipped.value = !_isFlipped.value;
  }

  @override
  void dispose() {
    _controller.value?.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    var height = 0.0.obs;
    var width = 0.0.obs;
    // print("$h,$w");
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 15, 3, 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.grey, Colors.grey],
                      // Grey gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  // height: 400,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: _flip,
                      child: AnimatedBuilder(
                          animation: _controller.value ??
                              AnimationController(vsync: this),
                          builder: (context, child) {
                            return Container(
                                key: _containerKey,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: _isFlipped.value
                                    ? Stack(
                                        children: [
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              // Adjust the text size based on the available width
                                              double textSize = constraints
                                                      .maxWidth *
                                                  0.1; // 10% of the available width
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        constraints.maxWidth *
                                                            0.4,
                                                    top: 20,
                                                    left: 20),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "B. Vishnu Prakash",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                        ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onTertiary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            child: ClipPath(
                                              clipper: ShapedContainer(),
                                              child: Container(
                                                //this container height and width
                                                padding: EdgeInsets.fromLTRB(
                                                    0, h.value * 0.1, 0, 0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),

                                                // Generated code for this Row Widget...
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        8,
                                                                        20,
                                                                        8,
                                                                        8),
                                                                child:
                                                                    Container(
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://picsum.photos/seed/533/600',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .onInverseSurface,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            3,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Score',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryContainer,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(5),
                                                                            child:
                                                                                Center(
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
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                        'Event',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleMedium
                                                                            ?.copyWith(),
                                                                      ),
                                                                      Text(
                                                                        'Days',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child:
                                                                        const Divider(
                                                                      thickness:
                                                                          1,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 80,
                                                                    // Fixed height for the ListView.builder
                                                                    child: ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      itemCount:
                                                                          3,

                                                                      // Replace with the actual number of items
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              -1),
                                                                          child:
                                                                              IntrinsicHeight(
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Text(
                                                                                  '${index + 1}',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: Theme.of(context).textTheme.titleMedium,
                                                                                )),
                                                                                Container(
                                                                                  color: Colors.black,
                                                                                  // height: 30,
                                                                                  width: 1,
                                                                                ),
                                                                                Expanded(
                                                                                    child: Text(
                                                                                  '${(index + 1) * 10}',
                                                                                  textAlign: TextAlign.center,
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
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child:
                                                                        LayoutBuilder(
                                                                      builder:
                                                                          (context,
                                                                              constraints) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 2),
                                                                          // Adjust the space between the text and the underline
                                                                          height:
                                                                              1,
                                                                          // Thickness of the underline
                                                                          width:
                                                                              constraints.maxWidth * 0.4,
                                                                          color:
                                                                              Colors.black, // Color of the underline
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
                                                                    .fromSTEB(0,
                                                                    30, 0, 0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
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
                                                                        paddingText(
                                                                          labelText:
                                                                              'Event',
                                                                          labelColor: Theme.of(context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        paddingText(
                                                                            labelText:
                                                                                'Group',
                                                                            labelColor:
                                                                                Theme.of(context).colorScheme.outline),
                                                                        paddingText(
                                                                            labelText:
                                                                                'Level',
                                                                            labelColor:
                                                                                Theme.of(context).colorScheme.outline),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          paddingText(
                                                                              labelText: ':',
                                                                              labelColor: Theme.of(context).colorScheme.outline),
                                                                          paddingText(
                                                                              labelText: ':',
                                                                              labelColor: Theme.of(context).colorScheme.outline),
                                                                          paddingText(
                                                                              labelText: ':',
                                                                              labelColor: Theme.of(context).colorScheme.outline),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          paddingText(
                                                                              labelText: '100 m',
                                                                              labelColor: Theme.of(context).colorScheme.onSurface),
                                                                          paddingText(
                                                                              labelText: '1',
                                                                              labelColor: Theme.of(context).colorScheme.onSurface),
                                                                          paddingText(
                                                                              labelText: 'Beginner',
                                                                              labelColor: Theme.of(context).colorScheme.onSurface),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6),
                                                                        border: Border.all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                Colors.green)),
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              5,
                                                                              10,
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        'In training',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      if (svgGold
                                                                          .isNotEmpty)
                                                                        SvgPicture
                                                                            .string(
                                                                          _updateSvgText(
                                                                              svgGold,
                                                                              textGold),
                                                                        ),
                                                                      if (svgSilver
                                                                          .isNotEmpty)
                                                                        SvgPicture
                                                                            .string(
                                                                          _updateSvgText(
                                                                              svgSilver,
                                                                              textSilver),
                                                                        ),
                                                                      if (svgBronze
                                                                          .isNotEmpty)
                                                                        SvgPicture
                                                                            .string(
                                                                          _updateSvgText(
                                                                              svgBronze,
                                                                              textBronze),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            20,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              'Certificate',
                                                                              style: Theme.of(context).textTheme.titleMedium,
                                                                            ),
                                                                            Text(
                                                                              '12',
                                                                              style: Theme.of(context).textTheme.titleMedium,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        LayoutBuilder(
                                                                          builder:
                                                                              (context, constraints) {
                                                                            return Container(
                                                                              margin: EdgeInsets.only(top: 2),
                                                                              // Adjust the space between the text and the underline
                                                                              height: 1,
                                                                              // Thickness of the underline
                                                                              width: constraints.maxWidth * 0.6,
                                                                              color: Colors.black, // Color of the underline
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
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  8, 20, 8, 0),
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Assign',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onPrimary),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
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
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 10, 2),
                                                          child: Text(
                                                            "High Score",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: ClipPath(
                                                        clipper: BottomRight(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 3, 3),
                                                          child: Container(
                                                            height:
                                                                h.value * 0.1,
                                                            width:
                                                                w.value * 0.4,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 2),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15)),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondaryContainer),
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            30,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  '14.5 s',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .onPrimary,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                      )
                                    : Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.blueGrey,
                                      child: StaggeredGrid.count(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 4,
                                          crossAxisSpacing: 4,
                                          children: [
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 1,)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 2,)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 3)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 4)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 5)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount: 1,
                                                child: GridViewContent(gridText: 'Influencers',cardNo: 6)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount: 3,
                                                mainAxisCellCount: 1,
                                                child: Center(
                                                    child: GridViewContent(gridText: 'Influencers',cardNo: 7))),
                                          ],
                                        ),
                                    ));
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class GridViewContent extends StatelessWidget {
  final String gridText;
  final int cardNo;

  const GridViewContent({
    super.key,
    required this.gridText,
    required this.cardNo
  });


  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry borderRadius;

    if (cardNo < 4) {
      borderRadius = BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8));
    } else if (cardNo > 6) {
      borderRadius = BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    } else {
      borderRadius = BorderRadius.zero;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius:borderRadius
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person),
          Text(gridText),
        ],
      ),
    );
  }
}

class paddingText extends StatelessWidget {
  final String labelText;
  final Color labelColor;

  const paddingText(
      {super.key, required this.labelText, required this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Text(
        labelText,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: labelColor),
        textAlign: TextAlign.start,
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
