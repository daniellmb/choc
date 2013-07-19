testHelper = require('./test_helper')
{puts,inspect} = require("util"); pp = (x) -> puts inspect(x, null, 1000)
esprima = require("esprima")
assert = require('assert')
should = require("should")
choc = require("../src/choc")
readable = require("../src/readable")
coffee = require("coffee-script")

describe 'Choc', ->
  it 'does something useful', () ->
    src = """
    function add(a, b) {
      return a + b;
    }
    
    var x = add(1, 2);
    var y = x;
    """
    newSource   = choc.generateAnnotatedSource(src)
    puts newSource
    assert.ok true
 

  it.only 'member functions', () ->
    src = """
      var bob = {}
      bob.add = function(a, b){
        return a + b;
      }

      var x = bob.add(1, 2) + bob.add(3, 4);
      var foo = "hellomom";
      var y = x;
    """
    newSource   = choc.generateAnnotatedSource(src)
    puts newSource
    assert.ok true
 

