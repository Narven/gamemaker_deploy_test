// Destroy the particle systems
if (bullet_effect != -1 && instance_exists(bullet_effect))
{
	bullet_effect.fade_ps(0.0);	
	bullet_effect = -1;
}