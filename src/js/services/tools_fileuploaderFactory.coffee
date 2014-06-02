###
The angular file upload module
@author: nerv
@version: 0.2.9.5, 2013-12-02
###
app = angular.module("TechGrindApp.services.tools_fileUploaderFactory", [])
app.factory "tools_fileUploaderFactory", [
  "$compile"
  "$rootScope"
  "$http"
  "$window"
  ($compile, $rootScope, $http, $window) ->
    Uploader = (params) ->
      angular.extend this,
        scope: $rootScope
        url: "/"
        alias: "file"
        queue: []
        headers: {}
        progress: null
        autoUpload: false
        removeAfterUpload: false
        method: "POST"
        filters: []
        formData: []
        isUploading: false
        _nextIndex: 0
        _timestamp: Date.now()
      , params
      
      # add the base filter
      @filters.unshift @_filter
      @scope.$on "file:add", ((event, items, options) ->
        event.stopPropagation()
        @addToQueue items, options
        return
      ).bind(this)
      @bind "beforeupload", Item::_beforeupload
      @bind "in:progress", Item::_progress
      @bind "in:success", Item::_success
      @bind "in:error", Item::_error
      @bind "in:complete", Item::_complete
      @bind "changedqueue", @_changedQueue
      @bind "in:progress", @_progress
      @bind "in:complete", @_complete
      return
    
    ###
    The base filter. If returns "true" an item will be added to the queue
    @param {File|Input} item
    @returns {boolean}
    ###
    
    ###
    Registers a event handler
    @param {String} event
    @param {Function} handler
    ###
    
    ###
    Triggers events
    @param {String} event
    @param {...*} [some]
    ###
    
    ###
    Checks a support the html5 uploader
    @returns {Boolean}
    ###
    
    ###
    Adds items to the queue
    @param {FileList|File|Input} items
    @param {Object} [options]
    ###
    
    ###
    Remove items from the queue. Remove last: index = -1
    @param {Item|Number} value
    ###
    
    ###
    Clears the queue
    ###
    
    ###
    Returns a index of item from the queue
    @param item
    @returns {Number}
    ###
    
    ###
    Returns not uploaded items
    @returns {Array}
    ###
    
    ###
    Returns items ready for upload
    @returns {Array}
    ###
    
    ###
    Upload a item from the queue
    @param {Item|Number} value
    ###
    
    ###
    Uploads all not uploaded items of queue
    ###
    
    ###
    Returns the total progress
    @param {Number} [value]
    @returns {Number}
    ###
    
    ###
    The 'in:progress' handler
    ###
    
    ###
    The 'in:complete' handler
    ###
    
    ###
    The 'changedqueue' handler
    ###
    
    ###
    The XMLHttpRequest transport
    ###
    
    ###
    The IFrame transport
    ###
    
    # remove all but the INPUT file type
    # prevent memory leaks
    # old IE
    
    ###
    Checks whether upload successful
    @param {Number} status
    @returns {Boolean}
    ###
    
    ###
    Transforms the server response
    @param {*} response
    @returns {*}
    ###
    
    # item of queue
    Item = (params) ->
      
      # fix for old browsers
      if angular.isElement(params.file)
        input = angular.element(params.file)
        clone = $compile(input.clone())(params.uploader.scope)
        form = angular.element("<form style=\"display: none;\" />")
        iframe = angular.element("<iframe name=\"iframeTransport" + Date.now() + "\">")
        value = input.val()
        params.file =
          lastModifiedDate: null
          size: null
          type: "like/" + value.replace(/^.+\.(?!\.)|.*/, "")
          name: value.match(/[^\\]+$/)[0]
          _form: form

        input.after(clone).after form
        form.append(input).append iframe
      angular.extend this,
        progress: null
        isUploading: false
        isUploaded: false
        isComplete: false
        isReady: false
        index: null
      , params
      return
    "use strict"
    Uploader:: =
      _filter: (item) ->
        (if angular.isElement(item) then true else !!item.size)

      bind: (event, handler) ->
        @scope.$on @_timestamp + ":" + event, handler.bind(this)
        this

      trigger: (event, some) ->
        arguments_[0] = @_timestamp + ":" + event
        @scope.$broadcast.apply @scope, arguments_
        this

      hasHTML5: !!($window.File and $window.FormData)
      addToQueue: (items, options) ->
        length = @queue.length
        angular.forEach (if "length" of items then items else [items]), ((item) ->
          isValid = (if not @filters.length then true else @filters.every((filter) ->
            filter.call this, item
          , this))
          if isValid
            item = new Item(angular.extend(
              url: @url
              alias: @alias
              headers: angular.copy(@headers)
              formData: angular.copy(@formData)
              removeAfterUpload: @removeAfterUpload
              method: @method
              uploader: this
              file: item
            , options))
            @queue.push item
            @trigger "afteraddingfile", item
          return
        ), this
        if @queue.length isnt length
          @trigger "afteraddingall", @queue
          @trigger "changedqueue", @queue
        @autoUpload and @uploadAll()
        this

      removeFromQueue: (value) ->
        index = (if angular.isObject(value) then @getIndexOfItem(value) else value)
        item = @queue.splice(index, 1)[0]
        item._destroyForm()
        @trigger "changedqueue", item
        this

      clearQueue: ->
        @queue.forEach ((item) ->
          item._destroyForm()
          return
        ), this
        @queue.length = 0
        @trigger "changedqueue", @queue
        this

      getIndexOfItem: (item) ->
        @queue.indexOf item

      getNotUploadedItems: ->
        @queue.filter (item) ->
          not item.isComplete


      getReadyItems: ->
        @queue.filter((item) ->
          item.isReady and not item.isUploading
        ).sort (item1, item2) ->
          item1.index - item2.index


      uploadItem: (value) ->
        index = (if angular.isObject(value) then @getIndexOfItem(value) else value)
        item = @queue[index]
        transport = (if item._hasForm() then "_iframeTransport" else "_xhrTransport")
        item.index = item.index or @_nextIndex++
        item.isReady = true
        return this  if @isUploading
        @isUploading = true
        this[transport] item
        this

      uploadAll: ->
        items = @getNotUploadedItems().filter((item) ->
          not item.isUploading
        )
        items.forEach ((item) ->
          item.index = item.index or @_nextIndex++
          item.isReady = true
          return
        ), this
        items.length and @uploadItem(items[0])
        this

      _getTotalProgress: (value) ->
        return value or 0  if @removeAfterUpload
        notUploaded = @getNotUploadedItems().length
        uploaded = (if notUploaded then @queue.length - notUploaded else @queue.length)
        ratio = 100 / @queue.length
        current = (value or 0) * ratio / 100
        Math.round uploaded * ratio + current

      _progress: (event, item, progress) ->
        result = @_getTotalProgress(progress)
        @progress = result
        @trigger "progressall", result
        @scope.$$phase or @scope.$apply()
        return

      _complete: ->
        item = @getReadyItems()[0]
        @isUploading = false
        if angular.isDefined(item)
          @uploadItem item
          return
        @progress = @_getTotalProgress()
        @trigger "completeall", @queue
        @scope.$$phase or @scope.$apply()
        return

      _changedQueue: ->
        @progress = @_getTotalProgress()
        @scope.$$phase or @scope.$apply()
        return

      _xhrTransport: (item) ->
        xhr = new XMLHttpRequest()
        form = new FormData()
        that = this
        @trigger "beforeupload", item
        item.formData.forEach (obj) ->
          angular.forEach obj, (value, key) ->
            form.append key, value
            return

          return

        form.append item.alias, item.file
        xhr.upload.onprogress = (event) ->
          progress = (if event.lengthComputable then event.loaded * 100 / event.total else 0)
          that.trigger "in:progress", item, Math.round(progress)
          return

        xhr.onload = ->
          response = that._transformResponse(xhr.response)
          event = (if that._isSuccessCode(xhr.status) then "success" else "error")
          that.trigger "in:" + event, xhr, item, response
          that.trigger "in:complete", xhr, item, response
          return

        xhr.onerror = ->
          that.trigger "in:error", xhr, item
          that.trigger "in:complete", xhr, item
          return

        xhr.onabort = ->
          that.trigger "in:complete", xhr, item
          return

        xhr.open item.method, item.url, true
        angular.forEach item.headers, (value, name) ->
          xhr.setRequestHeader name, value
          return

        xhr.send form
        return

      _iframeTransport: (item) ->
        form = item.file._form
        iframe = form.find("iframe")
        input = form.find("input")
        that = this
        @trigger "beforeupload", item
        angular.forEach input, (element) ->
          element.type isnt "file" and angular.element(element).remove()
          return

        input.prop "name", item.alias
        item.formData.forEach (obj) ->
          angular.forEach obj, (value, key) ->
            form.append angular.element("<input type=\"hidden\" name=\"" + key + "\" value=\"" + value + "\" />")
            return

          return

        form.prop
          action: item.url
          method: item.method
          target: iframe.prop("name")
          enctype: "multipart/form-data"
          encoding: "multipart/form-data"

        iframe.unbind().bind "load", ->
          xhr =
            response: iframe.contents()[0].body.innerHTML
            status: 200
            dummy: true

          response = that._transformResponse(xhr.response)
          that.trigger "in:complete", xhr, item, response
          return

        form[0].submit()
        return

      _isSuccessCode: (status) ->
        (status >= 200 and status < 300) or status is 304

      _transformResponse: (response) ->
        $http.defaults.transformResponse.forEach (transformFn) ->
          response = transformFn(response)
          return

        response

    Item:: =
      remove: ->
        @uploader.removeFromQueue this
        return

      upload: ->
        @uploader.uploadItem this
        return

      _hasForm: ->
        !!(@file and @file._form)

      _destroyForm: ->
        @_hasForm() and @file._form.remove()
        return

      _beforeupload: (event, item) ->
        item.isUploaded = false
        item.isUploading = true
        item.isComplete = false
        item.progress = null
        return

      _progress: (event, item, progress) ->
        item.progress = progress
        item.uploader.trigger "progress", item, progress
        return

      _success: (event, xhr, item, response) ->
        item.isUploaded = true
        item.isUploading = false
        item.isComplete = true
        item.isReady = false
        item.progress = 100
        item.index = null
        item.uploader.trigger "success", xhr, item, response
        return

      _error: (event, xhr, item, response) ->
        item.isUploaded = false
        item.isUploading = false
        item.isComplete = true
        item.isReady = false
        item.index = null
        item.uploader.trigger "error", xhr, item, response
        return

      _complete: (event, xhr, item, response) ->
        item.isUploaded = item.uploader._isSuccessCode(xhr.status)
        item.isUploading = false
        item.isComplete = true
        item.isReady = false
        item.index = null
        item.uploader.trigger "complete", xhr, item, response
        item.removeAfterUpload and item.remove()
        return

    return (
      create: (params) ->
        new Uploader(params)

      hasHTML5: Uploader::hasHTML5
    )
]
