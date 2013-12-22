###
# Hope Promises Examples
###

# Basic Promise
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
for

# Shielding Function
_double = (promise, value) ->
  # Error case
  promise.done "ERROR! Maximum value is 32",value if value > 32
  # Normal case
  promise.done null, (value * 2)


# BASIC
sync(10).then (error, value) ->
  console.error "[sync.1]: ", if error then error else value

sync(10).then (error, value) ->
  console.error "[sync.2 ]: ", if error then error else value

async(16, 2).then (error, value) ->
  console.error "[async.1]: ", if error then error else value



# JOIN - independent threads
date = new Date()
Hope.join(
  [
    -> sync 2,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[join]   :", (new Date() - date) + "ms", errors, values

# CHAIN - Unique thread with concatenate actions
date = new Date()
Hope.chain(
  [
    -> sync 2,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[chain]   :", (new Date() - date) + "ms", errors, values

# SHIELD
date = new Date()
Hope.chain(
  [
    -> sync 32,
    -> async 4, 2
    -> aynsc 3, 3
  ]
  ).then (errors,value) ->
    console.error "[chain]   :", (new Date() - date) + "ms", errors, values




