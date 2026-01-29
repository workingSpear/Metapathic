using FmodSharp;
using Godot;
using System.Collections;
using System.Collections.Generic;

// AUDIO MANAGER - a singleton that calls methods from the provided C# wrapper,
// which interfaces with the FMOD server singleton. the AudioManager abstracts said 
// methods for ease of use, and allows these methods to be used anywhere within the 
// project.
public partial class AudioManager : Node
{
	// VOLUME SETTINGS
	public float masterVolume = 1f;
	public float sfxVolume = 1f;
	public float musicVolume = 1f;
	
	// BUSES - godot objects to hold FMOD buses, which route to volume settings.
	// public GodotObject masterBus, sfxBus, musicBus;
	
	// EVENT STORAGE - a list of all event instances. used for cleanup on destroy.
	// private List<FmodEvent> eventInstances;
	
	public override void _Ready() {
		// masterBus = FmodServerWrapper.GetBus("bus:/");
		// sfxBus = FmodServerWrapper.GetBus("bus:/SFX");
		// musicBus = FmodServerWrapper.GetBus("bus:/Music");
	}
}
