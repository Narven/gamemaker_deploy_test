// Store where aesthetic end of the bar is
fake_hp = obj_player_manager.hp;

// Hold whether or not the warning is showing as well as the surface ID for the warning text
is_warning = false;
warning_text = obj_text_deformer.create_text_skewed("LOW HP", 5, 1, fnt_rationale_regular_30, true, 2);

// Store the surface ID of the score
score_text = obj_text_deformer.create_text_skewed(obj_game_manager.points, 5, 1, fnt_hp, true, 3);

// Store the player's score from last frame to be checked against
check_score = -1;