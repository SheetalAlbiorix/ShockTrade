import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/features/chart/presentation/widgets/candlestick_chart_widget.dart';
import 'package:intl/intl.dart';

class ProfessionalChartScreen extends StatefulWidget {
  final String symbol;
  final String name;

  const ProfessionalChartScreen({
    super.key,
    this.symbol = 'RELIANCE',
    this.name = 'Reliance Industries Ltd',
  });

  @override
  State<ProfessionalChartScreen> createState() =>
      _ProfessionalChartScreenState();
}

class _ProfessionalChartScreenState extends State<ProfessionalChartScreen> {
  // Chart Colors from HTML
  static const Color kBackgroundDark = Color(0xFF0A0A0A);
  static const Color kPanelBg = Color(0xFF111318);
  static const Color kBorderColor = Color(0xFF1e2431);
  static const Color kPrimaryColor = Color(0xFF135bec);
  static const Color kTextGray = Color(0xFF9da6b9);
  static const Color kGreen = Color(0xFF0bda5e);
  static const Color kRed = Color(0xFFfa6238);
  static const Color kYellow = Color(0xFFfacc15);

  // Dynamic values
  double currentOpen = 2852.1;
  double currentHigh = 2864.0;
  double currentLow = 2848.5;
  double currentClose = 2854.2;

  // Panel Flex values
  int _mainChartFlex = 300;
  int _rsiPanelFlex = 100;
  int _macdPanelFlex = 100;

  // Draggable Toolbar State
  Offset _toolbarPosition = const Offset(8, 16);

  void _onCrosshairMoved(CandlestickData? data) {
    if (data != null) {
      setState(() {
        currentOpen = data.open;
        currentHigh = data.high;
        currentLow = data.low;
        currentClose = data.close;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar
            _buildTopBar(),

            // 2. Main Content Area (Toolbar + Chart + Panels)
            Expanded(
              child: Stack(
                children: [
                  Row(
                    children: [
                      // Floating Toolbar Space (Main chart area needs to accommodate it visually)
                      // Ideally toolbar is absolute positioned, so row just has the chart column
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            children: [
                              // Main Price Chart
                              Expanded(
                                flex: _mainChartFlex,
                                child: _buildMainChartArea(),
                              ),
                              _buildResizeHandle(
                                onDrag: (delta) {
                                  setState(() {
                                    final totalFlex = _mainChartFlex +
                                        _rsiPanelFlex +
                                        _macdPanelFlex;
                                    final totalHeight = constraints.maxHeight -
                                        32 -
                                        (2 *
                                            8); // Subtract TimeAxis and handles
                                    if (totalHeight <= 0) return;

                                    final flexDelta =
                                        (delta / totalHeight * totalFlex)
                                            .round();

                                    if (_mainChartFlex + flexDelta > 50 &&
                                        _rsiPanelFlex - flexDelta > 20) {
                                      _mainChartFlex += flexDelta;
                                      _rsiPanelFlex -= flexDelta;
                                    }
                                  });
                                },
                              ),

                              // RSI Panel
                              Expanded(
                                  flex: _rsiPanelFlex,
                                  child: _buildIndicatorPanel('RSI (14, close)',
                                      '58.42', kBackgroundDark)),

                              _buildResizeHandle(
                                onDrag: (delta) {
                                  setState(() {
                                    final totalFlex = _mainChartFlex +
                                        _rsiPanelFlex +
                                        _macdPanelFlex;
                                    final totalHeight =
                                        constraints.maxHeight - 32 - (2 * 8);
                                    if (totalHeight <= 0) return;

                                    final flexDelta =
                                        (delta / totalHeight * totalFlex)
                                            .round();

                                    if (_rsiPanelFlex + flexDelta > 20 &&
                                        _macdPanelFlex - flexDelta > 20) {
                                      _rsiPanelFlex += flexDelta;
                                      _macdPanelFlex -= flexDelta;
                                    }
                                  });
                                },
                              ),

                              // MACD Panel
                              Expanded(
                                  flex: _macdPanelFlex,
                                  child: _buildIndicatorPanel(
                                      'MACD (12, 26, 9)',
                                      '+12.45',
                                      kBackgroundDark,
                                      isMacd: true)),

                              // Time Axis
                              _buildTimeAxis(),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 48, // Compact height
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: kBackgroundDark,
        border: Border(bottom: BorderSide(color: kBorderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Symbol Info & OHLC
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: kTextGray, size: 20),
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.analytics_outlined,
                      color: kPrimaryColor, size: 20),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.symbol,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const Text(
                        'NSE · EQUITY',
                        style: TextStyle(
                          color: kTextGray,
                          fontSize: 9,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text('5m',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Container(width: 1, height: 24, color: kBorderColor),
                  const SizedBox(width: 12),
                  // OHLC Data
                  _buildOHLCText('O', currentOpen),
                  const SizedBox(width: 8),
                  _buildOHLCText('H', currentHigh),
                  const SizedBox(width: 8),
                  _buildOHLCText('L', currentLow),
                  const SizedBox(width: 8),
                  _buildOHLCText('C', currentClose, isClose: true),
                  const SizedBox(width: 16), // Add some padding at the end
                ],
              ),
            ),
          ),

          // Right Side: Actions
          Row(
            children: [
              _buildActionButton(Icons.auto_graph, 'Indicators'),
              const SizedBox(width: 8),
              Container(width: 1, height: 16, color: kBorderColor),
              const SizedBox(width: 8),
              _buildIconOnlyButton(Icons.history),
              _buildIconOnlyButton(Icons.settings_outlined),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.fullscreen, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeftToolbar() {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF080808), // Very dark
        border: Border.all(color: kBorderColor),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          _buildToolbarTool(Icons.near_me, isSelected: true),
          const SizedBox(height: 16),
          _buildToolbarTool(Icons.show_chart), // Trend Line
          const SizedBox(height: 12),
          _buildToolbarTool(Icons.architecture), // Fibonacci/Tools
          const SizedBox(height: 12),
          _buildToolbarTool(Icons.edit_outlined), // Drawing
          const SizedBox(height: 12),
          _buildToolbarTool(Icons.crop_square), // Shapes
          const SizedBox(height: 32), // Spacer
          _buildToolbarTool(Icons.delete_outline,
              color: const Color(0xFFfa6238)), // Delete
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildMainChartArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Background Grid (Simple border for now, grid handled by chart widget)
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kBorderColor)),
                // TODO: Radial gradient pattern if possible, for now solid
                color: kBackgroundDark,
              ),
            ),

            // Chart Widget
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 60, right: 64), // Space for tools and axis
                child:
                    CandlestickChartWidget(onCrosshairMoved: _onCrosshairMoved),
              ),
            ),

            // Top Left Indicators Overlay (Price Card + EMAs)
            Positioned(
              left: 16, // Adjusted padding
              top: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Change
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        NumberFormat('#,##0.00').format(currentClose),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(currentClose - currentOpen) >= 0 ? "+" : ""}${NumberFormat("#,##0.00").format(currentClose - currentOpen)} (${((currentClose - currentOpen) / currentOpen * 100).toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color:
                              (currentClose - currentOpen) >= 0 ? kGreen : kRed,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // EMA Indicators
                  Row(
                    children: [
                      const Text('EMA (20, close) ',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                      Text('2,842.15',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('EMA (50, close) ',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                      const Text('2,821.80',
                          style: TextStyle(
                              color: kYellow,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),

            // Right Price Axis
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 64,
              child: Container(
                decoration: BoxDecoration(
                    color: kBackgroundDark.withOpacity(0.8),
                    border:
                        const Border(left: BorderSide(color: kBorderColor))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAxisLabel('2,900.00'),
                    _buildAxisLabel('2,880.00'),
                    _buildAxisLabel('2,860.00'),
                    // Current Price Label
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: const BoxDecoration(
                        color: kRed,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(4)),
                      ),
                      child: const Text('2,854.20',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    _buildAxisLabel('2,840.00'),
                    _buildAxisLabel('2,820.00'),
                    _buildAxisLabel('2,800.00'),
                  ],
                ),
              ),
            ),

            // Draggable Toolbar
            Positioned(
              left: _toolbarPosition.dx,
              top: _toolbarPosition.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    double newX = _toolbarPosition.dx + details.delta.dx;
                    double newY = _toolbarPosition.dy + details.delta.dy;

                    // Constrain X (Toolbar width is 48)
                    if (newX < 0) newX = 0;
                    if (newX > constraints.maxWidth - 48) {
                      newX = constraints.maxWidth - 48;
                    }

                    // Constrain Y (Approx height 300, adjust as needed)
                    double toolbarHeight = 300;
                    if (newY < 0) newY = 0;
                    if (newY > constraints.maxHeight - toolbarHeight) {
                      newY = constraints.maxHeight - toolbarHeight;
                    }

                    _toolbarPosition = Offset(newX, newY);
                  });
                },
                child: _buildLeftToolbar(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIndicatorPanel(String title, String value, Color bgColor,
      {bool isMacd = false}) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0d0f14),
        border: Border(bottom: BorderSide(color: kBorderColor)),
      ),
      child: Stack(
        children: [
          // Header
          Positioned(
            left: 64,
            top: 6,
            child: Row(
              children: [
                Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: isMacd ? kPrimaryColor : kTextGray,
                        shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 9,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.settings_outlined, size: 10, color: kTextGray),
                const SizedBox(width: 4),
                const Icon(Icons.close, size: 10, color: kTextGray),
              ],
            ),
          ),

          // Placeholder Graph
          Positioned(
            left: 64,
            right: 64,
            top: 20,
            bottom: 0,
            child: CustomPaint(painter: isMacd ? MacdPainter() : RsiPainter()),
          ),

          // Right Axis
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 64,
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: kBorderColor)),
                  color: Color(0x990A0A0A)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: isMacd
                    ? [_buildAxisLabel('0.00', size: 9)]
                    : [
                        _buildAxisLabel('70.0', size: 9),
                        _buildAxisLabel('30.0', size: 9)
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeAxis() {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 64, right: 64),
      decoration: const BoxDecoration(
        color: kPanelBg,
        border: Border(top: BorderSide(color: kBorderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAxisLabel('10:00', size: 9),
          _buildAxisLabel('11:00', size: 9),
          _buildAxisLabel('12:00', size: 9),
          _buildAxisLabel('13:00', size: 9),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: const Color(0xFF3b4354),
                borderRadius: BorderRadius.circular(4)),
            child: const Text('14:00',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold)),
          ),
          _buildAxisLabel('15:00', size: 9),
          _buildAxisLabel('16:00', size: 9),
        ],
      ),
    );
  }

  Widget _buildResizeHandle({required Function(double) onDrag}) {
    return GestureDetector(
      onVerticalDragUpdate: (details) => onDrag(details.delta.dy),
      child: Container(
        height: 8,
        color: kBackgroundDark,
        child: Center(
          child: Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: kBorderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _buildOHLCText(String label, double value, {bool isClose = false}) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.w500)),
        const SizedBox(width: 4),
        Text(value.toStringAsFixed(1), // Match HTML format style
            style: TextStyle(
                color: isClose ? kRed : kTextGray,
                fontSize: 11,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, color: kTextGray, size: 18),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  color: kTextGray, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildIconOnlyButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(icon, color: kTextGray, size: 20),
    );
  }

  Widget _buildToolbarTool(IconData icon,
      {bool isSelected = false, Color? color}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF135bec).withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon,
          color: color ?? (isSelected ? const Color(0xFF135bec) : kTextGray),
          size: 18),
    );
  }

  Widget _buildAxisLabel(String text, {double size = 10}) {
    return Text(text,
        style: TextStyle(
            color: kTextGray, fontSize: size, fontWeight: FontWeight.bold));
  }
}

// Simple Painters for Indicators
class RsiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9da6b9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path();
    path.moveTo(0, size.height * 0.6);
    // Rough curve
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.5,
        size.width * 0.4, size.height * 0.45);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.75,
        size.width * 0.8, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.55);
    canvas.drawPath(path, paint);

    // Limits
    final dashPaint = Paint()
      ..color = const Color(0xFF1e2431)
      ..strokeWidth = 1;
    // draw dash (simplified)
    canvas.drawLine(Offset(0, size.height * 0.3),
        Offset(size.width, size.height * 0.3), dashPaint);
    canvas.drawLine(Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.7), dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MacdPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / 20;
    final paintGreen = Paint()
      ..color = const Color(0xFF0bda5e).withOpacity(0.4);
    final paintRed = Paint()..color = const Color(0xFFfa6238).withOpacity(0.4);

    for (int i = 0; i < 20; i++) {
      final isUp = i % 3 != 0;
      final height = (i % 5 + 1) * size.height / 10;
      final x = i * barWidth;
      canvas.drawRect(
          Rect.fromLTWH(x, size.height - height, barWidth - 2, height),
          isUp ? paintGreen : paintRed);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
