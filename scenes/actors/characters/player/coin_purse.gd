@icon("res://assets/icons/icon_purse.png")
class_name CoinPurse extends Node

var default_jump_tokens := 5
# var default_dash_tokens := 0

var num_jump_tokens := default_jump_tokens
var player: Player


func init(_player: Player) -> void:
	self.player = _player

	# player.connect_jump_to_purse(_on_player_jumped)
	player.connect_signal_to_callback("jumped", _on_player_jumped)


func _on_player_jumped() -> void:
	num_jump_tokens -= 1
	print(num_jump_tokens, " tokens left")
