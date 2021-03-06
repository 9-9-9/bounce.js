Matrix4D = require "../math/matrix4d"
Vector2D = require "../math/vector2d"

Component = require "./index"

class Skew extends Component
  from:
    x: 0
    y: 0

  to:
    x: 20
    y: 0

  constructor: ->
    super
    @fromVector = new Vector2D @from.x, @from.y
    @toVector = new Vector2D @to.x, @to.y
    @diff = @toVector.clone().subtract @fromVector

  getMatrix: (degreesX, degreesY) ->
    radiansX = (degreesX / 180) * Math.PI
    radiansY = (degreesY / 180) * Math.PI

    tx = Math.tan radiansX
    ty = Math.tan radiansY
    new Matrix4D [
      1, tx, 0, 0
      ty, 1, 0, 0
      0,  0, 1, 0
      0,  0, 0, 1
    ]

  getEasedMatrix: (ratio) ->
    easedRatio = @calculateEase ratio
    easedVector = @fromVector.clone().add @diff.clone().multiply(easedRatio)
    @getMatrix easedVector.x, easedVector.y

module.exports = Skew