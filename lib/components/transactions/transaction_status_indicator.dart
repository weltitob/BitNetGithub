import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';

class TransactionStatusIndicator extends StatelessWidget {
  final TransactionStatus status;
  final int? confirmations;
  final bool isReplaced;

  const TransactionStatusIndicator({
    required this.status,
    this.confirmations,
    this.isReplaced = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlinkingDot(
          color: _getStatusColor(status, isReplaced),
        ),
        const SizedBox(width: 8),
        Text(
          _getStatusText(context, status, confirmations, isReplaced),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: _getStatusColor(status, isReplaced),
              ),
        ),
      ],
    );
  }

  Color _getStatusColor(TransactionStatus status, bool isReplaced) {
    if (isReplaced) return AppTheme.colorBitcoin;

    switch (status) {
      case TransactionStatus.confirmed:
        return AppTheme.successColor;
      case TransactionStatus.pending:
        return AppTheme.colorBitcoin;
      case TransactionStatus.failed:
        return AppTheme.errorColor;
      default:
        return AppTheme.errorColor;
    }
  }

  String _getStatusText(BuildContext context, TransactionStatus status,
      int? confirmations, bool isReplaced) {
    if (isReplaced) return L10n.of(context)!.replaced;

    switch (status) {
      case TransactionStatus.confirmed:
        if (confirmations != null && confirmations > 0) {
          return "$confirmations ${L10n.of(context)!.confirmed}";
        }
        return L10n.of(context)!.confirmed;
      case TransactionStatus.pending:
        return "Pending";
      case TransactionStatus.failed:
        return "Failed";
      default:
        return L10n.of(context)!.unknown;
    }
  }
}

// Blinking dot animation widget
class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;

  const BlinkingDot({
    Key? key,
    required this.color,
    this.size = 10.0,
  }) : super(key: key);

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _opacityAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
