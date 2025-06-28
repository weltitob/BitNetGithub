import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/channel/channel_operation.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/services/lnurl_channel_service.dart';

class ChannelOperationDetails extends StatefulWidget {
  final TransactionItemData data;
  final String? channelId;

  const ChannelOperationDetails({
    Key? key,
    required this.data,
    this.channelId,
  }) : super(key: key);

  @override
  State<ChannelOperationDetails> createState() =>
      _ChannelOperationDetailsState();
}

class _ChannelOperationDetailsState extends State<ChannelOperationDetails> {
  final LnurlChannelService _channelService = LnurlChannelService();
  ChannelOperation? _channelOperation;
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadChannelOperation();
  }

  Future<void> _loadChannelOperation() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        throw Exception('No authenticated user');
      }

      // Load from Firebase
      final doc = await FirebaseFirestore.instance
          .collection('backend')
          .doc(userId)
          .collection('channel_operations')
          .doc(widget.channelId ?? widget.data.txHash)
          .get();

      if (doc.exists) {
        setState(() {
          _channelOperation = ChannelOperation.fromFirestore(doc.data()!);
          _isLoading = false;
        });

        // Check for updates if status is pending/opening
        if (_channelOperation!.status == ChannelOperationStatus.pending ||
            _channelOperation!.status == ChannelOperationStatus.opening) {
          _checkChannelStatus();
        }
      } else {
        setState(() {
          _errorMessage = 'Channel operation not found';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _checkChannelStatus() async {
    if (_channelOperation == null || _isUpdating) return;

    try {
      setState(() {
        _isUpdating = true;
      });

      // Check if channel is now active
      final existingChannel = await _channelService.findExistingChannel(
        _channelOperation!.remoteNodeId,
      );

      if (existingChannel != null) {
        final isActive = existingChannel['active'] as bool? ?? false;
        final channelPoint = existingChannel['channel_point'] as String?;

        // Update status if changed
        if (isActive &&
            _channelOperation!.status != ChannelOperationStatus.active) {
          await _updateChannelStatus(
            ChannelOperationStatus.active,
            channelPoint: channelPoint,
          );
        }
      } else if (_channelOperation!.status == ChannelOperationStatus.pending) {
        // Check pending channels
        final pendingChannel = await _channelService.findPendingChannel(
          _channelOperation!.remoteNodeId,
        );

        if (pendingChannel != null) {
          await _updateChannelStatus(ChannelOperationStatus.opening);
        }
      }

      setState(() {
        _isUpdating = false;
      });
    } catch (e) {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  Future<void> _updateChannelStatus(
    ChannelOperationStatus newStatus, {
    String? channelPoint,
    String? errorMessage,
  }) async {
    final userId = Auth().currentUser?.uid;
    if (userId == null) return;

    final updates = <String, dynamic>{
      'status': newStatus.value,
      'updated_at': FieldValue.serverTimestamp(),
    };

    if (channelPoint != null) {
      updates['channel_point'] = channelPoint;
    }
    if (errorMessage != null) {
      updates['error_message'] = errorMessage;
    }

    await FirebaseFirestore.instance
        .collection('backend')
        .doc(userId)
        .collection('channel_operations')
        .doc(widget.channelId ?? widget.data.txHash)
        .update(updates);

    setState(() {
      _channelOperation = _channelOperation!.copyWith(
        status: newStatus,
        channelPoint: channelPoint,
        errorMessage: errorMessage,
      );
    });
  }

  Color _getStatusColor() {
    switch (_channelOperation?.status) {
      case ChannelOperationStatus.active:
        return AppTheme.successColor;
      case ChannelOperationStatus.failed:
        return AppTheme.errorColor;
      case ChannelOperationStatus.closed:
        return Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
      default:
        return AppTheme.colorBitcoin;
    }
  }

  IconData _getStatusIcon() {
    switch (_channelOperation?.status) {
      case ChannelOperationStatus.active:
        return Icons.check_circle;
      case ChannelOperationStatus.failed:
        return Icons.error;
      case ChannelOperationStatus.closed:
        return Icons.cancel;
      default:
        return Icons.access_time;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return bitnetScaffold(
      context: context,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Channel Details',
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: dotProgress(context))
          : _errorMessage != null
              ? _buildErrorState()
              : _buildContent(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 64.r,
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Error loading channel details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              _errorMessage ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.cardPadding.h),
            LongButtonWidget(
              title: 'Retry',
              onTap: _loadChannelOperation,
              buttonType: ButtonType.solid,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_channelOperation == null) return Container();

    final theme = Theme.of(context);
    final op = _channelOperation!;

    return RefreshIndicator(
      onRefresh: _loadChannelOperation,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Container(
              padding: EdgeInsets.all(AppTheme.cardPadding.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getStatusIcon(),
                        color: _getStatusColor(),
                        size: 48.r,
                      ),
                      if (_isUpdating) ...[
                        SizedBox(width: AppTheme.elementSpacing.w),
                        SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: AppTheme.elementSpacing.h),
                  Text(
                    op.status.value.toUpperCase().replaceAll('_', ' '),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppTheme.elementSpacing.h),
                  Text(
                    op.statusMessage,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppTheme.cardPadding.h),

            // Channel Info
            Container(
              padding: EdgeInsets.all(AppTheme.cardPadding.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Channel Information',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: AppTheme.elementSpacing.h),
                  _buildInfoRow('Remote Node', op.remoteNodeAlias),
                  _buildInfoRow('Capacity', '${op.capacity.toString()} sats'),
                  _buildInfoRow(
                      'Local Balance', '${op.localBalance.toString()} sats'),
                  if (op.pushAmount > 0)
                    _buildInfoRow(
                        'Push Amount', '${op.pushAmount.toString()} sats'),
                  _buildInfoRow('Type', op.isPrivate ? 'Private' : 'Public'),
                  _buildInfoRow(
                    'Created',
                    DateFormat.yMMMd().add_jm().format(
                          DateTime.fromMillisecondsSinceEpoch(op.timestamp),
                        ),
                  ),
                ],
              ),
            ),

            if (op.txHash != null || op.channelPoint != null) ...[
              SizedBox(height: AppTheme.cardPadding.h),

              // Technical Details
              Container(
                padding: EdgeInsets.all(AppTheme.cardPadding.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius:
                      BorderRadius.circular(AppTheme.borderRadiusMid.r),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Technical Details',
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: AppTheme.elementSpacing.h),
                    if (op.remoteNodeId.isNotEmpty)
                      _buildCopyableRow('Node ID', op.remoteNodeId),
                    if (op.txHash != null)
                      _buildCopyableRow('Funding TX', op.txHash!),
                    if (op.channelPoint != null)
                      _buildCopyableRow('Channel Point', op.channelPoint!),
                  ],
                ),
              ),
            ],

            SizedBox(height: AppTheme.cardPadding.h),

            // Action Buttons
            if (op.status == ChannelOperationStatus.pending ||
                op.status == ChannelOperationStatus.opening) ...[
              LongButtonWidget(
                title: 'Check Status',
                onTap: _isUpdating ? null : _checkChannelStatus,
                buttonType: ButtonType.solid,
                state: _isUpdating ? ButtonState.loading : ButtonState.idle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyableRow(String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 4.h),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar(
                'Copied',
                '$label copied to clipboard',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.05),
                borderRadius:
                    BorderRadius.circular(AppTheme.borderRadiusSmall.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.copy,
                    size: 16.r,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
