{exec} = require 'child_process'
task 'sbuild', 'Build project from *.coffee to *.js', ->
	exec 'coffee --lint --compile ./', (err, stdout, stderr) ->
		throw err if err
		console.log stdout + stderr
