@icon("res://assets/icons/icon_purse.png")
class_name CoinPurse extends Area2D

# var default_jump_tokens := 5
# var default_dash_tokens := 0

var player: Player
var num_jump_tokens


func init(_player: Player) -> void:
	add_to_group("token_collector")
	self.player = _player
	num_jump_tokens = player.default_jump_tokens

	area_entered.connect(_on_area_entered)
	player.connect_signal_to_callback("jumped", _on_player_jumped)


func _collect_token(token: BaseToken) -> void:
	match token.token_type:
		BaseToken.TokenType.JUMP_TOKEN:
			num_jump_tokens += 1
			print(num_jump_tokens, " tokens left")


func _on_player_jumped() -> void:
	num_jump_tokens -= 1
	print(num_jump_tokens, " tokens left")


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("token"):
		_collect_token(area as BaseToken)
