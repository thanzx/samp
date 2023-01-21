
#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <easyDialog>
#include <sscanf2>  
#include <crashdetect>
#include <Pawn.CMD>
 


#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>


new MySQL: Database;

#include "includes/callback/define.pwn"
#include "includes/callback/mysql.pwn"
#include "includes/callback/enums.pwn"
#include "includes/callback/login.pwn"
#include "includes/callback/upload.pwn"


//cmd
#include "includes/cmd/player.pwn"

//dynamics
#include "includes/dynamics/inv.inc"
//sytem
#include "includes/sytem/ui.pwn"
#include "includes/sytem/funtion.inc"
main(){
}
 
//----------------------------------
public OnGameModeInit(){
 
    new MySQLOpt: option_id = mysql_init_options();
    mysql_set_option(option_id, AUTO_RECONNECT, true); 
    Database = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
    if (Database == MYSQL_INVALID_HANDLE || mysql_errno(Database) != 0){
        print("MYSQL ERROR : SERVER OFF");
        SendRconCommand("exit"); 
        return 1;
    }
    mysql_set_charset("tis620");
    print("MySQL connection is successful.");
    DisableInteriorEnterExits();
    SetupPlayerTable();
    return 1;
}


