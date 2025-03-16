func init_scores():
	scores.clear()
	for i in range(player_count):
		scores.append(0)

# Reset all game data for a new game
func reset_game():
	player_names.clear()
	scores.clear()
	current_player_index = 0
	current_question_index = 0

# Get current player name
func get_current_player_name():
	return player_names[current_player_index]

# Move to next player's turn
func next_player():
	current_player_index = (current_player_index + 1) % player_count
	return current_player_index

# Add points to current player's score
func add_score(points):
	scores[current_player_index] += points

# Get string with all player scores
func get_score_summary():
	var summary = ""
	for i in range(player_count):
		summary += player_names[i] + ": " + str(scores[i]) + "\n"
	return summary
