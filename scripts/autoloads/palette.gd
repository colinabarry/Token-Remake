@tool
extends Node

var default_source: Texture2D = preload("res://assets/textures/duel-1x.png")
# var colors: Array[Array]

# var shades := 8


func calculate_palette(source := default_source, num_shades := 8) -> Array[Array]:
	var colors: Array[Array]
	var source_image := source.get_image()
	var source_width := source.get_width()
	var num_colors = source_width / num_shades

	for color in range(num_colors):
		# print("color: ", color)
		colors.append([])
		for shade in range(num_shades):
			# print("shade: ", shade)
			var linear_index: int = (color * num_shades) + shade
			# print(linear_index)
			colors[color].append(source_image.get_pixel(linear_index, 0))
			# print(color + shade)

	# for color in colors:
	# 	print(color)
	return colors
