
#include	<YSI_Coding\y_hooks>
#define     MAX_INVENTORY       	(1500)

enum INV_DATA {
	invExists,
	invID,
	invItem[32],
	invQuantity
};
new invData[MAX_PLAYERS][MAX_INVENTORY][INV_DATA];

enum ITEM_NAME_DATA {
	itemName[32]
};

//--> ใส่ไอเทม
new const itemData[][ITEM_NAME_DATA] = {
	{ "แอปเปิ้ล" },
	{ "แอปเปิ้ลแปรรูป" },
	{ "พิซซ่า" }, 
	{ "แฮมเบอร์เกอร์" }, 
	{ "ลาบ" },
	{ "เบ็ตตกปลา" },
	{ "ปูน" },
	{ "ปูสด" },
	{ "ปูแปรรูป" },
	{ "วัสดุแปรรูป" },
	{ "เต่า" }
};

forward OpenItemList(playerid);
public OpenItemList(playerid){
	new string[512],string2[512],string3[256],count,var[32];
    for (new i = 0; i < playerData[playerid][MaxItem]; i ++){
 		if (invData[playerid][i][invExists]) {
   			format(string, sizeof(string), "%s\t%d\n", invData[playerid][i][invItem], invData[playerid][i][invQuantity]);
   			strcat(string2, string);
   			format(var, sizeof(var), "itemlist%d", count);
   			SetPVarInt(playerid, var, i);
   			count++;
		}
	}
	if (!count) {
        Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR", "{FFFFFF}ตอนนี้ในตัวคุณไม่มีไอเทมชิ้นไหนเลยนะ", "ปิด", "");
		return 1;
	}
	playerData[playerid][ItemSelect] = 0;
	format(string, sizeof(string), "{FFFFFF}รายการ\t{FFFFFF}จำนวนที่มี\n%s",string2);
	format(string3, sizeof(string3), "{FF0000}INVENTORY %d/%d", Inventory_Items(playerid), playerData[playerid][MaxItem]);
	return Dialog_Show(playerid, DIALOG_INVENTORY, DIALOG_STYLE_TABLIST_HEADERS, string3, string, "เลือก", "ย้อนกลับ");
}
stock Inventory_Clear(playerid)
{
	static string[64];

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (invData[playerid][i][invExists])
	    {
	        invData[playerid][i][invExists] = 0;
	        invData[playerid][i][invQuantity] = 0;
		}
	}
	mysql_format(Database, string, sizeof(string), "DELETE FROM `Inventory` WHERE `invOwner` = '%d'", playerData[playerid][ID]);
	return mysql_tquery(Database, string);
}

stock Inventory_Set(playerid, const item[], amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
	{
		Inventory_Add(playerid, item, amount);
	}
	else if (amount > 0 && itemid != -1)
	{
	    Inventory_SetQuantity(playerid, item, amount);
	}
	else if (amount < 1 && itemid != -1)
	{
	    Inventory_Remove(playerid, item, -1);
	}
	return 1;
}

Inventory_GetItemID(playerid, const item[])
{
	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!invData[playerid][i][invExists])
	        continue;

		if (!strcmp(invData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= playerData[playerid][MaxItem])
		return -1;

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!invData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

Inventory_Items(playerid)
{
    new count;

    for (new i = 0; i != MAX_INVENTORY; i ++) if (invData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

Inventory_Count(playerid, const item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return invData[playerid][itemid][invQuantity];

	return 0;
}

stock Inventory_SetQuantity(playerid, const item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
		mysql_format(Database, string, sizeof(string), "UPDATE `Inventory` SET `invQuantity` = %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][ID], invData[playerid][itemid][invID]);
	    mysql_tquery(Database, string);

	    invData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}
stock Inventory_HasItem(playerid, const item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}
Inventory_Add(playerid, const item[], quantity)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        invData[playerid][itemid][invExists] = true;
	        //invData[playerid][itemid][invModel] = model;
	        invData[playerid][itemid][invQuantity] = quantity;

	        format(invData[playerid][itemid][invItem], 32, item);

			mysql_format(Database, string, sizeof(string), "INSERT INTO `Inventory` (`invOwner`, `invItem`, `invQuantity`) VALUES ('%d', '%e', '%d')", playerData[playerid][ID], item, quantity);
			mysql_tquery(Database, string, "OnInventoryAdd", "dd", playerid, itemid);

	        return itemid;
		}
		return -1;
	}
	else
	{
	    mysql_format(Database, string, sizeof(string), "UPDATE `Inventory` SET `invQuantity` = `invQuantity` + %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][ID], invData[playerid][itemid][invID]);
	    mysql_tquery(Database, string);

	    invData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

Inventory_Remove(playerid, const item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (invData[playerid][itemid][invQuantity] > 0)
	    {
	        invData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || invData[playerid][itemid][invQuantity] < 1)
		{
		    invData[playerid][itemid][invExists] = false;
		    invData[playerid][itemid][invQuantity] = 0;

		    mysql_format(Database, string, sizeof(string), "DELETE FROM `Inventory` WHERE `invOwner` = '%d' AND `invID` = '%d'", playerData[playerid][ID], invData[playerid][itemid][invID]);
	        mysql_tquery(Database, string);
		}
		else if (quantity != -1 && invData[playerid][itemid][invQuantity] > 0)
		{
			mysql_format(Database, string, sizeof(string), "UPDATE `Inventory` SET `invQuantity` = `invQuantity` - %d WHERE `invOwner` = '%d' AND `invID` = '%d'", quantity, playerData[playerid][ID], invData[playerid][itemid][invID]);
            mysql_tquery(Database, string);
		}
		return 1;
	}
	return 0;
}

forward Inventory_Load(playerid);
public Inventory_Load(playerid)
{
	static
	    rows;

	cache_get_row_count(rows);

	for (new i = 0; i < rows && i < MAX_INVENTORY; i ++) {
	    invData[playerid][i][invExists] = true;
	    cache_get_value_name_int(i, "invID", invData[playerid][i][invID]);
        cache_get_value_name_int(i, "invQuantity", invData[playerid][i][invQuantity]);

		cache_get_value_name(i, "invItem", invData[playerid][i][invItem], 32);
	}
	return 1;
}


Dialog:DIALOG_INVENTORYMENU(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		        OnPlayerUseItem(playerid, invData[playerid][playerData[playerid][ItemSelect]][invItem]);
		    }
		    case 1:
			{
				new string[1000], var[15], count;
				foreach(new i : Player) {
                    
					if (IsPlayerNearPlayer(playerid, i, 5.0))
					{
                        if(i == playerid) continue; // ย้ายมาไว้ตรงนี้ จะได้ไม่ต้องไปทำงานส่วนนั้น
						format(string, sizeof(string), "[ID: %d]\t%s\n", i, GetPlayerNameEx(i));
						count++;
						format(var, sizeof(var), "ID%d", count);
						SetPVarInt(playerid, var, i);
                        playerData[playerid][ItemOfferID] = i;
					}
				}
				if (!count)
				{
                    Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR", "{FFFFFF}ตอนนี้ไม่มีใครอยู่ใกล้กับคุณ!", "ปิด", "");
					return 1;
				}
				Dialog_Show(playerid, DIALOG_INVENTORYGIVEID, DIALOG_STYLE_TABLIST, invData[playerid][playerData[playerid][ItemSelect]][invItem], string, "เลือก", "ปิด");
		    }
		    case 2:
			{
		        new string[128],
				itemquantity = invData[playerid][playerData[playerid][ItemSelect]][invQuantity];
		        format(string, sizeof(string), "{FFFFFF}• {FF0000}PleaseSelect{FFFFFF} • \nใส่จำนวนที่ต้องการจะทิ้ง คุณมีอยู่ {FF0000}%d", itemquantity);
				Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][playerData[playerid][ItemSelect]][invItem], string, "ตกลง", "ปิด");
			}
		}
	}
	return 1;
}

Dialog:DIALOG_INVENTORYGIVEID(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new string[256], var[15];
        new itemid = playerData[playerid][ItemSelect];
        format(var, sizeof(var), "PID%d", listitem);
        new id = playerData[playerid][ItemOfferID];
        SendClientMessageEx(playerid, -1, "%s", ReturnPlayerName(id));
        //if(userid == playerid) continue; // ย้ายมาไว้ตรงนี้ จะได้ไม่ต้องไปทำงานส่วนนั้น
        format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s {FFFFFF}กับ {33CCFF}%s", invData[playerid][itemid][invItem], GetPlayerNameEx(id));
        Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
        playerData[playerid][ItemOfferID] = id;
    }
    return 1;
}

Dialog:DIALOG_INVENTORYGIVE(playerid, response, listitem, inputtext[])
{
	if (!response) return 1;
	
	new amount, string[256],
	itemid = playerData[playerid][ItemSelect],
	itemquantity = invData[playerid][itemid][invQuantity],
	userid = playerData[playerid][ItemOfferID],
	count = Inventory_Count(userid, invData[playerid][itemid][invItem])+amount;
			
	if (sscanf(inputtext, "d", amount))
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
		return 1;
	}
	if (amount < 1 || amount > 20)
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s\n{FF0000}*** จำนวนต้องไม่ต่ำกว่า 1 และไม่เกิน 20", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
		return 1;
	}
	if (invData[playerid][itemid][invQuantity] < amount)
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s\n{FF0000}*** %s ของคุณมีไม่เพียงพอที่จะให้ {FFFFFF}(%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), invData[playerid][itemid][invItem], amount, itemquantity);
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "เลือก", "ปิด");
		return 1;
	}
	if (count > playerData[userid][ItemAmount])
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s\n{FF0000}*** %s ของผู้เล่นไอดีนี้เต็มแล้ว {FFFFFF}(%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), invData[playerid][itemid][invItem], amount, count);
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "เลือก", "ปิด");
		return 1;
	}
	if (!IsPlayerNearPlayer(playerid, userid, 6.0))
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s\n{FF0000}*** ผู้เล่นไอดีนี้ไม่ได้อยู่ใกล้คุณ", invData[playerid][itemid][invItem], GetPlayerNameEx(userid));
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "เลือก", "ปิด");
		return 1;
	}

	new id = Inventory_Add(playerData[playerid][ItemOfferID], invData[playerid][itemid][invItem], amount);
	if (id == -1)
	{
		format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่คุณต้องการจะให้ {00FF00}%s{FFFFFF} กับ {33CCFF}%s\n{FF0000}*** ผู้เล่นไอดีนี้กระเป๋าเต็มแล้ว {FFFFFF}(%d/%d)", invData[playerid][itemid][invItem], GetPlayerNameEx(userid), Inventory_Items(userid), playerData[userid][MaxItem]);
		Dialog_Show(playerid, DIALOG_INVENTORYGIVE, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "เลือก", "ปิด");
		return 1;
	}
	Inventory_Remove(playerid, invData[playerid][itemid][invItem], amount);
	SendClientMessageEx(userid, -1, "%s{FFFFFF} ได้ให้ไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} กับคุณ", GetPlayerNameEx(playerid), invData[playerid][itemid][invItem], amount);
	SendClientMessageEx(playerid, -1, "คุณได้ให้ไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} กับ {33CCFF}%s", invData[playerid][itemid][invItem], amount, GetPlayerNameEx(userid));
	playerData[playerid][ItemOfferID] = INVALID_PLAYER_ID;
	return 1;
}

Dialog:DIALOG_INVENTORYDROP(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new amount, string[256],
	    itemid = playerData[playerid][ItemSelect],
		itemquantity = invData[playerid][itemid][invQuantity];
		if (sscanf(inputtext, "d", amount))
		{
	        format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่ต้องการจะทิ้ง คุณมีอยู่ {00FF00}%d", itemquantity);
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
	    	return 1;
		}
		if (amount < 1 || amount > 100)
		{
	        format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่ต้องการจะทิ้ง คุณมีอยู่ {00FF00}%d\n{FF0000}*** จำนวนต้องไม่ต่ำกว่า 1 และไม่เกิน 100", itemquantity);
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
	    	return 1;
		}
		if (invData[playerid][itemid][invQuantity] < amount)
		{
	        format(string, sizeof(string), "{FFFFFF}ใส่จำนวนที่ต้องการจะทิ้ง คุณมีอยู่ {00FF00}%d\n{FF0000}*** %s ของคุณมีไม่เพียงพอที่จะทิ้ง {FFFFFF}(%d/%d)", itemquantity, invData[playerid][itemid][invItem], amount, itemquantity);
			Dialog_Show(playerid, DIALOG_INVENTORYDROP, DIALOG_STYLE_INPUT, invData[playerid][itemid][invItem], string, "ตกลง", "ปิด");
		    return 1;
		}
		Inventory_Remove(playerid, invData[playerid][itemid][invItem], amount);
		ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 3.0, 0, 0, 0, 0, 0);
		SendClientMessageEx(playerid, -1, "คุณได้ทิ้งไอเท็ม {00FF00}%s {FFFFFF}จำนวน {00FF00}%d {FFFFFF}ชิ้น", invData[playerid][itemid][invItem], amount);
	}
	return 1;
}

Dialog:DIALOG_INVENTORY(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new var[32];
		format(var, sizeof(var), "itemlist%d", listitem);
		new item = GetPVarInt(playerid, var);

        OnPlayerClickItem(playerid, item, invData[playerid][item][invItem]);
	}
	return 1;
}

//--> เวลาใช้ไอเทม
forward OnPlayerUseItem(playerid, const name[]);
public OnPlayerUseItem(playerid, const name[])
{
	if (!strcmp(name, "แอปเปิ้ล", true)) 
    {
         Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, name, "{FFFFFF}ไอเทมชิ้นนี้ {F3FF00}%s{FFFFFF}\nสารถนำไปขายได้ที่ตลาด\nหรือนำไปแปรรูป\nเพื่อเพิ่มราคาสินค้า", "", "ปิด",name);
	}
	else if (!strcmp(name, "พิซซ่า", true))//--> พิซซ่า
	{
	    if (playerData[playerid][pHungry] >= 100)
	        return Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR", "{FFFFFF}คุณไม่หิวในขณะนี้", "ปิด", "");

		playerData[playerid][pHungry] += 60;
		Inventory_Remove(playerid, name);
		SendClientMessage(playerid, -1, "{FF0000}|========= ค่าตอบแทน =========|");
	    SendClientMessageEx(playerid, -1, "{FF0000}[FOOD] {FFFFFF}: คุณได้ทาน %s {FF9B00}+60{FFFFFF} ค่าอาหาร", name);
	}	
	else if (!strcmp(name, "แฮมเบอร์เกอร์", true))//--> แฮมเบอร์เกอร์
	{
	    if (playerData[playerid][pHungry] >= 100)
	        return Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR", "{FFFFFF}คุณไม่หิวในขณะนี้", "ปิด", "");

		playerData[playerid][pHungry] += 40;
		Inventory_Remove(playerid, name);
		SendClientMessage(playerid, -1, "{FF0000}|========= ค่าตอบแทน =========|");
	    SendClientMessageEx(playerid, -1, "{FF0000}[FOOD] {FFFFFF}: คุณได้ทาน %s {FF9B00}+60{FFFFFF} ค่าอาหาร", name);
	}	
	else if (!strcmp(name, "ลาบ", true))//--> ลาบ
	{
	    if (playerData[playerid][pHungry] >= 100)
	        return Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR", "{FFFFFF}คุณไม่หิวในขณะนี้", "ปิด", "");

		playerData[playerid][pHungry] += 20;
		Inventory_Remove(playerid, name);
		SendClientMessage(playerid, -1, "{FF0000}|========= ค่าตอบแทน =========|");
	    SendClientMessageEx(playerid, -1, "{FF0000}[FOOD] {FFFFFF}: คุณได้ทาน %s {FF9B00}+60{FFFFFF} ค่าอาหาร", name);
	}	
	else if (!strcmp(name, "เบ็ตตกปลา", true))//--> เบ็ตตกปลา
	{
	    Dialog_Show(playerid, Show, DIALOG_STYLE_MSGBOX, "{FF0000}เบ็ตตกปลา", "{FFFFFF}ใช้ในการทำงานตกปลา", "ปิด", "");
	}	
	return 1;
}

forward OnPlayerClickItem(playerid, itemid, const name[]);
public OnPlayerClickItem(playerid, itemid, const name[])
{
	if (!strcmp(name, "แฮมเบอร์เกอร์", true)) {
        Dialog_Show(playerid, DIALOG_INVENTORYMENU, DIALOG_STYLE_LIST, name, "กิน\nให้\nทิ้ง", "เลือก", "ปิด");
	}
	else if (!strcmp(name, "ลาบ", true)) {
        Dialog_Show(playerid, DIALOG_INVENTORYMENU, DIALOG_STYLE_LIST, name, "กิน\nให้\nทิ้ง", "เลือก", "ปิด");
	}
	else if (!strcmp(name, "พิซซ่า", true)) {
        Dialog_Show(playerid, DIALOG_INVENTORYMENU, DIALOG_STYLE_LIST, name, "กิน\nให้\nทิ้ง", "เลือก", "ปิด");
	}
	else
	{
		Dialog_Show(playerid, DIALOG_INVENTORYMENU, DIALOG_STYLE_LIST, name, "ใช้\nให้\nทิ้ง", "เลือก", "ปิด");
	}
	playerData[playerid][ItemSelect] = itemid;
 	return 1;
}
CMD:itemlist(playerid, params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	static
	    string[1024];

	if (!strlen(string)) {
		for (new i = 0; i < sizeof(itemData); i ++) {
			format(string, sizeof(string), "%s%s\n", string, itemData[i][itemName]);
		}
	}
	return Dialog_Show(playerid, DIALOG_SHOW, DIALOG_STYLE_LIST, "[รายชื่อไอเท็มทั้งหมด]", string, "ปิด", "");
}

CMD:giveitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/giveitem [ไอดี/ชื่อ] [ชื่อไอเท็ม] [จำนวน]");

	new count = Inventory_Count(userid, item)+amount;

	if (count > playerData[userid][ItemAmount])
        return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ความจุของ {00FF00}%s{FFFFFF} ของผู้เล่นนั้นเต็มแล้ว (%d/%d)", item, Inventory_Count(userid, item), playerData[userid][ItemAmount]);

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
		new id = Inventory_Add(userid, itemData[i][itemName], amount);

		if (id == -1)
		    return SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ความจุของกระเป๋าไม่เพียงพอ (%d/%d)", Inventory_Items(playerid), playerData[playerid][MaxItem]);

//	    Inventory_Add(userid, itemData[i][itemName], amount);
	    SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ให้ไอเท็ม %s จำนวน %d กับ %s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ให้ไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} กับ {33CCFF}%s", item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_WHITE, "คุณได้รับไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} จากแอดมิน {33CCFF}%s", item, amount, GetPlayerNameEx(userid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอเท็ม %s อยู่ในระบบ (คำสั่ง /itemlist ในการเช็ครายชื่อไอเท็ม)", item);
	return 1;
}

CMD:setitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/setitem [ไอดี/ชื่อ] [ชื่อไอเท็ม] [จำนวน]");

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
	    Inventory_Set(userid, itemData[i][itemName], amount);
	    SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ปรับไอเท็ม %s จำนวน %d ให้กับ %s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(playerid, COLOR_WHITE, "คุณได้ปรับไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} ให้กับ {33CCFF}%s", item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_WHITE, "คุณถูกปรับไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} โดยแอดมิน {33CCFF}%s", item, amount, GetPlayerNameEx(playerid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอเท็ม %s อยู่ในระบบ (คำสั่ง /itemlist ในการเช็ครายชื่อไอเท็ม)", item);
	return 1;
}

CMD:deleteitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	new userid, item[32], amount;
	if(sscanf(params, "us[32]d", userid, item, amount)) return SendClientMessage(playerid, COLOR_WHITE, "/deleteitem [ไอดี/ชื่อ] [ชื่อไอเท็ม] [จำนวน]");

	for (new i = 0; i < sizeof(itemData); i ++) if (!strcmp(itemData[i][itemName], item, true))
	{
	    Inventory_Remove(userid, item, amount);

        SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ลบไอเท็ม %s จำนวน %d ให้กับ %s", GetPlayerNameEx(playerid), item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(playerid, COLOR_WHITE, "คุณลบไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} ของ {33CCFF}%s", item, amount, GetPlayerNameEx(userid));
		SendClientMessageEx(userid, COLOR_WHITE, "คุณถูกลบไอเท็ม {00FF00}%s{FFFFFF} จำนวน {00FF00}%d{FFFFFF} โดยแอดมิน {33CCFF}%s", item, amount, GetPlayerNameEx(playerid));
		return 1;
	}
	SendClientMessageEx(playerid, COLOR_RED, "[ระบบ] {FFFFFF}ไม่มีไอเท็ม %s อยู่ในระบบ", item);
	return 1;
}

CMD:clearitem(playerid,params[])
{
    if (playerData[playerid][pAdmin] < 6)
	    return 1;

	new userid;
	if(sscanf(params, "u", userid)) return SendClientMessage(playerid, COLOR_WHITE, "/clearitem [ไอดี/ชื่อ]");

	Inventory_Clear(userid);

    SendAdminMessage(COLOR_ADMIN, "AdmLog: %s ได้ลบไอเท็มทั้งหมดของ %s", GetPlayerNameEx(playerid), GetPlayerNameEx(userid));
	SendClientMessageEx(playerid, COLOR_WHITE, "คุณลบไอเท็มทั้งหมดของ {33CCFF}%s", GetPlayerNameEx(userid));
	SendClientMessageEx(userid, COLOR_WHITE, "คุณถูกลบไอเท็มทั้งหมดโดยแอดมิน {33CCFF}%s", GetPlayerNameEx(playerid));
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){

    if(newkeys == KEY_YES){

        OpenItemList(playerid);
    }
    return 1;
}