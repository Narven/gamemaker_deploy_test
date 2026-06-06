// Destroy the wave sequence when it's finished
if(wave_prompt != undefined)
{
	if(layer_sequence_is_finished(wave_prompt))
	{
		layer_sequence_destroy(wave_prompt);
		wave_prompt = undefined;
	}
}