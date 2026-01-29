using FmodSharp;
using Godot;
using System.Collections;
using System.Collections.Generic;

// EVENT MANAGER - a data transfer object intended for storing paths to FMOD events
// via a Dictionary object, known as "event references". this then allows all
// event references to be called through the EventManager anywhere in a scene.
public partial class EventManager : Node
{
	// EVENT REFERENCES - a collection of data-value pairs that store  reference 
	// keys and their associated path values
	public Dictionary<string, string> EventReference;
	
	public override void _Ready() {
		_LoadEventReferences();
	}
	private void _LoadEventReferences() {
		
	}
}
