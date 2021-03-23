--Script Spawn Sinh Vật có id là idMonster mỗi n giây.

--id sinh vật cần spawn
idMonster=123
--thời gian spawn (giây)
n=5 
--vị trí spawn
x=8
y=8
z=8
--số lượng spawn mỗi đợt
sl=1



function  SpawnMonster(params)
	if name==nil then
		name=Creature:getActorName(idMonster)
	end
	if params.second % n == 0 then
		local result,objids=World:spawnCreature(x,y,z,idMonster,sl)
		if result==1001 then
			print("Lỗi không thể spawn")
		else
			print("spawn thành công "..#objids.." x "..name)
		end
	end
end
ScriptSupportEvent:registerEvent("Game.RunTime", SpawnMonster)