import 'dart:typed_data';
import 'package:bitnet/backbone/services/app_image_cache_service.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CachedAppImage extends StatefulWidget {
  final AppData app;
  final double width;
  final double height;
  final BoxFit fit;
  
  const CachedAppImage({
    super.key,
    required this.app,
    required this.width,
    required this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<CachedAppImage> createState() => _CachedAppImageState();
}

class _CachedAppImageState extends State<CachedAppImage> {
  late final AppImageCacheService _cacheService;
  Uint8List? _imageBytes;
  bool _isLoading = true;
  bool _isSvg = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize cache service with safety check
    try {
      _cacheService = Get.find<AppImageCacheService>();
    } catch (e) {
      // If service not found, register it
      Get.put(AppImageCacheService(), permanent: true);
      _cacheService = Get.find<AppImageCacheService>();
    }
    
    _loadImage();
  }
  
  Future<void> _loadImage() async {
    try {
      Uint8List? bytes;
      
      // First priority: Local asset (no caching needed)
      if (widget.app.iconPath != null) {
        setState(() {
          _isLoading = false;
          _isSvg = widget.app.iconPath!.toLowerCase().endsWith('.svg');
        });
        return;
      }
      
      // Second priority: Firebase Storage
      if (widget.app.useNetworkAsset && widget.app.storageName != null) {
        bytes = await _cacheService.getFirebaseStorageImage(widget.app.storageName!);
      }
      // Third priority: Network favicon
      else if (widget.app.useNetworkImage) {
        bytes = await _cacheService.getFaviconFromUrl(widget.app.url);
      }
      
      if (mounted) {
        setState(() {
          _imageBytes = bytes;
          _isLoading = false;
          // Check if it's SVG based on content
          if (bytes != null && bytes.length > 4) {
            final header = String.fromCharCodes(bytes.take(5));
            _isSvg = header.contains('<?xml') || header.contains('<svg');
          }
        });
      }
    } catch (e) {
      print('Error loading app image: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  Widget _buildImagePlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.apps,
        size: widget.width * 0.5,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
  
  Widget _buildErrorWidget() {
    return GlassContainer(
      width: widget.width,
      height: widget.height,
      borderRadius: BorderRadius.circular(8),
      child: Center(
        child: Icon(
          Icons.public,
          size: widget.width * 0.5,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Builder(
          builder: (context) {
            // Loading state
            if (_isLoading) {
              return _buildImagePlaceholder();
            }
            
            // Local asset
            if (widget.app.iconPath != null) {
              if (_isSvg) {
                return SvgPicture.asset(
                  widget.app.iconPath!,
                  fit: widget.fit,
                  width: widget.width,
                  height: widget.height,
                );
              } else {
                return Image.asset(
                  widget.app.iconPath!,
                  fit: widget.fit,
                  width: widget.width,
                  height: widget.height,
                  errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
                );
              }
            }
            
            // Cached network image
            if (_imageBytes != null) {
              if (_isSvg) {
                return SvgPicture.memory(
                  _imageBytes!,
                  fit: widget.fit,
                  width: widget.width,
                  height: widget.height,
                );
              } else {
                return Image.memory(
                  _imageBytes!,
                  fit: widget.fit,
                  width: widget.width,
                  height: widget.height,
                  errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
                );
              }
            }
            
            // No image available
            return _buildErrorWidget();
          },
        ),
      ),
    );
  }
}