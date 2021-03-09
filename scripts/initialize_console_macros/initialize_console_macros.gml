
function initialize_console_macros(){

console_macros [$ "instance_create_layer"]		= {b: true, type: DT.SCRIPT, value: instance_create_layer}
console_macros [$ "instance_destroy"]			= {b: true, type: DT.SCRIPT, value: instance_destroy}

console_macros [$ "show_message"]				= {b: true, type: DT.SCRIPT, value: show_message}

console_macros [$ "power"]						= {b: true, type: DT.SCRIPT, value: power}

console_macros [$ "variable_instance_exists"]	= {b: true, type: DT.SCRIPT, value: variable_instance_exists}
console_macros [$ "variable_instance_get"]		= {b: true, type: DT.SCRIPT, value: variable_instance_get}
console_macros [$ "variable_instance_set"]		= {b: true, type: DT.SCRIPT, value: variable_instance_exists}
console_macros [$ "variable_struct_exists"]		= {b: true, type: DT.SCRIPT, value: variable_struct_exists}
console_macros [$ "variable_struct_get"]		= {b: true, type: DT.SCRIPT, value: variable_struct_get}
console_macros [$ "variable_struct_set"]		= {b: true, type: DT.SCRIPT, value: variable_struct_exists}

console_macros [$ "asset_get_index"]			= {b: true, type: DT.SCRIPT, value: asset_get_index}
console_macros [$ "asset_get_type"]				= {b: true, type: DT.SCRIPT, value: asset_get_type}

console_macros [$ "real"]						= {b: true, type: DT.SCRIPT, value: real}
console_macros [$ "is_real"]					= {b: true, type: DT.SCRIPT, value: is_real}



console_macros [$ "var"] = {type: DT.SCRIPT, value: create_variable}

console_macros [$ "@"] = {type: DT.SCRIPT, value: dealwith_array}
console_macros [$ "$"] = {type: DT.SCRIPT, value: dealwith_struct}	
console_macros [$ "|"] = {type: DT.SCRIPT, value: dealwith_ds_list}

console_macros [$ "?"] = {type: DT.SCRIPT, value: command_help}

console_macros [$ "&"] = {type: DT.OBJECT, value: o_console}

console_macros [$ "Display"]	= {type: DT.VARIABLE, value: "o_console.Display"}
console_macros [$ "Window"]		= {type: DT.VARIABLE, value: "o_console.Window"}

console_macros [$ "true"]	= {type: DT.NUMBER, value: true}
console_macros [$ "false"]	= {type: DT.NUMBER, value: false}

console_macros [$ "global"]	= {type: DT.OBJECT, value: global}
console_macros [$ "noone"]	= {type: DT.OBJECT, value: noone}
console_macros [$ "all"]	= {type: DT.OBJECT, value: all}

#region Colors
console_macros [$ "c_white"]	= {type: DT.NUMBER, value: c_white}
console_macros [$ "c_black"]	= {type: DT.NUMBER, value: c_black}
console_macros [$ "c_red"]		= {type: DT.NUMBER, value: c_red}
console_macros [$ "c_blue"]		= {type: DT.NUMBER, value: c_blue}
console_macros [$ "c_yellow"]	= {type: DT.NUMBER, value: c_yellow}
console_macros [$ "c_green"]	= {type: DT.NUMBER, value: c_green}
#endregion



#region Blendmodes
console_macros [$ "bm_normal"]		= {type: DT.NUMBER, value: bm_normal}
console_macros [$ "bm_add"]			= {type: DT.NUMBER, value: bm_add}
console_macros [$ "bm_subtract"]	= {type: DT.NUMBER, value: bm_subtract}
console_macros [$ "bm_max"]			= {type: DT.NUMBER, value: bm_max}
#endregion



#region Text alignments
console_macros [$ "fa_top"]		= {type: DT.NUMBER, value: fa_top}
console_macros [$ "fa_bottom"]	= {type: DT.NUMBER, value: fa_bottom}
console_macros [$ "fa_middle"]	= {type: DT.NUMBER, value: fa_middle}
console_macros [$ "fa_left"]	= {type: DT.NUMBER, value: fa_left}
console_macros [$ "fa_right"]	= {type: DT.NUMBER, value: fa_right}
console_macros [$ "fa_center"]	= {type: DT.NUMBER, value: fa_center}
#endregion



#region Virtual keys
console_macros [$ "vk_anykey"]		= {type: DT.NUMBER, value: vk_anykey		}
console_macros [$ "vk_nokey"]		= {type: DT.NUMBER, value: vk_nokey			}
																				
console_macros [$ "vk_left"]		= {type: DT.NUMBER, value: vk_left			}
console_macros [$ "vk_up"]			= {type: DT.NUMBER, value: vk_up			}
console_macros [$ "vk_down"]		= {type: DT.NUMBER, value: vk_down			}
console_macros [$ "vk_right"]		= {type: DT.NUMBER, value: vk_right			}

console_macros [$ "vk_space"]		= {type: DT.NUMBER, value: vk_space			}
console_macros [$ "vk_backspace"]	= {type: DT.NUMBER, value: vk_backspace		}
console_macros [$ "vk_enter"]	    = {type: DT.NUMBER, value: vk_enter			}
console_macros [$ "vk_escape"]		= {type: DT.NUMBER, value: vk_escape		}
console_macros [$ "vk_tab"]			= {type: DT.NUMBER, value: vk_tab			}

console_macros [$ "vk_shift"]		= {type: DT.NUMBER, value: vk_shift			}
console_macros [$ "vk_control"]		= {type: DT.NUMBER, value: vk_control		}
console_macros [$ "vk_alt"]			= {type: DT.NUMBER, value: vk_alt			}

if include_niche_virtual_keys
{
console_macros [$ "vk_add"]			= {type: DT.NUMBER, value: vk_add			}
console_macros [$ "vk_decimal"]		= {type: DT.NUMBER, value: vk_decimal		}
console_macros [$ "vk_delete"]		= {type: DT.NUMBER, value: vk_delete		}
console_macros [$ "vk_divide"]		= {type: DT.NUMBER, value: vk_divide		}
console_macros [$ "vk_end"]			= {type: DT.NUMBER, value: vk_end			}
console_macros [$ "vk_f1"]			= {type: DT.NUMBER, value: vk_f1			}
console_macros [$ "vk_f2"]			= {type: DT.NUMBER, value: vk_f2			}
console_macros [$ "vk_f3"]			= {type: DT.NUMBER, value: vk_f3			}
console_macros [$ "vk_f4"]			= {type: DT.NUMBER, value: vk_f4			}
console_macros [$ "vk_f5"]			= {type: DT.NUMBER, value: vk_f5			}
console_macros [$ "vk_f6"]			= {type: DT.NUMBER, value: vk_f6			}
console_macros [$ "vk_f7"]			= {type: DT.NUMBER, value: vk_f7			}
console_macros [$ "vk_f8"]			= {type: DT.NUMBER, value: vk_f8			}
console_macros [$ "vk_f9"]			= {type: DT.NUMBER, value: vk_f9			}
console_macros [$ "vk_f10"]			= {type: DT.NUMBER, value: vk_f10			}
console_macros [$ "vk_f11"]			= {type: DT.NUMBER, value: vk_f11			}
console_macros [$ "vk_f12"]			= {type: DT.NUMBER, value: vk_f12			}
console_macros [$ "vk_home"]		= {type: DT.NUMBER, value: vk_home			}
console_macros [$ "vk_insert"]		= {type: DT.NUMBER, value: vk_insert		}
console_macros [$ "vk_lalt"]		= {type: DT.NUMBER, value: vk_lalt			}
console_macros [$ "vk_lcontrol"]	= {type: DT.NUMBER, value: vk_lcontrol		}
console_macros [$ "vk_lshift"]		= {type: DT.NUMBER, value: vk_lshift		}
console_macros [$ "vk_multiply"]	= {type: DT.NUMBER, value: vk_multiply		}
console_macros [$ "vk_numpad0"]		= {type: DT.NUMBER, value: vk_numpad0		}
console_macros [$ "vk_numpad1"]		= {type: DT.NUMBER, value: vk_numpad1		}
console_macros [$ "vk_numpad2"]		= {type: DT.NUMBER, value: vk_numpad2		}
console_macros [$ "vk_numpad3"]		= {type: DT.NUMBER, value: vk_numpad3		}
console_macros [$ "vk_numpad4"]		= {type: DT.NUMBER, value: vk_numpad4		}
console_macros [$ "vk_numpad5"]		= {type: DT.NUMBER, value: vk_numpad5		}
console_macros [$ "vk_numpad6"]		= {type: DT.NUMBER, value: vk_numpad6		}
console_macros [$ "vk_numpad7"]		= {type: DT.NUMBER, value: vk_numpad7		}
console_macros [$ "vk_numpad8"]		= {type: DT.NUMBER, value: vk_numpad8		}
console_macros [$ "vk_numpad9"]		= {type: DT.NUMBER, value: vk_numpad9		}
console_macros [$ "vk_pagedown"]	= {type: DT.NUMBER, value: vk_pagedown		}
console_macros [$ "vk_pageup"]		= {type: DT.NUMBER, value: vk_pageup		}
console_macros [$ "vk_pause"]		= {type: DT.NUMBER, value: vk_pause			}
console_macros [$ "vk_printscreen"]	= {type: DT.NUMBER, value: vk_printscreen	}
console_macros [$ "vk_ralt"]		= {type: DT.NUMBER, value: vk_ralt			}
console_macros [$ "vk_rcontrol"]	= {type: DT.NUMBER, value: vk_rcontrol		}
console_macros [$ "vk_return"]		= {type: DT.NUMBER, value: vk_return		}
console_macros [$ "vk_rshift"]		= {type: DT.NUMBER, value: vk_rshift		}
console_macros [$ "vk_subtract"]	= {type: DT.NUMBER, value: vk_subtract		}
}
#endregion
}