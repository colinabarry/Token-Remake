extends Area2D

var standing_on_platform := false

var current_tilemap = null
var current_tile_data = null


func _on_body_shape_entered(
	body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int
) -> void:
	current_tilemap = body as TileMap

	if current_tilemap:
		var current_tile_coords: Vector2i = current_tilemap.get_coords_for_body_rid(body_rid)
		current_tile_data = current_tilemap.get_cell_tile_data(0, current_tile_coords) as TileData

		if current_tile_data:
			standing_on_platform = current_tile_data.get_custom_data_by_layer_id(0)
	# print_debug(standing_on_platform)


func _on_body_shape_exited(
	body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int
) -> void:
	pass
