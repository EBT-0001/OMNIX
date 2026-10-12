/*
	OMNIX Copyright (C) 2026  Temperlius
	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
	This is free software, and you are welcome to redistribute it
	under certain conditions; type `show c' for details.
*/

void main() {
	char* video_memory = (char*) 0xb8000;
	*video_memory = 'O';
}
