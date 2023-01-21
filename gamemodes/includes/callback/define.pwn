
#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>

 
#define  YSI_NO_OPTIMISATION_MESSAGE
#define  YSI_NO_CACHE_MESSAGE
#define  YSI_NO_MODE_CACHE
#define  YSI_NO_HEAP_MALLOC
#define  YSI_NO_VERSION_CHECK

//จุดเกิดเด็กใหม่
#define SPAWN_POSX 2003.3595
#define SPAWN_POSY 1543.9191
#define SPAWN_POSZ 13.5859
#define SPAWN_POSA 274.7725
////////////////////////////
 
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))


#define		COLOR_BLACK				0x000000FF
#define     COLOR_WHITE         	0xFFFFFFFF
#define     COLOR_TG                0x76C3FFFF
#define 	COLOR_GREY				0xAFAFAFFF
#define     COLOR_RED           	0xFF0000FF
#define     COLOR_ORANGE        	0xFFA84DFF
#define     COLOR_YELLOW        	0xFFFF00FF
#define     COLOR_GREEN         	0x00FF00FF
#define 	COLOR_SERVER      		0xFFFF90FF
#define 	COLOR_FACTION     		0xBDF38BFF
#define 	COLOR_LIGHTRED    		0xFF6347FF
#define 	COLOR_LIGHTBLUE   		0x33CCFFAA
#define 	COLOR_DARKBLUE    		0x1394BFFF
#define 	DEFAULT_COLOR     		0xFFFFFFFF
#define     COLOR_ADMIN         	0xFF0080FF
#define 	COLOR_PURPLE      		0xD0AEEBFF
#define 	COLOR_DEPARTMENT  		0xF0CC00FF
#define 	COLOR_HOSPITAL    		0xFF8282FF
#define 	COLOR_RADIO       		0x8D8DFFFF
#define     COLOR_PINK              0xFF00FFFF
#define 	COLOR_CYAN        		0x33CCFFFF
#define     COLOR_VIP1      		0x00FF00FF
#define     COLOR_VIP2      		0xFFFF00FF
#define     COLOR_VIP3      		0xFF00FFFF