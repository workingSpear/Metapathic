using FmodSharp;
using Godot;
using System.Collections;
using System.Collections.Generic;

public partial class AudioManager : Node
{
	// VOLUME SETTINGS
	public float masterVolume = 1f;
	public float sfxVolume = 1f;
	public float musicVolume = 1f;
	
	// BUSES - godot objects to hold FMOD buses, which route to volume settings.
	// public GodotObject masterBus, sfxBus, musicBus;
	
	// private List<FmodEvent> eventInstances;
	// private Godot.Collections.Array banks;
	
	public override void _Ready() {
		// masterBus = FmodServerWrapper.GetBus("bus:/");
		// sfxBus = FmodServerWrapper.GetBus("bus:/SFX");
		// musicBus = FmodServerWrapper.GetBus("bus:/Music");
	}
}
