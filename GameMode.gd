extends Control

signal game_settings_selected(difficulty, question_count)

enum Difficulty {EASY, AVERAGE, HARD}

var selected_difficulty = Difficulty.EASY
var question_count = 10 # Default value

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect difficulty buttons
	$VBoxContainer/DifficultyButtons/EasyButton.connect("pressed", _on_difficulty_button_pressed.bind(Difficulty.EASY))
	$VBoxContainer/DifficultyButtons/AverageButton.connect("pressed", _on_difficulty_button_pressed.bind(Difficulty.AVERAGE))
	$VBoxContainer/DifficultyButtons/HardButton.connect("pressed", _on_difficulty_button_pressed.bind(Difficulty.HARD))
	
	# Connect question count slider
	$VBoxContainer/QuestionCountContainer/QuestionSlider.connect("value_changed", _on_question_slider_changed)
	
	# Connect start button
	$VBoxContainer/StartButton.connect("pressed", _on_start_button_pressed)
	
	# Set initial selection
	_update_difficulty_selection(Difficulty.EASY)
	
	# Set up question slider (max 300 as per requirements)
	$VBoxContainer/QuestionCountContainer/QuestionSlider.max_value = 300
	$VBoxContainer/QuestionCountContainer/QuestionSlider.min_value = 5
	$VBoxContainer/QuestionCountContainer/QuestionSlider.value = 10
	_update_question_count_label(10)

# Handle difficulty button pressed
func _on_difficulty_button_pressed(difficulty):
	_update_difficulty_selection(difficulty)

# Update the UI to reflect the current difficulty selection
func _update_difficulty_selection(difficulty):
	selected_difficulty = difficulty
	
	# Reset all button colors
	$VBoxContainer/DifficultyButtons/EasyButton.modulate = Color.WHITE
	$VBoxContainer/DifficultyButtons/AverageButton.modulate = Color.WHITE
	$VBoxContainer/DifficultyButtons/HardButton.modulate = Color.WHITE
	
	# Highlight selected button
	match difficulty:
		Difficulty.EASY:
			$VBoxContainer/DifficultyButtons/EasyButton.modulate = Color.GREEN
			$VBoxContainer/SelectedDifficultyLabel.text = "Selected: Easy Mode"
		Difficulty.AVERAGE:
			$VBoxContainer/DifficultyButtons/AverageButton.modulate = Color.GREEN
			$VBoxContainer/SelectedDifficultyLabel.text = "Selected: Average Mode"
		Difficulty.HARD:
			$VBoxContainer/DifficultyButtons/HardButton.modulate = Color.GREEN
			$VBoxContainer/SelectedDifficultyLabel.text = "Selected: Hard Mode"

# Handle question slider changed
func _on_question_slider_changed(value):
	question_count = int(value)
	_update_question_count_label(question_count)

# Update the question count label
func _update_question_count_label(count):
	$VBoxContainer/QuestionCountContainer/QuestionCountLabel.text = "Questions: " + str(count)

# Handle start button pressed - move to the appropriate quiz scene
func _on_start_button_pressed():
	# Store settings in a singleton or autoload
	# For example:
	# GameData.difficulty = selected_difficulty
	# GameData.question_count = question_count
	
	emit_signal("game_settings_selected", selected_difficulty, question_count)
	
	# Change to the appropriate quiz scene based on difficulty
	var scene_path = ""
	match selected_difficulty:
		Difficulty.EASY:
			scene_path = "res://scenes/easy_quiz_game.tscn"
		Difficulty.AVERAGE:
			scene_path = "res://scenes/average_quiz_game.tscn"
		Difficulty.HARD:
			scene_path = "res://scenes/hard_quiz_game.tscn"
	
	get_tree().change_scene_to_file(scene_path)
