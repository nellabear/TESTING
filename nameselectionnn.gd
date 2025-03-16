extends Control

signal names_registered(player_names)

# Access to global player count from previous scene
var player_count = 1
var player_names = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get player count from a singleton or autoload
	# For example: player_count = GameData.player_count
	
	# Set up input fields based on player count
	_setup_name_inputs()
	
	# Connect continue button
	$ContinueButton.connect("pressed", _on_continue_button_pressed)

# Setup name input fields based on player count
func _setup_name_inputs():
	# Hide all name inputs initially
	for i in range(1, 5):
		var input_container = get_node("VBoxContainer/NameInputs/Player" + str(i) + "Container")
		input_container.visible = false
	
	# Show only the required number of inputs
	for i in range(1, player_count + 1):
		var input_container = get_node("VBoxContainer/NameInputs/Player" + str(i) + "Container")
		input_container.visible = true
		
		# Set default names
		var input_field = input_container.get_node("Player" + str(i) + "Name")
		input_field.text = "Player " + str(i)

# Handle continue button pressed - collect names and move to game selection
func _on_continue_button_pressed():
	# Collect player names
	player_names.clear()
	
	for i in range(1, player_count + 1):
		var input_container = get_node("VBoxContainer/NameInputs/Player" + str(i) + "Container")
		var input_field = input_container.get_node("Player" + str(i) + "Name")
		var name = input_field.text.strip_edges()
		
		# Use default name if empty
		if name.is_empty():
			name = "Player " + str(i)
			
		player_names.append(name)
	
	# Store names in a singleton or autoload
	# For example: GameData.player_names = player_names
	
	emit_signal("names_registered", player_names)
	
	# Change to game selection scene
	get_tree().change_scene_to_file("res://HOST.tscn")
