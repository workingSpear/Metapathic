using FmodSharp;
using Godot;
using System.Collections;
using System.Collections.Generic;

// EVENT MANAGER - a data transfer object intended for storing paths to FMOD events
// via a Dictionary object EventReference. this then allows all event references 
// to be called through the EventManager anywhere in the project.
public partial class EventManager : Node
{
	// EVENT REFERENCES - a collection of data-value pairs that store reference 
	// keys and their associated path values
	public Dictionary<string, string> EventReference;
	
	public override void _Ready() {
		EventReference = new Dictionary<string, string>();
		
		EventReference.Add("TEST MUSIC", "event:/TEST MUSIC");
		GD.Print("TEST CASE: TEST MUSIC path is " + EventReference["TEST MUSIC"]);
		EventReference.Add("TEST SFX", "event:/TEST SFX");
		GD.Print("TEST CASE: TEST SFX path is " + EventReference["TEST SFX"]);
	}
}

// FIXME: i've tried to make the code for this manager elegant over the course of 
// days now, and unfortunately this damn plugin pushes back against me at every turn. 
// so i've decided it will be ugly until i can get some peer review LMFAOOOOOOOOOO.
