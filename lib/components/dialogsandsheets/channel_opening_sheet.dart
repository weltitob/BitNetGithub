import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/lnurl_channel_service.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnurl/lnurl_channel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelOpeningSheet extends StatefulWidget {
  final String? lnurlString;
  final VoidCallback? onChannelOpened;
  final bool createBlocktankChannel;
  final int? localAmount;
  final int? pushAmount;

  const ChannelOpeningSheet({
    Key? key,
    this.lnurlString,
    this.onChannelOpened,
    this.createBlocktankChannel = false,
    this.localAmount,
    this.pushAmount,
  }) : super(key: key);

  @override
  State<ChannelOpeningSheet> createState() => _ChannelOpeningSheetState();
}

class _ChannelOpeningSheetState extends State<ChannelOpeningSheet> {
  final LnurlChannelService _channelService = LnurlChannelService();

  LnurlChannelRequest? _channelRequest;
  ChannelOpeningProgress? _progress;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isProcessing =
      false; // Flag to prevent multiple simultaneous operations
  bool _shouldCancel =
      false; // Flag to cancel operations when widget is disposed

  @override
  void initState() {
    super.initState();
    _fetchChannelDetails();
  }

  Future<void> _fetchChannelDetails() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });
      }

      if (widget.createBlocktankChannel) {
        // For Blocktank channels, we'll create the order during the opening process
        // Just show a mock request for UI purposes
        if (mounted) {
          setState(() {
            _channelRequest = LnurlChannelRequest(
              tag: 'channelRequest',
              k1: 'blocktank-order',
              callback: 'https://api1.blocktank.to/api/channels',
              uri: 'blocktank-lsp@api1.blocktank.to:9735',
              nodeId: 'blocktank-lsp',
              localAmt: widget.localAmount ?? 20000,
              pushAmt: widget.pushAmount ?? 0,
            );
            _isLoading = false;
          });
        }
      } else if (widget.lnurlString != null) {
        final channelRequest =
            await _channelService.fetchChannelRequest(widget.lnurlString!);

        if (mounted) {
          setState(() {
            _channelRequest = channelRequest;
            _isLoading = false;
          });
        }
      } else {
        throw Exception("No LNURL string or Blocktank channel option provided");
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }

      // Log the error to Firebase for debugging purposes
      try {
        if (widget.lnurlString != null) {
          await _channelService.logChannelActivity(
            nodeId: 'unknown',
            providerName: 'Unknown Provider',
            activityType: 'fetch_error',
            message: 'Failed to fetch channel details: ${e.toString()}',
            metadata: {
              'lnurl': widget.lnurlString,
              'error': e.toString(),
            },
          );
        }
      } catch (logError) {
        // Don't let logging errors break the UI
        print('Failed to log channel fetch error: $logError');
      }
    }
  }

  Future<void> _openChannel() async {
    if (_channelRequest == null || _isProcessing) return;

    try {
      _isProcessing = true;
      if (mounted) {
        setState(() {
          _progress = ChannelOpeningProgress.connecting();
          _errorMessage = null;
        });
      }

      LnurlChannelResult result;

      if (widget.createBlocktankChannel) {
        // Create and process Blocktank channel
        result = await _channelService.createAndProcessBlocktankChannel(
          localAmount: widget.localAmount ?? 20000,
          pushAmount: widget.pushAmount ?? 0,
          isPrivate: true,
          onProgress: (progress) {
            if (mounted && !_shouldCancel) {
              setState(() {
                _progress = progress;
                if (progress.errorMessage != null) {
                  _errorMessage = progress.errorMessage;
                }
              });
            }
          },
        );
      } else {
        // Process existing LNURL
        result = await _channelService.processChannelRequest(
          lnurlString: widget.lnurlString,
          onProgress: (progress) {
            if (mounted && !_shouldCancel) {
              setState(() {
                _progress = progress;
                if (progress.errorMessage != null) {
                  _errorMessage = progress.errorMessage;
                }
              });
            }
          },
        );
      }

      if (result.success) {
        // Wait a moment to show success, then close
        await Future.delayed(Duration(seconds: 2));

        // Only call onChannelOpened for truly new channels, not existing ones
        if (widget.onChannelOpened != null &&
            !result.message.toLowerCase().contains('already exists') &&
            !result.message.toLowerCase().contains('detected')) {
          widget.onChannelOpened!();
        }

        Navigator.of(context).pop();
      } else {
        // Error state is already handled by the progress callback
        if (_progress?.errorMessage == null && mounted) {
          setState(() {
            _progress = ChannelOpeningProgress.error(result.message);
            _errorMessage = result.message;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _progress = ChannelOpeningProgress.error(e.toString());
          _errorMessage = e.toString();
        });
      }
    } finally {
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    _shouldCancel = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.borderRadiusMid),
          topRight: Radius.circular(AppTheme.borderRadiusMid),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: AppTheme.elementSpacing.h),

            // Title
            Text(
              widget.createBlocktankChannel
                  ? "Create Blocktank Channel"
                  : "Open Lightning Channel",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppTheme.cardPadding.h),

            if (_isLoading) ...[
              _buildLoadingState(),
            ] else if (_errorMessage != null) ...[
              _buildErrorState(),
            ] else if (_progress != null) ...[
              _buildProgressState(),
            ] else if (_channelRequest != null) ...[
              _buildChannelDetails(),
            ],

            SizedBox(height: AppTheme.cardPadding.h),

            // Action buttons
            if (!_isLoading && _progress?.isCompleted != true) ...[
              Row(
                children: [
                  Expanded(
                    child: LongButtonWidget(
                      title: "Cancel",
                      onTap: () => Navigator.of(context).pop(),
                      buttonType: ButtonType.transparent,
                    ),
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w),
                  Expanded(
                    child: LongButtonWidget(
                      title: _progress != null ? "Opening..." : "Open Channel",
                      onTap: _progress != null ? null : _openChannel,
                      buttonType: ButtonType.solid,
                      state: _progress != null
                          ? ButtonState.loading
                          : ButtonState.idle,
                    ),
                  ),
                ],
              ),
            ],

            // Safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(AppTheme.cardPadding.w),
      child: Column(
        children: [
          dotProgress(context),
          SizedBox(height: AppTheme.elementSpacing.h),
          Text(
            "Loading channel details...",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: EdgeInsets.all(AppTheme.cardPadding.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 48.r,
          ),
          SizedBox(height: AppTheme.elementSpacing.h),
          Text(
            "Error loading channel details",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.elementSpacing.h),
          Text(
            _errorMessage ?? "Unknown error occurred",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressState() {
    final progress = _progress!;
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.cardPadding.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
      ),
      child: Column(
        children: [
          if (progress.progress != null) ...[
            LinearProgressIndicator(
              value: progress.progress,
              backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
              valueColor:
                  AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
          ],
          if (progress.isCompleted && progress.errorMessage == null) ...[
            Icon(
              Icons.check_circle,
              color: AppTheme.successColor,
              size: 48.r,
            ),
          ] else if (progress.errorMessage != null) ...[
            Icon(
              Icons.error,
              color: theme.colorScheme.error,
              size: 48.r,
            ),
          ] else ...[
            dotProgress(context),
          ],
          SizedBox(height: AppTheme.elementSpacing.h),
          Text(
            progress.message,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          if (progress.errorMessage != null) ...[
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              progress.errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChannelDetails() {
    final request = _channelRequest!;
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.cardPadding.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Channel Details",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: AppTheme.elementSpacing.h),
          _buildDetailRow("Provider", _extractProviderName(request.callback)),
          if (request.localAmt != null)
            _buildDetailRow("Local Amount", "${request.localAmt} sats"),
          if (request.pushAmt != null && request.pushAmt! > 0)
            _buildDetailRow("Push Amount", "${request.pushAmt} sats"),
          _buildDetailRow("Channel Type", "Private"),
          SizedBox(height: AppTheme.elementSpacing.h),
          Container(
            padding: EdgeInsets.all(AppTheme.elementSpacing.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                  size: 20.r,
                ),
                SizedBox(width: AppTheme.elementSpacing.w),
                Expanded(
                  child: Text(
                    "This will open a Lightning channel with the provider. You'll be able to send and receive Lightning payments instantly.",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing.h * 0.5),
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

  String _extractProviderName(String callbackUrl) {
    try {
      final uri = Uri.parse(callbackUrl);
      final host = uri.host;

      // Extract meaningful provider names
      if (host.contains('blocktank')) return 'Blocktank';
      if (host.contains('lnbits')) return 'LNbits';
      if (host.contains('lightning')) return 'Lightning Service';

      return host;
    } catch (e) {
      return 'Lightning Service Provider';
    }
  }
}

// Extension to show the bottom sheet easily
extension ChannelOpeningSheetExtension on BuildContext {
  Future<void> showChannelOpeningSheet(
    String lnurlString, {
    VoidCallback? onChannelOpened,
  }) async {
    await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChannelOpeningSheet(
        lnurlString: lnurlString,
        onChannelOpened: onChannelOpened,
      ),
    );
  }

  Future<void> showBlocktankChannelSheet({
    int localAmount = 20000,
    int pushAmount = 0,
    VoidCallback? onChannelOpened,
  }) async {
    await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChannelOpeningSheet(
        createBlocktankChannel: true,
        localAmount: localAmount,
        pushAmount: pushAmount,
        onChannelOpened: onChannelOpened,
      ),
    );
  }
}
