// Lerp the player's aesthetic health towards their actual health
fake_hp = lerp(fake_hp, obj_player_manager.hp, 0.2);

// If the two values are close enough, just make them equal
if(abs(fake_hp - obj_player_manager.hp) <= 0.1)
{
	fake_hp = obj_player_manager.hp;
}