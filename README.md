# custom-filter-panorama

simple demo to view an equirectangle photo by corona SDK

```
local kernel = require "kernel_filter_custom_panorama"
local image = display.newImage( "equirectangular.jpg" )
image.fill.effect = "filter.custom.panorama"
```

## reference
* https://gist.github.com/fieldOfView/5106319
* https://docs.coronalabs.com/daily/guide/graphics/customEffects.html
* https://shader.coronalabs.com/#shaders/moon.frag&textures/512/moon-diffuse.jpg&%5B0.005,0.01,-0.3,1.5%5D