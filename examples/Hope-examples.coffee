###
# Hope Promises Examples
###

## Promises definitions
# Basic
sync = (value) ->
  # Create promise
  promise = new Hope.Promise()
  # exec the action
  _double promise, value
  # return promise
  promise

async = (value, seconds = 1) ->
  promise = new Hope.Promise()
  setTimeout (->
    _double promise, value
    ), seconds * 10000
  promise

# Shielding Function
_double = (promise, value) ->
  # Error case
  promise.done "ERROR! Maximum value is 32",value if value > 32
  # Normal case
  promise.done null, (value * 2)

# Basic promise with shield function
sync_compact = (value) ->
  promise = new Hope.Promise()
  # embed the function code
  promise.done "ERROR! Maximum value is 32",value if value > 32
  promise.done null, (value * 2)
  # finally return the promises
  promise

## Promises in action
# Normal exec
sync(10).then (error, value) ->
  console.error "[sync.1]: ", if error then error else value

sync(10).then (error, value) ->
  console.error "[sync.2 ]: ", if error then error else value

async(16, 2).then (error, value) ->
  console.error "[async.1]: ", if error then error else value

# Join exec (Independent threads)
date = new Date()
Hope.join(
  [
    -> sync 2,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[join]   :", (new Date() - date) + "ms", errors, values

# Chain exec (Unique thread with concatenate actions)
date = new Date()
Hope.chain(
  [
    -> sync 2,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[chain]   :", (new Date() - date) + "ms", errors, values

# Shield exec (Stop flow if one promises can errors)
date = new Date()
Hope.chain(
  [
    -> sync 32,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[chain]   :", (new Date() - date) + "ms", errors, values