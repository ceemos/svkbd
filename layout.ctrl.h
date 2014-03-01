#define NO_REPEAT 1
static Key keys[] = {
	{ "↑", XK_Up, 1 },
	{ "↓", XK_Down, 1 },
	{ "←", XK_Left, 1 },
	{ "→", XK_Right, 1 },
	{ "menu", XK_KP_Multiply, 1 },
	{ "term", XK_KP_Divide, 1 },
	{ "surf", XK_KP_Add, 1} ,
	{ "kill", XK_KP_Subtract, 1 },
	{ "next", XK_KP_Delete, 1 },
	{ "swap", XK_KP_Enter, 1 },
	{ "Esc", XK_Escape, 1 },
	{ "[X]", XK_Cancel, 1},
};

Buttonmod buttonmods[] = {
	{ XK_Super_L, Button2 },
	{ XK_Control_L, Button3 },
};

