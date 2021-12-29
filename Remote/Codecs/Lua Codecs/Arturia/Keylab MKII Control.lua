--[[
	Surface:	DAW Command Center of Arturia Keylab MKII
	Developer:	Thierry Fraudet / modified for MKII by Wade Carson
	Version:	1.3
	Date:		2021/12/28

]]

-- init globals variables
g_pause_play_button_state = "stop"
g_active_jog_state = "position"
g_pause_play_button_index = 3
g_stop_button_index = 2
g_left_loop_index = 12
g_right_loop_index = 13
g_position_index = 14

g_last_input_time=-2000
g_last_input_item=nil

g_lcd_line1_index = 35
g_lcd_line2_index = 36
g_lcd_line1_new_text = ""
g_lcd_line1_old_text = ""
g_lcd_line2_new_text = ""
g_lcd_line2_old_text = ""

g_part1_index = 15
g_part2_index = 16

function remote_init(manufacturer, model)
	local items = {
		{name="record", input="button", output="value"},
		{name="stop", input="button", output="value"},
		{name="play", input="button", output="value",  modes={"Play", "Pause"}},
		{name="loop", input="button", output="value"},
		{name="rew", input="button", output="value"},
		{name="fwd", input="button", output="value"},
		{name="save", input="button", output="value"},
		{name="punch", input="button", output="value"},
		{name="undo", input="button", output="value"},
		{name="metro", input="button", output="value"},
		{name="master-fader", input="value", min = 0, max = 127},
		{name="left-loop", input="delta"},
		{name="right-loop", input="delta"},
		{name="position", input="delta"},
		{name="left_arrow", input="button", output="value"},
		{name="right_arrow", input="button", output="value"},

		------added mkII chorus encoder
		{name="encoder-chorus", input="delta"},
		------

		------added mkII track controls
		{name="track1_solo", input="button", output="value"},
		{name="track1_mute", input="button", output="value"},
		{name="track1_record_arm", input="button", output="value"},
		{name="track2_solo", input="button", output="value"},
		{name="track2_mute", input="button", output="value"},
		{name="track2_record_arm", input="button", output="value"},
		{name="track3_solo", input="button", output="value"},
		{name="track3_mute", input="button", output="value"},
		{name="track3_record_arm", input="button", output="value"},
		{name="track4_solo", input="button", output="value"},
		{name="track4_mute", input="button", output="value"},
		{name="track4_record_arm", input="button", output="value"},
		{name="track5_solo", input="button", output="value"},
		{name="track5_mute", input="button", output="value"},
		{name="track5_record_arm", input="button", output="value"},
		{name="track6_solo", input="button", output="value"},
		{name="track6_mute", input="button", output="value"},
		{name="track6_record_arm", input="button", output="value"},
		{name="track7_solo", input="button", output="value"},
		{name="track7_mute", input="button", output="value"},
		{name="track7_record_arm", input="button", output="value"},
		{name="track8_solo", input="button", output="value"},
		{name="track8_mute", input="button", output="value"},
		{name="track8_record_arm", input="button", output="value"},

		{name="read", input="button", output="value"},
		{name="write", input="button", output="value"},
		------

		{name="part1", input="button", output="value"},
		{name="part2", input="button", output="value"},
		{name="next", input="button", output="value"},
		{name="prev", input="button", output="value"},

		{name="fader-1", input="value", min=0, max=127},
		{name="fader-2", input="value", min=0, max=127},
		{name="fader-3", input="value", min=0, max=127},
		{name="fader-4", input="value", min=0, max=127},
		{name="fader-5", input="value", min=0, max=127},
		{name="fader-6", input="value", min=0, max=127},
		{name="fader-7", input="value", min=0, max=127},
		{name="fader-8", input="value", min=0, max=127},

		{name="encoder-1", input="delta"},
		{name="encoder-2", input="delta"},
		{name="encoder-3", input="delta"},
		{name="encoder-4", input="delta"},
		{name="encoder-5", input="delta"},
		{name="encoder-6", input="delta"},
		{name="encoder-7", input="delta"},
		{name="encoder-8", input="delta"},

		{name="lcd-1", output="text"},
		{name="lcd-2", output="text"},
	}
	remote.define_items(items)

	local inputs = {
		{pattern="9? 5F xx", name="record", value="x"},
		{pattern="9? 5D xx", name="stop", value="x"},
		{pattern="9? 5E xx", name="play", value="x"},
		{pattern="9? 5B xx", name="rew", value="x"},
		{pattern="9? 5C xx", name="fwd", value="x"},
		{pattern="9? 56 xx", name="loop", value="x"},
		{pattern="9? 50 xx", name="save", value="x"},
		{pattern="9? 58 xx", name="punch", value="x"},
		{pattern="9? 51 xx", name="undo", value="x"},
		{pattern="9? 59 xx", name="metro", value="x"},
		{pattern="E8 ?? xx", name="master-fader", value="x"},
		{pattern="9? 62 xx", name="left_arrow", value="x"},
		{pattern="9? 63 xx", name="right_arrow", value="x"},

		------added mkII chorus encoder
		{pattern="b? 18 <?x??>?", name="encoder-chorus", value="1-2*x"},

		------added mkII track controls
		{pattern="9? 08 xx", name="track1_solo", value="x"},
		{pattern="9? 10 xx", name="track1_mute", value="x"},
		{pattern="9? 00 xx", name="track1_record_arm", value="x"},

		{pattern="9? 4a xx", name="read", value="x"},
		{pattern="9? 4b xx", name="write", value="x"},
		------

		{pattern="9? 31 xx", name="part1", value="x"},
		{pattern="9? 30 xx", name="part2", value="x"},

		{pattern="9? 2f xx", name="next", value="x"},
		{pattern="9? 2e xx", name="prev", value="x"},

		{pattern="E0 ?? xx", name="fader-1", value="x"},
		{pattern="E1 ?? xx", name="fader-2", value="x"},
		{pattern="E2 ?? xx", name="fader-3", value="x"},
		{pattern="E3 ?? xx", name="fader-4", value="x"},
		{pattern="E4 ?? xx", name="fader-5", value="x"},
		{pattern="E5 ?? xx", name="fader-6", value="x"},
		{pattern="E6 ?? xx", name="fader-7", value="x"},
		{pattern="E7 ?? xx", name="fader-8", value="x"},

		{pattern="b? 10 <?x??>?", name="encoder-1", value="1-2*x"},
		{pattern="b? 11 <?x??>?", name="encoder-2", value="1-2*x"},
		{pattern="b? 12 <?x??>?", name="encoder-3", value="1-2*x"},
		{pattern="b? 13 <?x??>?", name="encoder-4", value="1-2*x"},
		{pattern="b? 14 <?x??>?", name="encoder-5", value="1-2*x"},
		{pattern="b? 15 <?x??>?", name="encoder-6", value="1-2*x"},
		{pattern="b? 16 <?x??>?", name="encoder-7", value="1-2*x"},
		{pattern="b? 17 <?x??>?", name="encoder-8", value="1-2*x"},
	}
	remote.define_auto_inputs(inputs)

	--Auto outputs
	local outputs = {
		{name="record", pattern="90 5F 0x"},
		{name="play", pattern="90 5E xx"},
		{name="stop", pattern="90 5D xx"},
		{name="rew", pattern="90 5B xx"},
		{name="fwd", pattern="90 5C xx"},
		{name="save", pattern="90 50 xx"},
		{name="punch", pattern="90 58 xx"},
		{name="undo", pattern="90 51 xx"},
		{name="metro", pattern="90 59 xx"},
		{name="loop", pattern="90 56 xx"},

		------added mkII track controls
		{name="track1_solo", pattern="9? 08 xx"},
		{name="track1_mute", pattern="9? 10 xx"},
		{name="track1_record_arm", pattern="9? 00 xx"},
		{name="read", pattern="9? 4a xx"},
		{name="write", pattern="9? 4b xx"},
		------
	}
	remote.define_auto_outputs(outputs)
end

-- Sysex to color transport leds: F0 00 20 6B 7F 42 02 00 10 xx yy F7
-- where:
--   xx is the button
-- 		56 is save button
--		57 is undo button
--		58 i punch button
--		59 is Metro button
--		5a is loop button
--		5b is rwd button
--		5c is fwd button
--		5d is stop button
--		5e is pause/play button
--		5f is record button
-- 	 yy is intensity of the led from 00 to 7F , 00 the led is off
--
-- ref: https://forum.renoise.com/t/tool-development-arturia-keylab-mkii-49-61-mcu-midi-messages/57343/9
--
-- to set button off
-- send 90 xx 00
--
function remote_probe(manufacturer,model,prober)
	-- Arturia Manufacturer SysEx ID Numbers is: 00 20 6b

	-- Need to be rework, for hardware with multiple ports must be done programaticaly (see Remote SDK documentation page 26 & 27)
	assert(model == "Keylab61 Essential Control")
	local controlRequest="f0 7e 7f 06 01 f7"  -- sysex de demande d'identification
	local controlResponse="F0 7E 7F 06 02 00 20 6B 02 00 05 54 3D 02 01 01 F7"
	return {
		request=controlRequest,
		response=controlResponse
	}
end

function remote_on_auto_input(item_index)
	g_last_input_time=remote.get_time_ms()
	g_last_input_item=item_index
end

function toggle_pause_play_button_state()
	if g_pause_play_button_state == "play" then
		g_pause_play_button_state = "pause"
	else
		g_pause_play_button_state = "play"
	end
	return g_pause_play_button_state
end

--	test jog dial state
function cycle_jog_state()
	if g_active_jog_state == "position" then
				g_active_jog_state = "left"
			elseif
				g_active_jog_state == "left" then
				g_active_jog_state = "right"
			elseif
				g_active_jog_state == "right" then
				g_active_jog_state = "both"
			else
				g_active_jog_state = "position"
	end
	return g_active_jog_state
end

function remote_process_midi(event)  -- handle incoming midi event
	-- test if pause/play is pressed
	ret = remote.match_midi("9? 5e 7f",event)
	if ret~=nil then
		g_pause_play_button_state = toggle_pause_play_button_state()
		g_last_input_index = 3
		if g_pause_play_button_state == "play" then
			local msg={ time_stamp=event.time_stamp, item=g_pause_play_button_index, value=1 }
			remote.handle_input(msg)
		else
			local msg={ time_stamp=event.time_stamp, item=g_stop_button_index, value=1 }
			remote.handle_input(msg)
		end
		return true
	end

	--test if stop is pressed
	ret = remote.match_midi("9? 5d 7f",event)
	if ret~=nil then
		g_pause_play_button_state = "stop"
		g_last_input_index = 2;
		local msg={ time_stamp=event.time_stamp, item=g_stop_button_index, value=1}
		remote.handle_input(msg)
		return true
	end

	--In DAW mode, if jog-wheel is pressed then cycle active_jog_state
	ret = remote.match_midi("9? 54 7f",event)
	if ret~=nil then
		g_active_jog_state = cycle_jog_state()
	-- remote_on_auto_input(event)
	return true
end

	--test if jog-wheel is turned
	ret = remote.match_midi("b0 3c <?y??> x",event)
	if ret~=nil then
		if g_active_jog_state == "left" then
			local msg={ time_stamp=event.time_stamp, item=g_left_loop_index, value=ret.x*(1-2*ret.y)*15360 }
			remote.handle_input(msg)
		elseif g_active_jog_state == "right" then
			local msg={ time_stamp=event.time_stamp, item=g_right_loop_index, value=ret.x*(1-2*ret.y)*15360 }
			remote.handle_input(msg)
		elseif g_active_jog_state == "both" then
			local msg={ time_stamp=event.time_stamp, item=g_right_loop_index, value=ret.x*(1-2*ret.y)*15360 }
			remote.handle_input(msg)
			local msg={ time_stamp=event.time_stamp, item=g_left_loop_index, value=ret.x*(1-2*ret.y)*15360 }
			remote.handle_input(msg)
		else
			local msg={ time_stamp=event.time_stamp, item=g_position_index, value=ret.x*(1-2*ret.y)*15360 }
			remote.handle_input(msg)
		end
		return true
	end

	return false
end

function remote_set_state(changed_items) --handle incoming changes sent by Reason
	for i,item_index in ipairs(changed_items) do
		if item_index==g_lcd_line1_index then
			--g_is_lcd_enabled=remote.is_item_enabled(item_index)
			g_lcd_line1_new_text=remote.get_item_text_value(item_index)
		end

		if item_index==g_lcd_line2_index then
			--g_is_lcd_enabled=remote.is_item_enabled(item_index)
			g_lcd_line2_new_text=remote.get_item_text_value(item_index)
		end

		if item_index==g_part1_index then
			g_lcd_line2_new_text=""..remote.get_item_text_value(item_index)
		end

		if item_index==g_part2_index then
			g_lcd_line2_new_text=""..remote.get_item_text_value(item_index)
		end


	end

end

function remote_deliver_midi(max_bytes, port)
	local ret_events={}

	-- if there is a new message to display
	if (g_lcd_line1_new_text ~= g_lcd_line1_old_text) then
		g_lcd_line1_old_text = g_lcd_line1_new_text
		table.insert(ret_events,make_lcd_midi_message(g_lcd_line1_new_text, g_lcd_line2_old_text))
	end

	-- if there is a new message to display
	if (g_lcd_line2_new_text ~= g_lcd_line2_old_text) then
		g_lcd_line2_old_text = g_lcd_line2_new_text
		table.insert(ret_events,make_lcd_midi_message(g_lcd_line1_old_text, g_lcd_line2_new_text))
	end

	-- play_pause_button_state has 3 value: stop, pause, play
	-- following the state, we send sysex to light the pause/play button led
	if (g_last_input_index == 3) then
		if g_pause_play_button_state == "play" then
			pause_play_led_event = remote.make_midi('F0 00 20 6B 7F 42 02 00 10 5e 7f F7')
		elseif g_pause_play_button_state == "pause" then
			pause_play_led_event = remote.make_midi('F0 00 20 6B 7F 42 02 00 10 5e 10 F7')
		else
			pause_play_led_event = remote.make_midi('F0 00 20 6B 7F 42 02 00 10 5e 00 F7')
		end
		table.insert(ret_events,pause_play_led_event)
	end

	-- if stop is pressed, switch off the pause/play button led.
	if (g_last_input_index == 2) then
		pause_play_led_event = remote.make_midi('F0 00 20 6B 7F 42 02 00 10 5e 00 F7')
		table.insert(ret_events,pause_play_led_event)
	end

	g_last_input_index = nil
	return ret_events
end

function remote_prepare_for_use()
	local retEvents={
		-- set to Mackie control mode
		remote.make_midi("f0 00 20 6b 7f 42 02 00  40 51 00 F7"),

		-- switch off all the button's leds
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('56',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('57',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('58',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('59',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5a',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5b',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5c',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5e',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5d',16), y=0, port=1} ),
		remote.make_midi("f0 00 20 6b 7f 42 02 00 10 xx yy f7", { x=tonumber('5f',16), y=0, port=1} ),

		-- Display message on LCD
		make_lcd_midi_message("Reason DAW CC", "connected"),
	}
	return retEvents
end

function remote_release_from_use()
	local retEvents={
		-- Display message on LCD
		make_lcd_midi_message("Reason DAW CC", "disconnected"),
	}
	return retEvents
end

function stringToHex(text)
	local hexStringToReturn = ""
	for i=1, string.len(text) do
		if string.len(hexStringToReturn) > 0 then
			hexStringToReturn = hexStringToReturn .. " "
		end
		hexStringToReturn = hexStringToReturn .. string.format("%X", string.byte(text,i))
	end
	return hexStringToReturn
end

function make_lcd_midi_message(line1, line2)
	local sysex = "f0 00 20 6b 7f 42 04 00 60 01" .. stringToHex(string.sub(line1,1,16)) .. " 00 02" .. stringToHex(string.sub(line2,1,16)) .. " 00 f7"
	local event=remote.make_midi(sysex)
	return event
end

function trace_event(event)
	result = "Event: "
	result = result .. "port " .. event.port .. ", "
	result = result .. (event.timestamp and ("timestamp " .. event.timestamp .. ", ") or "")
	result = result .. (event.hi and ("hi " .. event.hi .. ", ") or "")
	result = result .. (event.lo and ("lo " .. event.lo .. ", ") or "")
	result = result .. (event.size and ("size " .. event.size .. ", ") or "")

	result = result .. "data {"
	for i=1,event.size do
		result = result .. event[i] .. ", "
	end
	result = result .. "}, "

	remote.trace(result)
end
