// BitNet Web App Resource Preloader
// This script helps optimize web performance by preloading essential resources

// List of critical resources to preload
const CRITICAL_RESOURCES = [
  'main.dart.js',
  'flutter.js',
  'assets/fonts/MaterialIcons-Regular.otf',
  'assets/images/logoclean.png',
  'assets/images/logotransparent.png',
];

// List of resources to preload after initial render
const SECONDARY_RESOURCES = [
  'assets/AssetManifest.json',
  'assets/FontManifest.json',
  'assets/packages/cupertino_icons/assets/CupertinoIcons.ttf',
];

// Flag to track if preloading is supported
let preloadSupported = 'HTMLLinkElement' in window && 'relList' in HTMLLinkElement.prototype && 
                      HTMLLinkElement.prototype.relList.supports('preload');

// Preload critical resources
function preloadCriticalResources() {
  if (!preloadSupported) return;
  
  CRITICAL_RESOURCES.forEach(resource => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.href = resource;
    link.as = getResourceType(resource);
    link.crossOrigin = 'anonymous';
    document.head.appendChild(link);
  });
}

// Preload secondary resources
function preloadSecondaryResources() {
  if (!preloadSupported) return;
  
  SECONDARY_RESOURCES.forEach(resource => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.href = resource;
    link.as = getResourceType(resource);
    link.crossOrigin = 'anonymous';
    document.head.appendChild(link);
  });
}

// Determine resource type
function getResourceType(resource) {
  const extension = resource.split('.').pop().toLowerCase();
  
  switch (extension) {
    case 'js':
      return 'script';
    case 'css':
      return 'style';
    case 'otf':
    case 'ttf':
    case 'woff':
    case 'woff2':
      return 'font';
    case 'png':
    case 'jpg':
    case 'jpeg':
    case 'gif':
    case 'webp':
    case 'svg':
      return 'image';
    case 'json':
      return 'fetch';
    default:
      return 'fetch';
  }
}

// Priority loading with Resource Hints
document.addEventListener('DOMContentLoaded', function() {
  // Preload critical resources immediately
  preloadCriticalResources();
  
  // Wait for initial render before loading secondary resources
  setTimeout(preloadSecondaryResources, 1000);
  
  // Optimize connection for important domains
  prefetchDomains();
});

// Prefetch DNS for important domains
function prefetchDomains() {
  const domains = [
    'fonts.googleapis.com',
    'fonts.gstatic.com',
    'firebaseapp.com',
    'firebase-settings.crashlytics.com',
    'firebase.googleapis.com'
  ];
  
  domains.forEach(domain => {
    const link = document.createElement('link');
    link.rel = 'dns-prefetch';
    link.href = `//${domain}`;
    document.head.appendChild(link);
  });
}