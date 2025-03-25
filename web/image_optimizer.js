// Image optimization handler for BitNet web app
document.addEventListener('DOMContentLoaded', function() {
  // Find all img elements once the Flutter app is loaded
  setTimeout(() => {
    optimizeImages();
  }, 1000);
});

// Optimize images throughout the page
function optimizeImages() {
  const images = document.querySelectorAll('img');
  
  images.forEach(img => {
    // Skip already processed images
    if (img.getAttribute('data-optimized')) return;
    
    // Mark as processed
    img.setAttribute('data-optimized', 'true');
    
    // Add loading attribute for native lazy loading
    img.setAttribute('loading', 'lazy');
    
    // Only set decoding if the browser supports it
    if ('decoding' in HTMLImageElement.prototype) {
      img.setAttribute('decoding', 'async');
    }
    
    // Add intersection observer for delayed loading
    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const img = entry.target;
            
            // Only load the image when it's in viewport
            if (img.dataset.src) {
              img.src = img.dataset.src;
              delete img.dataset.src;
            }
            
            // Stop observing once loaded
            observer.unobserve(img);
          }
        });
      });
      
      observer.observe(img);
    }
  });
}

// Register a MutationObserver to handle dynamically added images
if ('MutationObserver' in window) {
  const observer = new MutationObserver((mutations) => {
    let shouldOptimize = false;
    
    mutations.forEach(mutation => {
      if (mutation.addedNodes.length) {
        shouldOptimize = true;
      }
    });
    
    if (shouldOptimize) {
      optimizeImages();
    }
  });
  
  // Start observing once Flutter view is created
  setTimeout(() => {
    const flutterView = document.querySelector('flutter-view');
    if (flutterView) {
      observer.observe(flutterView, {
        childList: true,
        subtree: true
      });
    }
  }, 2000);
}