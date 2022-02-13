# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## unreleased

**Added**
* (WC) Added mapping and documentation update for Pattern Mutator, Quad Note, Polystep Player devices
* (WC) Added mapping and documentation update for POLAR Dual Pitch Shifter and Rotor Rotary Speaker
* (WC) Added 8 pads 9-16 to control surface codec.
* (WC) Added outputs to more items with absolute values
* (WC) Added a basic controls for knob 5-8 performance Macros on remaining V collection instruments.
* (WC) Added basic control maps for Vital Synth (Macros) and Vember Audio Surge (Filter).
* (WC) Added the 9 buttons that are below the MKII faders to the keyboard codec. MULTI button will be used with VST instruments to open and close the device window.

**changed**

* (WC) various documentation updates/cleanup.
* (WC) changed mapping for Note Echo player. Step length for synced and free modes, and tempo sync button. Added variation groups to enable/disable steps.
* (WC) changed mapping for Bassline. Jog Dial is now used for patch selection instead of pattern selection. Pattern selection is moved to the Master Pan encoder for continuity with other devices already mapped.
* (WC) fixed scopes for "ElectricGuitaristPopC" and "FingerpickingNylon" (removed errant quotes from LCD output)
* (WC) fixed DAW mode part1-next and part2-prev to scroll through active Reason document tracks.

**removed**

* Keylab Essential specific assets.

## [2.0.0] 2021, January 02
#### Initial release for MKII keyboards

##### MKII keyboard mode:
* (WC) Full re-mapping and documentation update for GRAIN sample manipulator. New variation modes added for all granular oscillator types, Filter + LFO, as well as a very fun "performance" mode variation.
* (WC) Added full map scope and documentation update for Bassline Generator player device.
* (WC) documentation update to include more devices.
* (WC) updated Combinator scope to Combinator2:
	-included all 32 Rotaries in 2 variation groups
* (WC) Added basic map scope for more Reason devices:
	(Basic controls, Patch selection Delta, LCD feedback)
 		Reason document, External MIDI device, Radical Keys, Radical Piano, Electric Bass, Reason Drums, Umpf, Umpf Retro, Scenic, Processed Pianos, Algoritm, Mimic, Complex-1, Layers, Layers Wave Edition, Audio Track(Main Mixer Channel),
* (WC) Added full map scope for a few Noise Engineering rack extensions:
		Basimilus, Basimilus Iteritas, Loquelic Iteritas Percido, Manis Iteritas, Sinc Vereor, Virt Vereor
		(neither Sinc Vereor nor Virt Vereor will accept remote Patch change)
* (WC) Added mapping for more Skrock Music synths:
		Iridium, Nautilus 2, Orbis, Thermal
* (WC) Added mapping for Turn2On Meteora Rompler
* (WC) Added mapping for Synthetech Sound Spectra Additive Resynthesizer
* (WC) mapped part1-next and part2-prev buttons to scroll through Reason document tracks.
* (WC) added MIDI output scope for faders (Pickup mode) and buttons (LEDs)
* (WC) remapped L&R arrows to scroll through Reason keyboard variation groups
* (WC) mapped cat-jog-wheel to Document scope. scroll patches in targeted device (good for unmapped devices)

-----
##### MKII DAW mode:
* (WC) added MIDI output scope for DAW mode faders (Pickup mode).
* (WC) added track solo and mute select mode for MKII DAW mode (Keylab DAW mode should be set to Multitrack mode)
* (WC) remapped DAW mode global controls. (monitor, auto quant, precount, click, reset automation override, write automation enable
+ (WC) re-ordered DAW mode MIDI indexing to match physical layout of hardware
* (WC) mapped chorus dial DAW mode to "CTRL room level"
* (WC) mapped MULTI button DAW mode to "All mutes off"
* (WC) Added 4-state command dial in DAW mode (playhead position, L loop, R loop, both locators)
* 	extended Jog/Dial function. Press command dial multiple times to cycle between:
		-move song position (playhead cursor)
		-move left loop locator
		-move right loop locator
		-move both loop locators simultaneously (quick fix for lack of Delta controllable "Move loop LR" remotables. Perhaps to change at a later time)
* (WC) Add master chorus hardware knob (Master pan pot)
* (WC) Add MKII Track control buttons
* (WC) Remap left/right arrow buttons to change mixer remote base channel
* (WC) Remap Next/Previous buttons to change Next/Prev active document track



---------------------------------------------------------------------------
#### entries below reflect previous releases of the original Keylab Essential project

* Minor fixes: mainly correction of spelling mistakes
* Add mapping for A-List Accoustic Guitarist - Fingerpicking Nylon from Propellerhead Software
* Add mapping for A-List Electric Guitarist - Pop Chords from Propellerhead Software
* Add mapping for A-List Electric Guitarist - Power Chords from Propellerhead Software
* Add mapping for Friktion from Propellerhead Software
* Reason faders value are now send to the controller when you move between instruments Reason devices.


#### [1.2] - 2020, April 19

### Added

* Refactor of the documentation to support git-hub page
* Add mapping for Quartet Chorus Ensemble from Propellerhead Software
* Add mapping for Sweeper Modulation Effect from Propellerhead Software
* Add mapping for Master Bus Compressor from Propellerhead Software
* Add mapping for Channel Dynamics Compressor & Gate from Propellerhead Software
* Add mapping for Beat Map from Propellerhead Software

### Changed

### Removed

## [1.1] - 2019, December 23

* Changelog.md to track changes on this project
* Add support for DAW Map Preset
  * jog wheel is used to change the position of left&right loop locators (press the jog wheel to change the active loop locator)  
  * Left & Right arrow buttons arround the jog wheel are use to change the tempo
  * Master fader is used to change the Master Section level (:warning: the `Arturia KeyLab 61 Essential Control` surface need to be locked to the Reason Master Section to work properlly, see [Reason doc](http://docs.propellerheads.se/reason10/wwhelp/wwhimpl/js/html/wwhelp.htm#context=EngOpManProjectPro&topic=PreferencesControlSurface))
* Refactor documentation mapping
* Add mapping for Propellerhead Software instruments bundle with Reason 10.4
* Add mapping for Propellerhead Sofware utilities bundle with Reason 10.4
* Add mapping for Propellerhead Sofware effects bundle with Reason 10.4
* Add mapping for Propellerhead Sofware players bundle with Reason 10.4
* Add mapping for Saturation Knob from Softube
* Add mapping for Classic Filter from MagmaSonic
* Add mapping for RPSpec Spectogram from Rob Papen
* Add mapping for Morphin XF Crossfader from Groovy Melon
* Add mapping for A-List Accoustic Guitarist from Propellerhead Software
* Add mapping for Parsec Spectral Synthesizer from Propellerhead Software
* Add mapping for AutoTheory Spectral Synthesizer from Pitchblende
* Add mapping for Mercury 4 Voice Polyphonic Arpeggiator Spectral Synthesizer from Quadelectra
* Add mapping for Nautilus Bass Synthesizer from Skrock Music
* Add mapping for Synapse Antidote from Synapse Audio
* Add mapping for Drum Sequencer from Propellerhead Software

## [1.0] - 2019, November 10

Initial release

[Unreleased]: https://github.com/tfraudet/Reason-ArturiaKeylabEssential-Remote/compare/v1.0...HEAD
[1.0]: https://github.com/tfraudet/Reason-ArturiaKeylabEssential-Remote/releases/tag/1.0
[1.1]: https://github.com/tfraudet/Reason-ArturiaKeylabEssential-Remote/releases/tag/1.1
[1.2]: https://github.com/tfraudet/Reason-ArturiaKeylabEssential-Remote/releases/tag/1.2
