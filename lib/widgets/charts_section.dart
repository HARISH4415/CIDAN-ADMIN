import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChartsSection extends StatefulWidget {
  const ChartsSection({super.key});

  @override
  State<ChartsSection> createState() => _ChartsSectionState();
}

class _ChartsSectionState extends State<ChartsSection> {
  String selectedDepositsFilter = 'This Month';
  String selectedGrowthFilter = '6 Months';

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Deposits vs Loans Card
        Expanded(
          child: Container(
            decoration: AppTheme.cardDecoration(),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Deposits vs Loans',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildDropdownPill(
                      value: selectedDepositsFilter,
                      items: ['This Month', 'Last Month', 'This Quarter'],
                      onChanged: (val) {
                        if (val != null) setState(() => selectedDepositsFilter = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Bar Chart
                const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: DepositsLoansPainter(),
                  ),
                ),
                const SizedBox(height: 8),
                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem(AppTheme.primaryBlue, 'Deposits'),
                    const SizedBox(width: 14),
                    _buildLegendItem(AppTheme.warningAmber, 'Loans'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Customer Growth Card
        Expanded(
          child: Container(
            decoration: AppTheme.cardDecoration(),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Customer Growth',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildDropdownPill(
                      value: selectedGrowthFilter,
                      items: ['6 Months', '3 Months', '1 Year'],
                      onChanged: (val) {
                        if (val != null) setState(() => selectedGrowthFilter = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Line Chart with tooltip
                const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CustomerGrowthPainter(),
                  ),
                ),
                const SizedBox(height: 8),
                // Empty spacing to align nicely with left card
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildDropdownPill({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return PopupMenuButton<String>(
      onSelected: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item,
            height: 36,
            child: Text(item, style: const TextStyle(fontSize: 12)),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.borderLight, width: 0.8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 10.5,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 13,
              color: AppTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class DepositsLoansPainter extends CustomPainter {
  const DepositsLoansPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 26;
    const double bottomPadding = 20;
    const double topPadding = 6;
    const double rightPadding = 6;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - bottomPadding - topPadding;

    final yAxisLabels = ['20Cr', '15Cr', '10Cr', '5Cr', '0'];

    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1;

    final textStyle = const TextStyle(
      color: AppTheme.textLight,
      fontSize: 9.5,
      fontWeight: FontWeight.w500,
    );

    // Draw horizontal grid lines and Y-axis labels
    for (int i = 0; i < yAxisLabels.length; i++) {
      final double y = topPadding + (i / (yAxisLabels.length - 1)) * chartHeight;
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final textSpan = TextSpan(text: yAxisLabels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(leftPadding - textPainter.width - 4, y - textPainter.height / 2),
      );
    }

    // Data for Week 1 to 4
    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    final deposits = [10.0, 12.8, 16.0, 20.0]; // in Cr
    final loans = [7.2, 10.1, 12.7, 16.5]; // in Cr

    final double slotWidth = chartWidth / weeks.length;
    final double barWidth = (slotWidth * 0.32).clamp(7.0, 14.0);
    final double barSpacing = 2.0;

    final depositPaint = Paint()..color = AppTheme.primaryBlue;
    final loanPaint = Paint()..color = const Color(0xFFFBBF24);

    for (int i = 0; i < weeks.length; i++) {
      final double slotCenterX = leftPadding + (i + 0.5) * slotWidth;

      // Deposit bar
      final double depVal = deposits[i];
      final double depHeight = (depVal / 20.0) * chartHeight;
      final double depLeft = slotCenterX - barWidth - barSpacing / 2;
      final double depTop = topPadding + chartHeight - depHeight;

      final depRRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(depLeft, depTop, barWidth, depHeight),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
      );
      canvas.drawRRect(depRRect, depositPaint);

      // Loan bar
      final double loanVal = loans[i];
      final double loanHeight = (loanVal / 20.0) * chartHeight;
      final double loanLeft = slotCenterX + barSpacing / 2;
      final double loanTop = topPadding + chartHeight - loanHeight;

      final loanRRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(loanLeft, loanTop, barWidth, loanHeight),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
      );
      canvas.drawRRect(loanRRect, loanPaint);

      // X-axis label
      final textSpan = TextSpan(text: weeks[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(slotCenterX - textPainter.width / 2, size.height - bottomPadding + 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomerGrowthPainter extends CustomPainter {
  const CustomerGrowthPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 26;
    const double bottomPadding = 20;
    const double topPadding = 22; // extra room for the 1,248 callout pill
    const double rightPadding = 12;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - bottomPadding - topPadding;

    final yAxisLabels = ['1,500', '1,000', '500', '0'];

    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1;

    final textStyle = const TextStyle(
      color: AppTheme.textLight,
      fontSize: 9.5,
      fontWeight: FontWeight.w500,
    );

    // Grid lines and labels
    for (int i = 0; i < yAxisLabels.length; i++) {
      final double y = topPadding + (i / (yAxisLabels.length - 1)) * chartHeight;
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final textSpan = TextSpan(text: yAxisLabels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(leftPadding - textPainter.width - 4, y - textPainter.height / 2),
      );
    }

    final months = ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'];
    final values = [430.0, 550.0, 670.0, 840.0, 1000.0, 1248.0];

    final List<Offset> points = [];
    for (int i = 0; i < months.length; i++) {
      final double x = leftPadding + (i / (months.length - 1)) * chartWidth;
      final double y = topPadding + chartHeight - (values[i] / 1500.0) * chartHeight;
      points.add(Offset(x, y));

      // X-axis label
      final textSpan = TextSpan(text: months[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - bottomPadding + 4),
      );
    }

    // Build smooth cubic curve
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Filled area gradient
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, topPadding + chartHeight);
    fillPath.lineTo(points.first.dx, topPadding + chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.primaryBlue.withValues(alpha: 0.22),
          AppTheme.primaryBlue.withValues(alpha: 0.01),
        ],
      ).createShader(Rect.fromLTWH(leftPadding, topPadding, chartWidth, chartHeight))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Stroke line
    final linePaint = Paint()
      ..color = AppTheme.primaryBlue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    // Draw dots
    final dotPaint = Paint()..color = AppTheme.primaryBlue;
    final dotCenterPaint = Paint()..color = Colors.white;

    for (int i = 0; i < points.length; i++) {
      final pt = points[i];
      canvas.drawCircle(pt, 3.2, dotPaint);
      canvas.drawCircle(pt, 1.4, dotCenterPaint);
    }

    // Draw active Callout / Tooltip on Oct point (1,248)
    final octPt = points.last;
    _drawCalloutPill(canvas, octPt, '1,248');
  }

  void _drawCalloutPill(Canvas canvas, Offset target, String text) {
    const pillWidth = 42.0;
    const pillHeight = 20.0;
    const pointerHeight = 4.0;

    final pillRect = Rect.fromCenter(
      center: Offset(target.dx, target.dy - pointerHeight - pillHeight / 2 - 2),
      width: pillWidth,
      height: pillHeight,
    );

    final pillPath = Path()
      ..addRRect(RRect.fromRectAndRadius(pillRect, const Radius.circular(5)));

    // Small pointer triangle
    final pointerPath = Path()
      ..moveTo(target.dx - 4, pillRect.bottom)
      ..lineTo(target.dx, target.dy - 1)
      ..lineTo(target.dx + 4, pillRect.bottom)
      ..close();

    final pillPaint = Paint()
      ..color = const Color(0xFF0066FF)
      ..style = PaintingStyle.fill;

    canvas.drawPath(pillPath, pillPaint);
    canvas.drawPath(pointerPath, pillPaint);

    // Text "1,248"
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        pillRect.center.dx - textPainter.width / 2,
        pillRect.center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
