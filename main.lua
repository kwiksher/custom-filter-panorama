local _W = display.contentWidth
local _H = display.contentHeight
display.setStatusBar( display.HiddenStatusBar )
-- Setup
display.setDefault( 'isShaderCompilerVerbose', true )
-- local kernel = require "kernel_filter_custom_moon"
local kernel = require "kernel_filter_custom_panorama"
graphics.defineEffect( kernel )
-----------------------
--
local image = display.newImage( "equirectangular.jpg" )
local text  = display.newText ("Hello (^^", 0, 0, native.systemFont, 24)
text:setFillColor( 1,1,0 )

local text1  = display.newText ("Test〜〜〜", -_W + 100, _H/2-100, native.systemFont, 24)
text1:setFillColor( 0,1,1 )

local text2  = display.newText ("Kwik", _W-100, 100, native.systemFont, 24)
text2:setFillColor( 1,0,1 )
-------------------------
-- the image is ready
-------------------------
-- image:translate( 100, 0)
--
local snapshot = display.newSnapshot(image.width, image.height)
snapshot.group:insert(image)
snapshot.group:insert(text)
snapshot.group:insert(text1)
snapshot.group:insert(text2)

snapshot.x = _W/2
snapshot.y = _H/2
snapshot:scale(0.5, 0.9)

snapshot.fill.effect = "filter.custom.panorama"

-- Apply filter
-- snapshot.fill.effect = "filter.custom.moon"
-- snapshot.fill.effect.speedMoonX =0.01
-- snapshot.fill.effect.speedMoonY =0.04
-- snapshot.fill.effect.speedSun =0.2
-- snapshot.fill.effect.moonTime =0
