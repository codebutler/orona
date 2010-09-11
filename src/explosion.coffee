###
Orona, © 2010 Stéphan Kochen

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
###

{floor}        = Math
net            = require './net'
{pack, unpack} = require './struct'


class Explosion
  constructor: (@sim, @x, @y) -> @lifespan = 23
  destroy: ->

  initFromNetwork: (@sim, data, offset) -> @deserialize(data, offset)
  destroyFromNetwork: ->

  serialize: -> pack 'HHB', @x, @y, @lifespan
  deserialize: (data, offset) -> [@x, @y, @lifespan] = unpack 'HHB', data, offset; return 5

  update: -> if @lifespan-- == 0 then @sim.destroy this

  # The tile index to draw.
  getTile: ->
    switch floor(@lifespan / 3)
      when 7 then [20, 3]
      when 6 then [21, 3]
      when 5 then [20, 4]
      when 4 then [21, 4]
      when 3 then [20, 5]
      when 2 then [21, 5]
      when 1 then [18, 4]
      when 0 then [19, 4]


# Networking.
net.registerType 'E', Explosion

# Exports.
module.exports = Explosion