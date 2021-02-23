
// Update //
Check version_log.txt for info on the new update!

// Integration //
 - Display variable values using the display function
 - Display console messages using the output_set function
 - Set the input using the input_set function - you could use this to hotkey commands, which is
   something I intend to add soon
 - Even send messages to the player using the window function! spooky!
 - You can run your own scripts with the console with little-to-no effort required, so long as it uses
   supported data types (unsupported ones include arrays, structs, and data structures, and you'll just
   have to code your way around them in the script at the moment).
 - If you want to start the game displaying a variable or doing anything else with the console, put it in
   the console_startup script. It's automatically run at the end of the console's create event.
 - Overall, integration beyond this is quite user unfriendly, and with the next major release I'll address 
   these issues.
   
// Console help //
By default, the console key is tab. You can change this by changing the console_key variable.
You can also press shift+tab to quickely pull up the help menu.

This console operates in scopes. You can change the scope to a certain object by entering its name, or
you can type "object.variable" to access variables within objects outside of your scope, as it is in GML.
Note that at the moment, scripts are executed within the scope of the console, not of the scoped object.

// Where's the log?? //
For this version, it's been temporarily disabled. It'll work in the full release of this version (which
probably won't be too long).

// Macros and built-in global variables //
Build-in global variables such as mouse_x have to be prefixed by "global.", and macros have to be added
manually, as there isn't a way to automatically search for them. Doing this is easy however, just add to
the switch statement in the macro_get script.

// Object identifier trouble //
As it is, the console currently relies on an object identifier in the name of the object to determine if a
data type is an object ID. You might prefix your object names with "o_" or "obj_". By default, it checks
for "o_". You can change it by changing the obj_identifier macro in the console create event. This system 
isn't very good because it doesn't support camel casing. For instance, if your objects were named 
as "oName", the identifier would have to be just "o", meaning you wouldn't be able to access any variables 
that start with an "o" properly. In later releases, I'll fix this. In the meantime however, I've added a 
universal object identifier, which is "o/". I'm not a fan of this solution, but it works for now.

// Potential features //
 - Struct support - Most of the work has been done there, just need to integrate it
 - All kinds of crazy text embedding features
 - The ability to scroll through console commands which exceed the length
 - Hovering over scripts in the commandline shows help
 - Undo and redo
 - Autofill and real time syntax errors
 - Better synchronization between GML and the console syntax
 - Color picker window
 - Sprite support
 - Variable value sliders
 - Buttons which activate a command when pressed
 - A command that allows you to specify another command to be run every frame
 - Text file logs
 - Enumerate support
 - Manual resizing of windows
 - Text icons
 - Menu constructors
 - Live updating variables within embedded text
 - Better support for users who disable embedded text
 - The ability to access embeds by typing
 - Performance graphs and review
 - Level editing tools
 - Console settings save file
 - (proper) struct and array support
 - (possibly?) universal data structure support
 - (unlikely) support for scripts being run within scripts