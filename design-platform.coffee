http = require 'http'
express = require 'express'
backbone = require 'backbone'
jquery = require 'jquery'

backbone.$ = jquery

View = new backbone.View.extend
	tagName: 'section'
	id: 'design-platform'

server = http.createServer (request, response) ->
	view = new backbone.View
	view.$el.append jquery('<div class="yaya">')
	response.writeHead 200
	response.write view.render().$el.html()
	response.end()

server.listen 3000




