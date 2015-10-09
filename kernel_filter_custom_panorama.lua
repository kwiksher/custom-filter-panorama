-- Sample code is licensed under the MIT License, the same license that Lua is licensed under:
-- Copyright © 2011-2015 Kwiksher LLP.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local kernel = {}
kernel.language = "glsl"
kernel.category = "filter"
-- By default, the group is "custom"
-- kernel.group = "custom"
-----------------------------
kernel.name = "panorama"
------------------------------
kernel.isTimeDependent = true
kernel.fragment =
[[

uniform vec2 resolution = vec2(0.2,0.1);
uniform float fov       = 30.0;
uniform float yaw       = -30.0;
uniform float pitch     = -40.0;

const float M_PI    = 3.141592653589793238462643;
const float M_TWOPI = 6.283185307179586476925286;

mat3 rotationMatrix(vec2 euler)
{
  vec2 se = sin(euler);
  vec2 ce = cos(euler);

  return  mat3(ce.x, 0, -se.x,  0, 1, 0,    se.x, 0, ce.x) *
      mat3(1, 0, 0, 0, ce.y, -se.y, 0, se.y, ce.y);
}
vec3 toCartesian( vec2 st )
{
  return normalize(vec3(st.x, st.y, 0.5 / tan(0.5 * radians(fov))));
}
vec2 toSpherical(vec3 cartesianCoord)
{
  vec2 st = vec2(
    atan(cartesianCoord.x, cartesianCoord.z),
    acos(cartesianCoord.y)
  );
  if(st.x < 0.0)
    st.x += M_TWOPI;
  return st;
}

P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
{
  P_RANDOM vec4 color;
  vec2 sphericalCoord = texCoord.xy / resolution - vec2(0.5);
  sphericalCoord.y   *= -resolution.y / resolution.x;
  vec3 cartesianCoord = rotationMatrix(radians(vec2(yaw + 180. + CoronaTotalTime*10, -pitch))) * toCartesian(sphericalCoord);
  //
  color = texture2D(CoronaSampler0, toSpherical( cartesianCoord )/vec2(M_TWOPI, M_PI));
	return CoronaColorScale(color);
 }
]]
--
return kernel
