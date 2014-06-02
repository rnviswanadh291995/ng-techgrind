
# I lazily load the images, when they come into view.

# I manage all the images that are currently being
# monitored on the page for lazy loading.

# I maintain a list of images that lazy-loading
# and have yet to be rendered.

# I define the render timer for the lazy loading
# images to that the DOM-querying (for offsets)
# is chunked in groups.

# I cache the window element as a jQuery reference.

# I cache the document document height so that
# we can respond to changes in the height due to
# dynamic content.

# I determine if the window dimension events
# (ie. resize, scroll) are currenlty being
# monitored for changes.

# ---
# PUBLIC METHODS.
# ---
# I start monitoring the given image for visibility
# and then render it when necessary.

# I remove the given image from the render queue.

# Remove the given image from the render queue.

# If removing the given image has cleared the
# render queue, then we can stop monitoring
# the window and the image queue.

# ---
# PRIVATE METHODS.
# ---
# I check the document height to see if it's changed.

# If the render time is currently active, then
# don't bother getting the document height -
# it won't actually do anything.

# If the height has not changed, then ignore -
# no more images could have come into view.

# Cache the new document height.

# I check the lazy-load images that have yet to
# be rendered.

# Log here so we can see how often this
# gets called during page activity.

# Determine the window dimensions.

# Calculate the viewport offsets.

# Query the DOM for layout and seperate the
# images into two different categories: those
# that are now in the viewport and those that
# still remain hidden.

# Update the DOM with new image source values.

# Keep the still-hidden images as the new
# image queue to be monitored.

# Clear the render timer so that it can be set
# again in response to window changes.

# If we've rendered all the images, then stop
# monitoring the window for changes.

# I clear the render timer so that we can easily
# check to see if the timer is running.

# I start the render time, allowing more images to
# be added to the images queue before the render
# action is executed.

# I start watching the window for changes in dimension.

# Listen for window changes.

# Set up a timer to watch for document-height changes.

# I stop watching the window for changes in dimension.

# Stop watching for window changes.

# Stop watching for document changes.

# I start the render time if the window changes.

# Return the public API.

# ------------------------------------------ //
# ------------------------------------------ //

# I represent a single lazy-load image.

# I am the interpolated LAZY SRC attribute of
# the image as reported by AngularJS.

# I determine if the image has already been
# rendered (ie, that it has been exposed to the
# viewport and the source had been loaded).

# I am the cached height of the element. We are
# going to assume that the image doesn't change
# height over time.

# ---
# PUBLIC METHODS.
# ---

# I determine if the element is above the given
# fold of the page.

# If the element is not visible because it
# is hidden, don't bother testing it.

# If the height has not yet been calculated,
# the cache it for the duration of the page.

# Update the dimensions of the element.

# Return true if the element is:
# 1. The top offset is in view.
# 2. The bottom offset is in view.
# 3. The element is overlapping the viewport.

# I move the cached source into the live source.

# I set the interpolated source value reported
# by the directive / AngularJS.

# ---
# PRIVATE METHODS.
# ---
# I load the lazy source value into the actual
# source value of the image element.

# Return the public API.

# I bind the UI events to the scope.

# Start watching the image for changes in its
# visibility.

# Since the lazy-src will likely need some sort
# of string interpolation, we don't want to

# When the scope is destroyed, we need to remove
# the image from the render queue.

# Return the directive configuration.
(->
  app = angular.module("TechGrindApp.directives.lazy-loading-img", [])
  app.directive "bnLazySrc", ($window, $document) ->
    LazyImage = (element) ->
      isVisible = (topFoldOffset, bottomFoldOffset) ->
        return (false)  unless element.is(":visible")
        height = element.height()  if height is null
        top = element.offset().top
        bottom = (top + height)
        ((top <= bottomFoldOffset) and (top >= topFoldOffset)) or ((bottom <= bottomFoldOffset) and (bottom >= topFoldOffset)) or ((top <= topFoldOffset) and (bottom >= bottomFoldOffset))
      render = ->
        isRendered = true
        renderSource()
        return
      setSource = (newSource) ->
        source = newSource
        renderSource()  if isRendered
        return
      renderSource = ->
        element[0].src = source
        return
      source = null
      isRendered = false
      height = null
      isVisible: isVisible
      render: render
      setSource: setSource
    link = ($scope, element, attributes) ->
      lazyImage = new LazyImage(element)
      lazyLoader.addImage lazyImage
      attributes.$observe "bnLazySrc", (newSource) ->
        lazyImage.setSource newSource
        return

      $scope.$on "$destroy", ->
        lazyLoader.removeImage lazyImage
        return

      return
    lazyLoader = (->
      addImage = (image) ->
        images.push image
        startRenderTimer()  unless renderTimer
        startWatchingWindow()  unless isWatchingWindow
        return
      removeImage = (image) ->
        i = 0

        while i < images.length
          if images[i] is image
            images.splice i, 1
            break
          i++
        unless images.length
          clearRenderTimer()
          stopWatchingWindow()
        return
      checkDocumentHeight = ->
        return  if renderTimer
        currentDocumentHeight = doc.height()
        return  if currentDocumentHeight is documentHeight
        documentHeight = currentDocumentHeight
        startRenderTimer()
        return
      checkImages = ->
        console.log "Checking for visible images..."
        visible = []
        hidden = []
        windowHeight = win.height()
        scrollTop = win.scrollTop()
        topFoldOffset = scrollTop
        bottomFoldOffset = (topFoldOffset + windowHeight)
        i = 0

        while i < images.length
          image = images[i]
          if image.isVisible(topFoldOffset, bottomFoldOffset)
            visible.push image
          else
            hidden.push image
          i++
        i = 0

        while i < visible.length
          visible[i].render()
          i++
        images = hidden
        clearRenderTimer()
        stopWatchingWindow()  unless images.length
        return
      clearRenderTimer = ->
        clearTimeout renderTimer
        renderTimer = null
        return
      startRenderTimer = ->
        renderTimer = setTimeout(checkImages, renderDelay)
        return
      startWatchingWindow = ->
        isWatchingWindow = true
        win.on "resize.bnLazySrc", windowChanged
        win.on "scroll.bnLazySrc", windowChanged
        documentTimer = setInterval(checkDocumentHeight, documentDelay)
        return
      stopWatchingWindow = ->
        isWatchingWindow = false
        win.off "resize.bnLazySrc"
        win.off "scroll.bnLazySrc"
        clearInterval documentTimer
        return
      windowChanged = ->
        startRenderTimer()  unless renderTimer
        return
      images = []
      renderTimer = null
      renderDelay = 100
      win = $($window)
      doc = $document
      documentHeight = doc.height()
      documentTimer = null
      documentDelay = 2000
      isWatchingWindow = false
      addImage: addImage
      removeImage: removeImage
    )()
    link: link
    restrict: "A"

  return
).call this
