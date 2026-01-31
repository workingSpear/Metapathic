using FmodSharp;
using Godot;
using System;
using System.Collections;
using System.Collections.Generic;

// EVENT MANAGER - a data transfer object intended for storing paths to FMOD events
// via a Dictionary object EventReference. this then allows all event references 
// to be called through the EventManager anywhere in the project.
public partial class EventManager : Node
{
	// EVENT REFERENCES - a dictionary of data-value pairs that store reference 
	// keys and their associated paths.
	public Dictionary<string, string> EventReference;
	
	public override void _Ready() {
		EventReference = new Dictionary<string, string>();
		_LoadEventReferences();
	}
	
	// LOAD EVENT REFERENCES - private helper function dedicated to retrieving all
	// event descriptions from the linked FMOD project and loading them into the
	// EventReference dictionary provided by the EventManager, parsing their event
	// names and paths.
	private void _LoadEventReferences() {
		Godot.Collections.Array eventDescs = [];
		eventDescs = FmodServerWrapper.GetAllEventDescriptions();
		
		foreach (GodotObject obj in eventDescs) {
			if (obj != null) {
				string path = (string)obj.Call("get_path");
				int cullPos = path.IndexOf('/') + 1;
				
				string eventName = path.Substring(cullPos);
				
				EventReference.Add(eventName, path);
			}
			else {
				GD.Print("TEST CASE: ERROR - Invalid path");
				continue;
			}
		}
	}
}

// FIXME: i've tried to make the code for this manager elegant over the course of 
// days now, and unfortunately this damn plugin pushes back against me at every turn. 
// so i've decided it will be ugly until i can get some peer review LMFAOOOOOOOOOO.
