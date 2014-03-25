'use strict';
require.config
  baseUrl: '../'
  paths:
    'jasmine': 'Tests/lib/jasmine-2.0.0/jasmine'
    'jasmine-html': 'Tests/lib/jasmine-2.0.0/jasmine-html'
    'boot': 'Tests/lib/jasmine-2.0.0/boot'
  shim:
    'jasmine':
      exports: 'jasmine'
    'jasmine-html':
      deps: ['jasmine']
      exports: 'jasmine'
    'boot':
      deps: ['jasmine', 'jasmine-html']
      exports: 'jasmine'

specs = [
  'modelCountry'
  'modelNested'
  'modelCreditCard'
  'modelAddress'
  'viewSummary'
  'viewEnchanced'
  'viewAddress'
  'viewCreditCard'
  'viewSend'
]

specs = _.map specs, (el) ->
  el = 'Tests/spec/' + el

require ['boot'], ->
  require specs, ->
    window.onload();