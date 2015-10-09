local kernel = {}

kernel.language = "glsl"

kernel.category = "filter"

-- By default, the group is "custom"
-- kernel.group = "custom"

kernel.name = "example"

-- Expose effect parameters using vertex data
kernel.vertexData =
{
	{
		name = "intensity", -- The property name exposed to Lua
		default = 0, 
		min = 0,
		max = 1,
		index = 0, -- This corresponds to CoronaVertexUserData.x
	},
}

kernel.fragment =
[[
P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
{
	P_COLOR float brightness = CoronaVertexUserData.x;

	P_COLOR vec4 texColor = texture2D( CoronaSampler0, texCoord );

	// texColor has pre-multiplied alpha, so convert brightness to match
	brightness = brightness * texColor.a;

	// Add the brightness
	texColor.xyz += brightness;

	// Modulate by object's alpha/tint
	return CoronaColorScale( texColor );
}
]]

return kernel
