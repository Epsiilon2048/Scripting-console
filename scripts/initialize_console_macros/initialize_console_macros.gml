
function initialize_console_macros(){

#region Commands
console_macros [$ "var"]	= {type: dt_method, value: create_variable}

console_macros [$ "@"]		= {type: dt_method, value: dealwith_array}
console_macros [$ "$"]		= {type: dt_method, value: dealwith_struct}	
console_macros [$ "|"]		= {type: dt_method, value: dealwith_ds_list}
#endregion

#region Shortcuts
console_macros [$ "~"]			= {type: dt_instance, value: o_console}

console_macros [$ "Display"]	= {type: dt_variable, value: "o_console.Display"}
console_macros [$ "Window"]		= {type: dt_variable, value: "o_console.Window"}
console_macros [$ "Output"]		= {type: dt_variable, value: "o_console.Output"}

console_macros [$ "O1"]			= {type: dt_variable, value: "o_console.O1"}
console_macros [$ "O2"]			= {type: dt_variable, value: "o_console.O2"}
console_macros [$ "O3"]			= {type: dt_variable, value: "o_console.O3"}
console_macros [$ "O4"]			= {type: dt_variable, value: "o_console.O4"}
console_macros [$ "O5"]			= {type: dt_variable, value: "o_console.O5"}

console_macros [$ "mouse_x"]	= {type: dt_variable, value: "global.mouse_x"}
console_macros [$ "mouse_y"]	= {type: dt_variable, value: "global.mouse_y"}

console_macros [$ "gui_mx"]		= {type: dt_variable, value: "o_console.gui_mouse_x"}
console_macros [$ "gui_my"]		= {type: dt_variable, value: "o_console.gui_mouse_y"}
#endregion

#region Console datatypes
console_macros [$ "dt_real"]		= {type: dt_string, value: "real"}
console_macros [$ "dt_string"]		= {type: dt_string, value: "string"}
console_macros [$ "dt_asset"]		= {type: dt_string, value: "asset"}
console_macros [$ "dt_variable"]	= {type: dt_string, value: "variable"}
console_macros [$ "dt_method"]		= {type: dt_string, value: "method"}
console_macros [$ "dt_instance"]	= {type: dt_string, value: "instance"}
console_macros [$ "dt_room"]		= {type: dt_string, value: "room"}
console_macros [$ "dt_unknown"]		= {type: dt_string, value: "plain"}
#endregion

#region Value box types
console_macros [$ "vb_bool"]		= {type: dt_string, value: vb_bool		}
console_macros [$ "vb_color"]		= {type: dt_string, value: vb_color		}
console_macros [$ "vb_scrubber"]	= {type: dt_string, value: vb_scrubber	}
console_macros [$ "vb_static"]		= {type: dt_string, value: vb_static	}
#endregion

#region Boolean
console_macros [$ "true"]	= {type: dt_real, value: true}
console_macros [$ "false"]	= {type: dt_real, value: false}
#endregion

#region Instance constants
console_macros [$ "global"]	= {type: dt_instance, value: global}
console_macros [$ "noone"]	= {type: dt_instance, value: noone}
console_macros [$ "all"]	= {type: dt_instance, value: all}
#endregion

#region Colors
console_macros [$ "c_white"]	= {type: dt_real, value: c_white}
console_macros [$ "c_black"]	= {type: dt_real, value: c_black}
console_macros [$ "c_red"]		= {type: dt_real, value: c_red}
console_macros [$ "c_blue"]		= {type: dt_real, value: c_blue}
console_macros [$ "c_yellow"]	= {type: dt_real, value: c_yellow}
console_macros [$ "c_green"]	= {type: dt_real, value: c_green}
#endregion

#region Blendmodes
console_macros [$ "bm_normal"]		= {type: dt_real, value: bm_normal}
console_macros [$ "bm_add"]			= {type: dt_real, value: bm_add}
console_macros [$ "bm_subtract"]	= {type: dt_real, value: bm_subtract}
console_macros [$ "bm_max"]			= {type: dt_real, value: bm_max}
#endregion

#region Text alignments
console_macros [$ "fa_top"]		= {type: dt_real, value: fa_top}
console_macros [$ "fa_bottom"]	= {type: dt_real, value: fa_bottom}
console_macros [$ "fa_middle"]	= {type: dt_real, value: fa_middle}
console_macros [$ "fa_left"]	= {type: dt_real, value: fa_left}
console_macros [$ "fa_right"]	= {type: dt_real, value: fa_right}
console_macros [$ "fa_center"]	= {type: dt_real, value: fa_center}
#endregion

#region Virtual keys
console_macros [$ "vk_anykey"]		= {type: dt_real, value: vk_anykey		}
console_macros [$ "vk_nokey"]		= {type: dt_real, value: vk_nokey		}
																				
console_macros [$ "vk_left"]		= {type: dt_real, value: vk_left		}
console_macros [$ "vk_up"]			= {type: dt_real, value: vk_up			}
console_macros [$ "vk_down"]		= {type: dt_real, value: vk_down		}
console_macros [$ "vk_right"]		= {type: dt_real, value: vk_right		}

console_macros [$ "vk_space"]		= {type: dt_real, value: vk_space		}
console_macros [$ "vk_backspace"]	= {type: dt_real, value: vk_backspace	}
console_macros [$ "vk_enter"]	    = {type: dt_real, value: vk_enter		}
console_macros [$ "vk_escape"]		= {type: dt_real, value: vk_escape		}
console_macros [$ "vk_tab"]			= {type: dt_real, value: vk_tab			}

console_macros [$ "vk_shift"]		= {type: dt_real, value: vk_shift		}
console_macros [$ "vk_control"]		= {type: dt_real, value: vk_control		}
console_macros [$ "vk_alt"]			= {type: dt_real, value: vk_alt			}

if include_niche_virtual_keys
{
console_macros [$ "vk_add"]			= {type: dt_real, value: vk_add			}
console_macros [$ "vk_decimal"]		= {type: dt_real, value: vk_decimal		}
console_macros [$ "vk_delete"]		= {type: dt_real, value: vk_delete		}
console_macros [$ "vk_divide"]		= {type: dt_real, value: vk_divide		}
console_macros [$ "vk_end"]			= {type: dt_real, value: vk_end			}
console_macros [$ "vk_f1"]			= {type: dt_real, value: vk_f1			}
console_macros [$ "vk_f2"]			= {type: dt_real, value: vk_f2			}
console_macros [$ "vk_f3"]			= {type: dt_real, value: vk_f3			}
console_macros [$ "vk_f4"]			= {type: dt_real, value: vk_f4			}
console_macros [$ "vk_f5"]			= {type: dt_real, value: vk_f5			}
console_macros [$ "vk_f6"]			= {type: dt_real, value: vk_f6			}
console_macros [$ "vk_f7"]			= {type: dt_real, value: vk_f7			}
console_macros [$ "vk_f8"]			= {type: dt_real, value: vk_f8			}
console_macros [$ "vk_f9"]			= {type: dt_real, value: vk_f9			}
console_macros [$ "vk_f10"]			= {type: dt_real, value: vk_f10			}
console_macros [$ "vk_f11"]			= {type: dt_real, value: vk_f11			}
console_macros [$ "vk_f12"]			= {type: dt_real, value: vk_f12			}
console_macros [$ "vk_home"]		= {type: dt_real, value: vk_home		}
console_macros [$ "vk_insert"]		= {type: dt_real, value: vk_insert		}
console_macros [$ "vk_lalt"]		= {type: dt_real, value: vk_lalt		}
console_macros [$ "vk_lcontrol"]	= {type: dt_real, value: vk_lcontrol	}
console_macros [$ "vk_lshift"]		= {type: dt_real, value: vk_lshift		}
console_macros [$ "vk_multiply"]	= {type: dt_real, value: vk_multiply	}
console_macros [$ "vk_numpad0"]		= {type: dt_real, value: vk_numpad0		}
console_macros [$ "vk_numpad1"]		= {type: dt_real, value: vk_numpad1		}
console_macros [$ "vk_numpad2"]		= {type: dt_real, value: vk_numpad2		}
console_macros [$ "vk_numpad3"]		= {type: dt_real, value: vk_numpad3		}
console_macros [$ "vk_numpad4"]		= {type: dt_real, value: vk_numpad4		}
console_macros [$ "vk_numpad5"]		= {type: dt_real, value: vk_numpad5		}
console_macros [$ "vk_numpad6"]		= {type: dt_real, value: vk_numpad6		}
console_macros [$ "vk_numpad7"]		= {type: dt_real, value: vk_numpad7		}
console_macros [$ "vk_numpad8"]		= {type: dt_real, value: vk_numpad8		}
console_macros [$ "vk_numpad9"]		= {type: dt_real, value: vk_numpad9		}
console_macros [$ "vk_pagedown"]	= {type: dt_real, value: vk_pagedown	}
console_macros [$ "vk_pageup"]		= {type: dt_real, value: vk_pageup		}
console_macros [$ "vk_pause"]		= {type: dt_real, value: vk_pause		}
console_macros [$ "vk_printscreen"]	= {type: dt_real, value: vk_printscreen	}
console_macros [$ "vk_ralt"]		= {type: dt_real, value: vk_ralt		}
console_macros [$ "vk_rcontrol"]	= {type: dt_real, value: vk_rcontrol	}
console_macros [$ "vk_return"]		= {type: dt_real, value: vk_return		}
console_macros [$ "vk_rshift"]		= {type: dt_real, value: vk_rshift		}
console_macros [$ "vk_subtract"]	= {type: dt_real, value: vk_subtract	}
}
#endregion

#region Builtin methods
console_macros [$ "instance_create_layer"]		= {type: dt_method, value: instance_create_layer}
console_macros [$ "instance_destroy"]			= {type: dt_method, value: instance_destroy}

console_macros [$ "show_message"]				= {type: dt_method, value: show_message}

console_macros [$ "power"]						= {type: dt_method, value: power}

console_macros [$ "array_length"]				= {type: dt_method, value: array_length}

console_macros [$ "variable_instance_exists"]	= {type: dt_method, value: variable_instance_exists}
console_macros [$ "variable_instance_get"]		= {type: dt_method, value: variable_instance_get}
console_macros [$ "variable_instance_set"]		= {type: dt_method, value: variable_instance_exists}

console_macros [$ "variable_global_exists"]		= {type: dt_method, value: variable_global_exists}
console_macros [$ "variable_global_get"]		= {type: dt_method, value: variable_global_get}
console_macros [$ "variable_global_set"]		= {type: dt_method, value: variable_global_set}

console_macros [$ "variable_struct_exists"]		= {type: dt_method, value: variable_struct_exists}
console_macros [$ "variable_struct_get"]		= {type: dt_method, value: variable_struct_get}
console_macros [$ "variable_struct_set"]		= {type: dt_method, value: variable_struct_exists}

console_macros [$ "array_delete"]				= {type: dt_method, value: array_delete}
console_macros [$ "array_insert"]				= {type: dt_method, value: array_insert}
console_macros [$ "array_push"]					= {type: dt_method, value: array_push}

console_macros [$ "asset_get_type"]				= {type: dt_method, value: asset_get_type}

console_macros [$ "real"]						= {type: dt_method, value: real}

console_macros [$ "is_string"]					= {type: dt_method, value: is_string}
console_macros [$ "is_numeric"]					= {type: dt_method, value: is_numeric}

console_macros [$ "draw_set_color"]				= {type: dt_method, value: draw_set_color}
console_macros [$ "draw_set_alpha"]				= {type: dt_method, value: draw_set_alpha}
console_macros [$ "draw_set_halign"]			= {type: dt_method, value: draw_set_halign}
console_macros [$ "draw_set_valign"]			= {type: dt_method, value: draw_set_valign}
console_macros [$ "draw_set_font"]				= {type: dt_method, value: draw_set_font}
console_macros [$ "gpu_set_blendmode"]			= {type: dt_method, value: gpu_set_blendmode}
console_macros [$ "draw_reset_properties"]		= {type: dt_method, value: draw_reset_properties}

console_macros [$ "shader_reset"]				= {type: dt_method, value: shader_reset}
console_macros [$ "shader_set"]					= {type: dt_method, value: shader_set}
console_macros [$ "shader_set_uniform_f"]		= {type: dt_method, value: shader_set_uniform_f}
console_macros [$ "clip_rect_cutout"]			= {type: dt_method, value: clip_rect_cutout}

console_macros [$ "draw_line"]					= {type: dt_method, value: draw_line}
console_macros [$ "draw_line_width"]			= {type: dt_method, value: draw_line_width}
console_macros [$ "draw_point"]					= {type: dt_method, value: draw_point}
console_macros [$ "draw_rectangle"]				= {type: dt_method, value: draw_rectangle}
console_macros [$ "draw_circle"]				= {type: dt_method, value: draw_circle}
console_macros [$ "draw_sprite"]				= {type: dt_method, value: draw_sprite}
console_macros [$ "draw_sprite_ext"]			= {type: dt_method, value: draw_sprite_ext}
console_macros [$ "draw_sprite_pos"]			= {type: dt_method, value: draw_sprite_pos}
console_macros [$ "draw_sprite_general"]		= {type: dt_method, value: draw_sprite_general}
console_macros [$ "draw_text"]					= {type: dt_method, value: draw_text}
#endregion
}