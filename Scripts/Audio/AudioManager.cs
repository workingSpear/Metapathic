using FmodSharp;
using Godot;
using System;
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
	public GodotObject masterBus;
	public GodotObject musicBus;
	public GodotObject sfxBus;
	
	// EVENT STORAGE - a list of all event instances. used for cleanup on destroy.
	private List<FmodEvent> eventInstances;
	
	public override void _Ready() {
		eventInstances = new List<FmodEvent>();
		
		masterBus = FmodServerWrapper.GetBus("bus:/");
		musicBus = FmodServerWrapper.GetBus("bus:/Music");
		sfxBus = FmodServerWrapper.GetBus("bus:/SFX");
	}
	
	// SCENE CHANGE - on leaving scene, call and run the Cleanup method.
	public override void _ExitTree() { Cleanup(); }
	
	// CLEAN-UP - stop and free all FMOD event instances currently in use by this
	// AudioManager.
	public void Cleanup() {
		foreach (FmodEvent instance in eventInstances) {
			if (instance != null) {
				instance.Stop(FmodServerWrapper.FMOD_STUDIO_STOP_IMMEDIATE);
				instance.Release();
			}
		}
	}
	
	// PLAY ONE SHOT - calls path to an FMOD event without instantiating an event
	// instance.
	public void PlayOneShot(string eventReference) {
		FmodServerWrapper.PlayOneShot(eventReference);
	}
	
	// CREATE EVENT INSTANCE - creates an instance of an FMOD event to be continuously 
	// used throughout the game.
	public FmodEvent CreateEventInstance(string eventReference) {
		FmodEvent eventInstance = FmodServerWrapper.CreateEventInstance(eventReference);
		eventInstances.Add(eventInstance);
		return eventInstance;
	}
	
	// SET INSTANCE PARAMETER - takes an event instance, the desired parameter of 
	// that event instance, and the desired parameter value to actively adjust the
	// parameter in the linked FMOD project.
	public void SetEventInstanceParameter(
		FmodEvent eventInstance,  string paramName, float paramVal) {
		eventInstance.SetParameterByName(paramName, paramVal);
	}
}
