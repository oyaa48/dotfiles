//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{ "🔋 ",	"acpi -b | awk -F', ' '{printf \"%s \", $2}'",	30, 0 },
	{ "🎟️ "  , "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g"      , 30 , 0} ,
	{ "",		"date '+%b %d %a %H:%M'",			30, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
