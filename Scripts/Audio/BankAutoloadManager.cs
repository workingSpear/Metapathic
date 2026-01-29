using FmodSharp;
using Godot;
using System;

// BANK AUTOLOAD MANAGER - loads all FMOD banks at start time for project-wide use.
public partial class BankAutoloadManager : Node
{
	private readonly Godot.Collections.Array _loadedBanks = [];
	
	public override void _Ready() {
		_LoadBanks();
	}
	
	// Bank loader architecture cred. straussna - github.com/straussna
	
	// BANK LOADER - loads banks from associated FMOD project.
	private void _LoadBanks() {
		try {
			_loadedBanks.Clear();
		
			var stringsBank = FmodServerWrapper.LoadBank("res://METAPATHIC_FMODProject/Build/banks/Master.strings.bank",
				FmodServerWrapper.FMOD_STUDIO_LOAD_BANK_NORMAL);
			if (stringsBank != null) {
				_loadedBanks.Add(stringsBank);
				GD.Print("BankAutoload: Loaded Master.strings.bank");
			}
		
			var masterBank = FmodServerWrapper.LoadBank("res://METAPATHIC_FMODProject/Build/banks/Master.bank",
				FmodServerWrapper.FMOD_STUDIO_LOAD_BANK_NORMAL);
			if (masterBank != null) {
				_loadedBanks.Add(masterBank);
				GD.Print("BankAutoload: Loaded Master.bank");
			}
			
			var musicBank = FmodServerWrapper.LoadBank("res://METAPATHIC_FMODProject/Build/banks/Music.bank",
				FmodServerWrapper.FMOD_STUDIO_LOAD_BANK_NORMAL);
			if (musicBank != null) {
				_loadedBanks.Add(musicBank);
				GD.Print("BankAutoload: Loaded Music.bank");
			}
			
			var sfxBank = FmodServerWrapper.LoadBank("res://METAPATHIC_FMODProject/Build/banks/SFX.bank",
				FmodServerWrapper.FMOD_STUDIO_LOAD_BANK_NORMAL);
			if (sfxBank != null) {
				_loadedBanks.Add(sfxBank);
				GD.Print("BankAutoload: Loaded SFX.bank");
			}
		}
		catch (Exception err) {
			GD.PushError($"BankAutoload: ERROR - exception on loading banks: {err.Message}");
		}
	}
}
