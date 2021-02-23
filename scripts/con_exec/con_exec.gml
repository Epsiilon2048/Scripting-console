
function con_exec(command){ with o_console {
//i think i documented this command just so i could get my head straight, so many off-by-ones...

static command_sep = [";"] //add \n later
static space_sep   = [",", "(", ")", "="]

//split the string into an array based on quotes, while excluding them if they have a backslash before
var quote_split = string_split_exclude("\"", command, "\\", "")
var startswith_quote = string_pos_exclude(command, "\"", "\\", "") != 1

//now iterate through the list and add quotes back in
for(var i = 0; i <= array_length(quote_split)-1; i++)
{
	if i % 2 == startswith_quote 
	{
		quote_split[i] = "\""+quote_split[i]+"\""
	}
}

//separate the quote split array by semi colons and combine
var command_split = []
var section
var i = 0

while array_length(quote_split) != 0
{
	if i >= array_length(quote_split)-1 or (string_pos("\"", quote_split[i]) != 1 and string_pos_multiple(command_sep, quote_split[i]))
	{
		section = array_create(i+1)
		array_copy(section, 0, quote_split, 0, i+1)
		
		array_push(command_split, section)
		array_delete(quote_split, 0, i+1)
	}
	else
	{
		i++
	}
}

return command_split
//for(var i = 0; i <= array_length(quote_split)-1; i++)  //RECURSIVE
//{
//	//if it's a string, wedontneedit!
//	if string_pos("\"", quote_split[i]) != 1 and string_pos_multiple(command_sep, quote_split[i])
//	{
//		//split the i of quote split by all of its command separators
//		var quote_sep = string_split_multiple(command_sep, quote_split[i])
		
//		//delete the item we just split
//		array_delete(quote_split, i, 1)
		
//		//...and copy the split array back to it
//		array_insert_array(quote_split, i, quote_sep)
//		//array_copy(quote_split, i, quote_sep, 0, array_length(quote_sep))

//		//the first entry in the quote sep should include all of the entries in the quote split between the marker and i
//		//the middle entries should all be on their own lines
//		//the last entry should be saved for later
//		//will be in nested arrays; the outer layer being the command separators and the inner layers being the arguments
//		//between those separators--which, we still need to separate out properly
//		quote_sep[0] = [quote_sep[0]]
		
//		array_copy(quote_sep[0], 0, quote_split, marker, i-marker+1)
//		array_push(command_split, quote_sep[0])
		
//		var len = array_length(quote_sep)
//		for(var j = 1; j <= len-2; j++)
//		{
//			show_message(j)
//			quote_sep[j] = [quote_sep[j]]
//			array_push(command_split, quote_sep[j])
//		}
		
		
//		i += array_length(quote_sep)-1
//		marker = i
//	}
//}
}}