// Integration //
 - If you want to start the game displaying a variable or doing anything else with the console, put it in
   the console_startup script. It's automatically run at the end of the console's create event.
   
// Console help //
By default, the console key is tab. You can change this by changing the console_key variable.
You can also press shift+tab to quickely pull up the help menu.

This console operates in scopes. You can change the scope to a certain object by entering its name, or
you can type "object.variable" to access variables within objects outside of your scope, as it is in GML.

// Potential features //
 - The ability to scroll through console commands which exceed the length
 - Hovering over scripts in the commandline shows help
 - Undo and redo
 - Autofill and real time syntax errors
 - Enumerate support
 - Manual resizing of windows
 - Text icons
 - Menu constructors
 - The ability to access embeds by typing
 - Level editing tools
 - Console settings save file
 - (proper) array and DS support
 - (unlikely) support for scripts being run within scripts