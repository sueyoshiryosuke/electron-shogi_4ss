--170515 wcsc27 �C���� �N�W�����������B�]���l��pv���悪������ƕ\�������悤�ɒ����ł����B
--170524 ���@�萶���i���E����܂ށj�̏C���B�w���萶���Ղ�̕\���B
--170524 �w���萶�����x�A���@�萶���֐��Ɏw����z��̐��������Ă����Ƃ��A
--�@�@�@�@�@�@�C���^�v�����^��500nps�Bluvi��1300nps�B
--170524 �w���萶�����x�A���@�萶���֐�����w����z��̐������o�����Ƃ��A
--�@�@�@�@�@�@�C���^�v�����^��3000nps�Bluvi��7500nps�B
--170524 �w���萶�����x�A�w����z��̍Ō�ɏI���̐���999����ꂽ�Ƃ��A
--�@�@�@�@�@�@�C���^�v�����^��3300nps�Bluvi��8000nps�B
--������u���ƁA������̂ŁA��������悤�ɂ���K�v����B��0601�ρB
--170529 �z�u�̎�����ɁA����ǉ������̂ŁA�v������0530�ρB
--170601 ���܂Ɍ����s���ŗ�����H

function hajime()
end

--[[
--swtch���̓���
function switch(c)
    local swtbl = {
        casevar = c,
        caseof = function (self, code)
            local f
            if (self.casevar) then
                f = code[self.casevar] or code.default
            else
                f = code.default
            end
            if f then
                if type(f)=="function" then
                    return f(self.casevar,self)
                else
                    error("case "..tostring(self.casevar).." not a function")
                end
            end
        end
    }
    return swtbl
end
]]

--[[
switch���̎g�����̗�
�P�j�����̏ꍇ
suuji = 1
switch(suuji) : caseof {
    [1]   = function(x)
              print(x,"one")
            end,
    [2]   = function(x) print(x,"two") end,
    [3]   = 12345, -- �G���[
  default = function (x) print(x,"default") end,
}
 
�Q) ������̏ꍇ
bunsyou = "abc"
switch(bunsyou) : caseof {
  ['abc']   = function (x) print("bunsyou��",x) end,
  ['def']   = function (x) print(x,"bunsyou �� def") end,
  ['ddd']   = 12345, -- �G���[
  default = function (x) print(x,"default") end,
}
]]--


--�O���[�o���ϐ�
--�z���Lua�ł́u�e�[�u���v�Ɋ܂�
--[[�Ֆʂ̔z�u�̋���ۂ̃e�[�u���B
�Ֆʂ̔Ԓn��1����121�B�ǂɂ�-1�B
122����137�܂Ŏ�����̖����B
���
122 �� ��101�Ƃ̍���+21
123 ��
124 �j
125 ��
126 ��
127 �p
128 ��
129 ��
���
130 �� ��201�Ƃ̍���-71
131 ��
132 �j
133 ��
134 ��
135 �p
136 ��
137 ��

/*
�����ՂƃR�}���h�̕ϊ��\
 ��| �X, �W, �V, �U, �T, �S, �R, �Q, �P| ��|
---|-----------------------------------|---|
  1|  2,  3,  4,  5,  6,  7,  8,  9, 10| 11|��
---|-----------------------------------|---|
 12| 13, 14, 15, 16, 17, 18, 19, 20, 21| 22|��
   | 9a, 8a, 7a, 6a, 5a, 4a, 3a, 2a, 1a|   |a��
 23| 24, 25, 26, 27, 28, 29, 30, 31, 32| 33|��
   | 9b, 8b, 7b, 6b, 5b, 4b, 3b, 2b, 1b|   |b��
 34| 35, 36, 37, 38, 39, 40, 41, 42, 43| 44|�O
   | 9c, 8c, 7c, 6c, 5c, 4c, 3c, 2c, 1c|   |c��
 45| 46, 47, 48, 49, 50, 51, 52, 53, 54| 55|�l
   | 9d, 8d, 7d, 6d, 5d, 4d, 3d, 2d, 1d|   |d��
 56| 57, 58, 59, 60, 61, 62, 63, 64, 65| 66|��
   | 9e, 8e, 7e, 6e, 5e, 4e, 3e, 2e, 1e|   |e��
 67| 68, 69, 70, 71, 72, 73, 74, 75, 76| 77|�Z
   | 9f, 8f, 7f, 6f, 5f, 4f, 3f, 2f, 1f|   |f��
 78| 79, 80, 81, 82, 83, 84, 85, 86, 87| 88|��
   | 9g, 8g, 7g, 6g, 5g, 4g, 3g, 2g, 1g|   |g��
 89| 90, 91, 92, 93, 94, 95, 96, 97, 98| 99|��
   | 9h, 8h, 7h, 6h, 5h, 4h, 3h, 2h, 1h|   |h��
100|101,102,103,104,105,106,107,108,109|110|��
   | 9i, 8i, 7i, 6i, 5i, 4i, 3i, 2i, 1i|   |i��
---|-----------------------------------|---|
111|112,113,114,115,116,117,118,119,120|121|��

�ǂɂ�-1�A����ۂ�0�ł��B
]]

HaitiKara={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   0, 0, 0, 0, 0, 0, 0, 0,
   0, 0, 0, 0, 0, 0, 0, 0}
--����,��,�j,��,��,�p,��,��

HaitiGenzai={} --���݂̔Ֆʂ̔z�u�e�[�u���B
HaitiYomi={} --�ǂ݂̔Ֆʂ̔z�u�e�[�u���B
HaitiItiji={} --���݂̔Ֆʂ��ꎞ�ێ�����z�u�e�[�u���B
--startpos�Ֆʂ̏����z�u�̃e�[�u���B
HaitiStaPos={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,202,203,204,205,208,205,204,203,202,-1,
-1,0,207,0,0,0,0,0,206,0,-1,
-1,201,201,201,201,201,201,201,201,201,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,0,0,0,0,0,0,0,0,0,-1,
-1,101,101,101,101,101,101,101,101,101,-1,
-1,0,106,0,0,0,0,0,107,0,-1,
-1,102,103,104,105,108,105,104,103,102,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
   0, 0, 0, 0, 0, 0, 0, 0,
   0, 0, 0, 0, 0, 0, 0, 0}

gouhousyukazu=0

HaitiHyouji={} --�ǖʕ\������Ƃ��p�̕�����̔z��

-- Sasite[�w����̌�␔][1:���Ԓn�A2:���̋��A3:��Ԓn�A4:��̋��A5:����+10]
--1:999�Ȃ�w������͏I���B200�Ȃ���őłA-200�Ȃ���őłB
  Sasite = {}  -- �w���������z��𐶐�
  SasiteItiji={}  -- �ꎞ�I�Ɏw���������z��𐶐�
for i = 1, 600 do
  Sasite[i] = {}		-- Sasite�z��̍s�̍쐬
  SasiteItiji[i] = {}		-- SasiteItiji�z��̍s�̍쐬
  for j = 1, 5 do
    Sasite[i][j]  = 0
    SasiteItiji[i][j]  = 0
  end
end


motikomakati={125,225,325,525,625,825,925, -125,-225,-325,-525,-625,-825,-925}  --������̉��l
--motikomakati={150,250,350,550,650,850,950, -150,-250,-350,-550,-650,-850,-950}  --������̉��l
komakati =   { 75,175,275,475,575,775,875,10000,575,1175,1275,  -75,-175,-275,-475,-575,-775,-875,-10000,-575,-1175,-1275} --�Տ�̋�̉��l
--komakati =   {100,200,300,500,600,800,900,10000,600,1200,1300, -100,-200,-300,-500,-600,-800,-900,-10000,-600,-1200,-1300} --�Տ�̋�̉��l
--      ���  1���A2���A3�j�A4��A5���A6�p�A7��A8��(1��)�A9�����A10�n�A11��
--      ���  12���A13���A14�j�A15��A16���A17�p�A18��A19��(1��)�A20�����A21�n�A22��
--���1���������A������1������遁���1������+200

sentetoku=0
gotetoku=0
sentemamorikazu=0
gotemamorikazu=0
sentemamoriten=0
gotemamoriten=0
saigonoiti=0

--�����܂ŃO���[�o���ϐ�

--USI�G���W���o�^�̊֐�
function TourokuMati()
  while true do
    uketori=io.read()
    
    io.stdout:setvbuf("no") --�o�͂��o�b�t�@�����O���Ȃ��ݒ�B
      
    print("["..uketori.."]")

    --usi�G���W���o�^
    if uketori == "usi" then
      print("id name 16-168kai-1706")
      --print�֐��́A�Ō�ɉ��s���t��
      print("id author R.Sueyoshi")
      print("usiok")
    end

    --�I���R�}���h
    if uketori == "quit" then
      break
    end

    --�΋Ǐ���
    if uketori == "isready" then
      print("readyok")
    end

    if uketori == "usinewgame" or uketori == "a" then
    --�ua�v�Ɠ��͂��Ă��uusinewgame�v�����������B�R�}���h���C���p�B
      break
    end

  end

end

--���݂̔Ֆʂɋ���ۂ̔Ֆʂ�������֐�
--[[
�����ՂƃR�}���h�̕ϊ��\
 ��| �X, �W, �V, �U, �T, �S, �R, �Q, �P| ��|
---|-----------------------------------|---|
  1|  2,  3,  4,  5,  6,  7,  8,  9, 10| 11|��
---|-----------------------------------|---|
 12| 13, 14, 15, 16, 17, 18, 19, 20, 21| 22|��
   | 9a, 8a, 7a, 6a, 5a, 4a, 3a, 2a, 1a|   |a��
 23| 24, 25, 26, 27, 28, 29, 30, 31, 32| 33|��
   | 9b, 8b, 7b, 6b, 5b, 4b, 3b, 2b, 1b|   |b��
 34| 35, 36, 37, 38, 39, 40, 41, 42, 43| 44|�O
   | 9c, 8c, 7c, 6c, 5c, 4c, 3c, 2c, 1c|   |c��
 45| 46, 47, 48, 49, 50, 51, 52, 53, 54| 55|�l
   | 9d, 8d, 7d, 6d, 5d, 4d, 3d, 2d, 1d|   |d��
 56| 57, 58, 59, 60, 61, 62, 63, 64, 65| 66|��
   | 9e, 8e, 7e, 6e, 5e, 4e, 3e, 2e, 1e|   |e��
 67| 68, 69, 70, 71, 72, 73, 74, 75, 76| 77|�Z
   | 9f, 8f, 7f, 6f, 5f, 4f, 3f, 2f, 1f|   |f��
 78| 79, 80, 81, 82, 83, 84, 85, 86, 87| 88|��
   | 9g, 8g, 7g, 6g, 5g, 4g, 3g, 2g, 1g|   |g��
 89| 90, 91, 92, 93, 94, 95, 96, 97, 98| 99|��
   | 9h, 8h, 7h, 6h, 5h, 4h, 3h, 2h, 1h|   |h��
100|101,102,103,104,105,106,107,108,109|110|��
   | 9i, 8i, 7i, 6i, 5i, 4i, 3i, 2i, 1i|   |i��
---|-----------------------------------|---|
111|112,113,114,115,116,117,118,119,120|121|��

�ǂɂ�-1�A�Տ��0��������
]]
function BanmenSyokika()
  HaitiGenzai={unpack(HaitiKara)}
  --�e�[�u�����R�s�[����Ƃ�unpack���g��Ȃ��ƘA������B{�@}��Y�ꂸ�ɁB
end


--���݂̔Ֆʂ�StartPos�̔z�u��������֐�
function StaPosHaiti()
  HaitiGenzai={unpack(HaitiStaPos)}
end

--����������������֐�
function UgokeruTe()
--[[
�g������
-24,-23,-22,-21,-20
-13,-12,-11,-10, -9
 -2, -1,[0],  1,  2
  9, 10, 11, 12, 13
 20, 21, 22, 23, 24
--]]
  
  ugokeru={} --������2�����e�[�u���̐���
  for i=101,217 do
   ugokeru[i]={}		--�s�̍쐬
    for j=1,36 do
     ugokeru[i][j]=0 --�Ƃ肠����0����
    end
  end
  
	ugokeru[101][1]=-11 --���̕��̓�����Ƃ���
                   --���̍��̓�����Ƃ���
  for ugoki=1,8 do
   ugokeru[102][ugoki]=-11*ugoki
  end
  ugokeru[103][1]=-23 --���̌j�̓�����Ƃ���
  ugokeru[103][2]=-21 --���̌j�̓�����Ƃ���
  ugokeru[104][1]=-12 --���̋�̓�����Ƃ���
  ugokeru[104][2]=-11 --���̋�̓�����Ƃ���
  ugokeru[104][3]=-10 --���̋�̓�����Ƃ���
  ugokeru[104][4]= 10 --���̋�̓�����Ƃ���
  ugokeru[104][5]= 12 --���̋�̓�����Ƃ���
  ugokeru[105][1]=-10 --���̋��̓�����Ƃ���
  ugokeru[105][2]=-12 --���̋��̓�����Ƃ���
  ugokeru[105][3]=-11 --���̋��̓�����Ƃ���
  ugokeru[105][4]= -1 --���̋��̓�����Ƃ���
  ugokeru[105][5]=  1 --���̋��̓�����Ƃ���
  ugokeru[105][6]= 11 --���̋��̓�����Ƃ���
                       --���̊p�̓�����Ƃ���
  for ugoki=1,8 do
     ugokeru[106][ugoki]=-12*ugoki
     ugokeru[106][ugoki+8]=12*ugoki
     ugokeru[106][ugoki+16]=-10*ugoki
     ugokeru[106][ugoki+24]=10*ugoki
  end
                       --���̔�̓�����Ƃ���
  for ugoki=1,8 do
     ugokeru[107][ugoki]=-11*ugoki
     ugokeru[107][ugoki+8]=11*ugoki
     ugokeru[107][ugoki+16]=-1*ugoki
     ugokeru[107][ugoki+24]=1*ugoki
  end
  ugokeru[108][1]=-12 --���̉��̓�����Ƃ���
  ugokeru[108][2]=-11 --���̉��̓�����Ƃ���
  ugokeru[108][3]=-10 --���̉��̓�����Ƃ���
  ugokeru[108][4]= -1 --���̉��̓�����Ƃ���
  ugokeru[108][5]=  1 --���̉��̓�����Ƃ���
  ugokeru[108][6]= 10 --���̉��̓�����Ƃ���
  ugokeru[108][7]= 11 --���̉��̓�����Ƃ���
  ugokeru[108][8]= 12 --���̉��̓�����Ƃ���

  ugokeru[111][1]=-10 --���̂Ƃ̓�����Ƃ���
  ugokeru[111][2]=-12 --���̂Ƃ̓�����Ƃ���
  ugokeru[111][3]=-11 --���̂Ƃ̓�����Ƃ���
  ugokeru[111][4]= -1 --���̂Ƃ̓�����Ƃ���
  ugokeru[111][5]=  1 --���̂Ƃ̓�����Ƃ���
  ugokeru[111][6]= 11 --���̂Ƃ̓�����Ƃ���
  ugokeru[112][1]=-10 --���̈ǂ̓�����Ƃ���
  ugokeru[112][2]=-12 --���̈ǂ̓�����Ƃ���
  ugokeru[112][3]=-11 --���̈ǂ̓�����Ƃ���
  ugokeru[112][4]= -1 --���̈ǂ̓�����Ƃ���
  ugokeru[112][5]=  1 --���̈ǂ̓�����Ƃ���
  ugokeru[112][6]= 11 --���̈ǂ̓�����Ƃ���
  ugokeru[113][1]=-10 --���̌\�̓�����Ƃ���
  ugokeru[113][2]=-12 --���̌\�̓�����Ƃ���
  ugokeru[113][3]=-11 --���̌\�̓�����Ƃ���
  ugokeru[113][4]= -1 --���̌\�̓�����Ƃ���
  ugokeru[113][5]=  1 --���̌\�̓�����Ƃ���
  ugokeru[113][6]= 11 --���̌\�̓�����Ƃ���
  ugokeru[114][1]=-10 --���̑S�̓�����Ƃ���
  ugokeru[114][2]=-12 --���̑S�̓�����Ƃ���
  ugokeru[114][3]=-11 --���̑S�̓�����Ƃ���
  ugokeru[114][4]= -1 --���̑S�̓�����Ƃ���
  ugokeru[114][5]=  1 --���̑S�̓�����Ƃ���
  ugokeru[114][6]= 11 --���̑S�̓�����Ƃ���
                        --���̔n�̓�����Ƃ���
  for ugoki=1,8 do
    ugokeru[116][ugoki]=-12*ugoki
    ugokeru[116][ugoki+8]=12*ugoki
    ugokeru[116][ugoki+16]=-10*ugoki
    ugokeru[116][ugoki+24]=10*ugoki
  end
  ugokeru[116][33]=-11 --���̔n�̓�����Ƃ���
  ugokeru[116][34]= -1 --���̔n�̓�����Ƃ���
  ugokeru[116][35]=  1 --���̔n�̓�����Ƃ���
  ugokeru[116][36]= 11 --���̔n�̓�����Ƃ���
                         --���̗��̓�����Ƃ���
  for ugoki=1,8 do
     ugokeru[117][ugoki]=-11*ugoki
     ugokeru[117][ugoki+8]=11*ugoki
     ugokeru[117][ugoki+16]=-1*ugoki
     ugokeru[117][ugoki+24]=1*ugoki
  end
  ugokeru[117][33]=-12 --���̗��̓�����Ƃ���
  ugokeru[117][34]=-10 --���̗��̓�����Ƃ���
  ugokeru[117][35]= 10 --���̗��̓�����Ƃ���
  ugokeru[117][36]= 12 --���̗��̓�����Ƃ���

  ugokeru[201][1]= 11 --���̕��̓�����Ƃ���
                   --���̍��̓�����Ƃ���
   for ugoki=1,8 do
      ugokeru[202][ugoki]=11*ugoki
   end
   ugokeru[203][1]= 21 --���̌j�̓�����Ƃ���
   ugokeru[203][2]= 23 --���̌j�̓�����Ƃ���
   ugokeru[204][1]=-12 --���̋�̓�����Ƃ���
   ugokeru[204][2]=-10 --���̋�̓�����Ƃ���
   ugokeru[204][3]= 10 --���̋�̓�����Ƃ���
   ugokeru[204][4]= 11 --���̋�̓�����Ƃ���
   ugokeru[204][5]= 12 --���̋�̓�����Ƃ���
   ugokeru[205][1]=-11 --���̋��̓�����Ƃ���
   ugokeru[205][2]= -1 --���̋��̓�����Ƃ���
   ugokeru[205][3]=  1 --���̋��̓�����Ƃ���
   ugokeru[205][4]= 10 --���̋��̓�����Ƃ���
   ugokeru[205][5]= 11 --���̋��̓�����Ƃ���
   ugokeru[205][6]= 12 --���̋��̓�����Ƃ���
                        --���̊p�̓�����Ƃ���
   for ugoki=1,8 do
      ugokeru[206][ugoki]=-12*ugoki
      ugokeru[206][ugoki+8]=12*ugoki
      ugokeru[206][ugoki+16]=-10*ugoki
      ugokeru[206][ugoki+24]=10*ugoki
   end
                        --���̔�̓�����Ƃ���
   for ugoki=1,8 do
      ugokeru[207][ugoki]=-11*ugoki
      ugokeru[207][ugoki+8]=11*ugoki
      ugokeru[207][ugoki+16]=-1*ugoki
      ugokeru[207][ugoki+24]=1*ugoki
   end
   ugokeru[208][1]=-12 --���̉��̓�����Ƃ���
   ugokeru[208][2]=-11 --���̉��̓�����Ƃ���
   ugokeru[208][3]=-10 --���̉��̓�����Ƃ���
   ugokeru[208][4]= -1 --���̉��̓�����Ƃ���
   ugokeru[208][5]=  1 --���̉��̓�����Ƃ���
   ugokeru[208][6]= 10 --���̉��̓�����Ƃ���
   ugokeru[208][7]= 11 --���̉��̓�����Ƃ���
   ugokeru[208][8]= 12 --���̉��̓�����Ƃ���
   ugokeru[211][1]=-11 --���̂Ƃ̓�����Ƃ���
   ugokeru[211][2]= -1 --���̂Ƃ̓�����Ƃ���
   ugokeru[211][3]=  1 --���̂Ƃ̓�����Ƃ���
   ugokeru[211][4]= 10 --���̂Ƃ̓�����Ƃ���
   ugokeru[211][5]= 11 --���̂Ƃ̓�����Ƃ���
   ugokeru[211][6]= 12 --���̂Ƃ̓�����Ƃ���
   ugokeru[212][1]=-11 --���̈ǂ̓�����Ƃ���
   ugokeru[212][2]= -1 --���̈ǂ̓�����Ƃ���
   ugokeru[212][3]=  1 --���̈ǂ̓�����Ƃ���
   ugokeru[212][4]= 10 --���̈ǂ̓�����Ƃ���
   ugokeru[212][5]= 11 --���̈ǂ̓�����Ƃ���
   ugokeru[212][6]= 12 --���̈ǂ̓�����Ƃ���
   ugokeru[213][1]=-11 --���̌\�̓�����Ƃ���
   ugokeru[213][2]= -1 --���̌\�̓�����Ƃ���
   ugokeru[213][3]=  1 --���̌\�̓�����Ƃ���
   ugokeru[213][4]= 10 --���̌\�̓�����Ƃ���
   ugokeru[213][5]= 11 --���̌\�̓�����Ƃ���
   ugokeru[213][6]= 12 --���̌\�̓�����Ƃ���
   ugokeru[214][1]=-11 --���̑S�̓�����Ƃ���
   ugokeru[214][2]= -1 --���̑S�̓�����Ƃ���
   ugokeru[214][3]=  1 --���̑S�̓�����Ƃ���
   ugokeru[214][4]= 10 --���̑S�̓�����Ƃ���
   ugokeru[214][5]= 11 --���̑S�̓�����Ƃ���
   ugokeru[214][6]= 12 --���̑S�̓�����Ƃ���
                        --���̔n�̓�����Ƃ���
   for ugoki=1,8 do
      ugokeru[216][ugoki]=-12*ugoki
      ugokeru[216][ugoki+8]=12*ugoki
      ugokeru[216][ugoki+16]=-10*ugoki
      ugokeru[216][ugoki+24]=10*ugoki
   end
   ugokeru[216][33]=-11 --���̔n�̓�����Ƃ���
   ugokeru[216][34]= -1 --���̔n�̓�����Ƃ���
   ugokeru[216][35]=  1 --���̔n�̓�����Ƃ���
   ugokeru[216][36]= 11 --���̔n�̓�����Ƃ���
                         --���̗��̓�����Ƃ���
   for ugoki=1,8 do
      ugokeru[217][ugoki]=-11*ugoki
      ugokeru[217][ugoki+8]=11*ugoki
      ugokeru[217][ugoki+16]=-1*ugoki
      ugokeru[217][ugoki+24]=1*ugoki
   end
   ugokeru[217][33]=-12 --���̗��̓�����Ƃ���
   ugokeru[217][34]=-10 --���̗��̓�����Ƃ���
   ugokeru[217][35]= 10 --���̗��̓�����Ƃ���
   ugokeru[217][36]= 12 --���̗��̓�����Ƃ���
   
end

--����������̃R�}���h�҂��̊֐�
function NyuryokuMati()
  while true do
    uketori=io.read()
    
    io.stdout:setvbuf("no") --�o�͂��o�b�t�@�����O���Ȃ��ݒ�B
      
--    print("["..uketori.."]") --���͕����̊m�F�p

    --�I���R�}���h
    if uketori == "quit" then
      break
    end

    --�΋Ǐ���
    if uketori == "isready" then
      print("readyok")
    end
    
--[[���͂̏ȗ�
--]]
    if uketori == "s" then
      uketori="position startpos"
			--��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
      print([[�uposition startpos�v���Z�b�g���܂����B
�����́uc�v����͂��Ă��������B]])
    end
    
    if uketori == "t" then --�e�X�g�ǖ�
      uketori="position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b"
			--��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
      print([[�uposition startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b�v���Z�b�g���܂����B
�����́uc�v����͂��Ă��������B]])
    end
    
    if uketori == "c" then
      uketori="go btime 3599000 wtime 3597000 byoyomi 0"
    end  
    
 --[[�������̃G���W��1�ցi�܂��̓R�}���h���C���Łj�A
   �umaturi�v���蓮���͂����
		�����w���萶���Ղ�̋ǖʃZ�b�g�B���Ԃ�198��B���E��������199��B
--]]
    if uketori == "maturi" then
      uketori="position sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1"
			--��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
      print([[�w���萶���Ղ�̋ǖʃZ�b�g�uposition sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1�v���Z�b�g���܂����B
�����́umaturi2�v����͂��Ă��������B]])
    maturi=1 --�����́Amaturi2�ցB
    end
    
    if uketori == "maturi2" then
      if maturi~=1 then print("��Ɂumaturi�v����͂��Ă��������B")
      else HyojiMaturi() end --�Ղ�p�Ֆʕ\��
    end
    
    --hyouji�Ɠ��͂���ƁA�Ֆʏ󋵂�\������
    if uketori == "hyouji" then
     for i=1,121 do
       if HaitiGenzai[i]==101 then HaitiHyouji[i]="���@"
       elseif HaitiGenzai[i]==102 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==103 then HaitiHyouji[i]="�j "
       elseif HaitiGenzai[i]==104 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==105 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==106 then HaitiHyouji[i]="�p "
       elseif HaitiGenzai[i]==107 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==108 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==111 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==112 then HaitiHyouji[i]="�� "
       elseif HaitiGenzai[i]==113 then HaitiHyouji[i]="�� " --����j
       elseif HaitiGenzai[i]==114 then HaitiHyouji[i]="�S "
       elseif HaitiGenzai[i]==116 then HaitiHyouji[i]="�n "
       elseif HaitiGenzai[i]==117 then HaitiHyouji[i]="�� "
       
       elseif HaitiGenzai[i]==201 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==202 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==203 then HaitiHyouji[i]="�jv"
       elseif HaitiGenzai[i]==204 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==205 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==206 then HaitiHyouji[i]="�pv"
       elseif HaitiGenzai[i]==207 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==208 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==211 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==212 then HaitiHyouji[i]="��v"
       elseif HaitiGenzai[i]==213 then HaitiHyouji[i]="��v" --�j�n�̐���i�����u�j�̂��ւ�Ȃ��v���g���ƕ�����������j
       elseif HaitiGenzai[i]==214 then HaitiHyouji[i]="�Sv"
       elseif HaitiGenzai[i]==216 then HaitiHyouji[i]="�nv"
       elseif HaitiGenzai[i]==217 then HaitiHyouji[i]="��v"
       
       elseif HaitiGenzai[i]==-1 then HaitiHyouji[i]="// "
       elseif HaitiGenzai[i]==0 then HaitiHyouji[i]="�� "
       else
         HaitiHyouji[i]="0"
       end
       io.write(HaitiHyouji[i]..",") --���s�Ȃ��o��
       if i%11==0 then
         print("")
       end
     end
     print("")
     print("���̎�����F��"..HaitiGenzai[122].." ��"..HaitiGenzai[123].." �j"..HaitiGenzai[124]..
       " ��"..HaitiGenzai[125].." ��"..HaitiGenzai[126].." �p"..HaitiGenzai[127].." ��"..HaitiGenzai[128])
     print("���̎�����F��"..HaitiGenzai[130].." ��"..HaitiGenzai[131].." �j"..HaitiGenzai[132]..
       " ��"..HaitiGenzai[133].." ��"..HaitiGenzai[134].." �p"..HaitiGenzai[135].." ��"..HaitiGenzai[136])
       --���̍��@��̕\���͖���
     print("")
     print("����͂̎�ԁi���1�A���-1�j�F "..Teban) --sjis�̂Ƃ��u�\\�Z������͂̎�ԁF�v 
     print("���܂ł̎萔�F "..TeSuu)
    end

    --�ȉ��A�uposition�v�Ɓugo�v�R�}���h�̑Ή�  
    if string.match(uketori, "position st", n) ~= nil then --startpos��ݒ�
      Bunkatu()
      if BunkatuSuu==2 then
        Teban=1 --����͂̎�Ԃ����i1�j
        TeSuu=1
      elseif BunkatuSuu%2==1 then --��Ȃ���
        Teban=1
        TeSuu=BunkatuSuu-2 --moves�̎��̕������TeSuu=1
      elseif BunkatuSuu%2==0 then --�����Ȃ���
        Teban=-1 --����͂̎�Ԃ����i-1�j
        TeSuu=BunkatuSuu-2 --moves�̎��̕������TeSuu=1
      end
            
      for i=1,280 do --BunkatuMoji��1��ڂ��珇�ɑ�����Ă������[�v
       if BunkatuMoji[i]==nil then
         saigonoiti=BantiHeHenkan(AtoIti)  --�Ō�̑���̈���ۑ��B�ǋL170602
         break
       end
       HaitiDainyu(i) --4��������Ֆʂɑ������֐�
      end
    end
    
    if string.match(uketori, "position sf", n) ~= nil then --sfen��ݒ�
      Sfen()
      
      --[[
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 b Ps4p 1
      ��BunkatuSuu 6 �� �����
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 b Ps4p 1 moves S*8h 7g7f
      ��BunkatuSuu 9 �i��j �����
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 b Ps4p 1 moves S*8h
      ��BunkatuSuu 8 �i�����j �����
      
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 w Ps4p 1
      ��BunkatuSuu 6 �� �����
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 w Ps4p 1 moves S*8h 7g7f
      ��BunkatuSuu 9 �i��j �����
      position sfen 1n4snl/�i���j/2KG3+n1/LNSG5 w Ps4p 1 moves S*8h
      ��BunkatuSuu 8 �i�����j �����
      
      b�̂Ƃ��Amove����͐��
      w�̂Ƃ��Amove����͌��
      ]]--

      if BunkatuMoji[4]=="b" then
        if BunkatuSuu==6 then
          Teban=1 --����͂̎�Ԃ����i1�j
          TeSuu=1
        elseif BunkatuSuu%2==1 then --��Ȃ���
          Teban=1
          TeSuu=BunkatuSuu-6 --moves�̎��̕������TeSuu=1
        elseif BunkatuSuu%2==0 then --�����Ȃ���
          Teban=-1 --����͂̎�Ԃ����i-1�j
          TeSuu=BunkatuSuu-6 --moves�̎��̕������TeSuu=1
        end
      else --BunkatuMoji[4]=="w"�̂Ƃ�
        if BunkatuSuu==6 then
          Teban=-1 --����͂̎�Ԃ����i1�j
          TeSuu=1
        elseif BunkatuSuu%2==1 then --��Ȃ���
          Teban=-1
          TeSuu=BunkatuSuu-6 --moves�̎��̕������TeSuu=1
        elseif BunkatuSuu%2==0 then --�����Ȃ���
          Teban=1 --����͂̎�Ԃ����i-1�j
          TeSuu=BunkatuSuu-6 --moves�̎��̕������TeSuu=1
        end
      end
      
      
    end
    if string.match(uketori, "go b", n) ~= nil then --bestmove���l����
      --257��𒴂��Ă��邩���`�F�b�N
      if TeSuu>=257 then
        print("info string 257��𒴂��Ă��܂��I�H�c�c�܂���܂���orz")  --��������
        print("bestmove resign")  --��������
      end
     
      Gouhousyu(Teban)
      --2017/01/04�����܂ŁB���͂�������B
      --���Q�����z��̃R�s�[�B
      for i = 1, 600 do
        if Sasite[i][1]==999 then
          SasiteItiji[i][1]=999
          break
        end
        for j = 1, 5 do
          SasiteItiji[i][j]  = Sasite[i][j]
        end
      end
      --�����܂ŁA�Q�����z��̃R�s�[
      
      x=1
      tuikagouhousyukazu=0
      for i=1,600 do --���̈�肪�A����̍Ō�̎�̋߂����ǂ����B�Ȃ����ł�̎��A�������łƂ��Ƃ���B170602
        if SasiteItiji[i][1]==999 then
          Sasite[x][1]=999
          break
        end
        --���ʂׂ̗ɉ�����d�|���Ă�����A�ʂŎ��
        if SasiteItiji[i][3]==saigonoiti and (SasiteItiji[i][2]==108 or SasiteItiji[i][2]==208) then
          for j=1,5 do
            Sasite[1][j]=SasiteItiji[i][j]
            Sasite[2][1]=999
          tuikagouhousyukazu=1
          gouhousyukazu=1
          end
          break
        end
        
        if SasiteItiji[i][3]==saigonoiti-12 or SasiteItiji[i][3]==saigonoiti-11 or SasiteItiji[i][3]==saigonoiti-10 or
           SasiteItiji[i][3]==saigonoiti-1  or SasiteItiji[i][3]==saigonoiti   or SasiteItiji[i][3]==saigonoiti+1  or
           SasiteItiji[i][3]==saigonoiti+10 or SasiteItiji[i][3]==saigonoiti+11 or SasiteItiji[i][3]==saigonoiti+12 then          
          for j=1,5 do
            Sasite[x][j]=SasiteItiji[i][j]
          end
          tuikagouhousyukazu=x
          gouhousyukazu=x
          x=x+1
        end
      end
      
      --2017/5/3�����_���̍�����B
      math.randomseed(os.time())
      sasitebangou = math.random(gouhousyukazu) -- �P����gouhousyukazu���@�萔�܂ł̐��l
      
      --20170529 ������������ǂ�
      
      --����͂̉����Ƃ��邩�`�F�b�N
      Yomu(sasitebangou) --���ǂފ֐�
      
      HaitiItiji={unpack(HaitiGenzai)} --�ꎞ�I�z�u�Ɍ��ݔz�u��ޔ�
      HaitiGenzai={unpack(HaitiYomi)} --���ݔz�u�ɓǂݔz�u���R�s�[
      --�Q�����z��̏ꍇ�Aunpack�ł̓R�s�[�ł��Ȃ��B
      --���Q�����z��̃R�s�[�Bfor���ŃR�s�[���邵���Ȃ��H�H�H
      if Sasite[1][1]~=999 then
        for i = 1, 600 do
          for j = 1, 5 do
            SasiteItiji[i][j]  = Sasite[i][j]
          end
        end
      end
      --�����܂ŁA�Q�����z��̃R�s�[
      
      Gouhousyu(-Teban) --����̎��̍��@��̐���
      for i=1,600 do
        if Sasite[i][4]==108 or Sasite[i][4]==208 then
          print("info string �I�H�c�c�܂���܂���orz")  --��������
          print("bestmove resign")  --��������
        end
      end
      HaitiGenzai={unpack(HaitiItiji)} --���ݔz�u�����ɖ߂�
      for i = 1, 50 do
        for j = 1, 5 do
          Sasite[i][j]  = SasiteItiji[i][j]
        end
      end
      --�����܂ŁA����͂̉����Ƃ��邩�`�F�b�N
      
      --�����������ϊ�
      if Sasite[sasitebangou][1]==200 then
        if Sasite[sasitebangou][2]==101 then Sasite[sasitebangou][1]="P*" end
        if Sasite[sasitebangou][2]==102 then Sasite[sasitebangou][1]="L*" end
        if Sasite[sasitebangou][2]==103 then Sasite[sasitebangou][1]="N*" end
        if Sasite[sasitebangou][2]==104 then Sasite[sasitebangou][1]="S*" end
        if Sasite[sasitebangou][2]==105 then Sasite[sasitebangou][1]="G*" end
        if Sasite[sasitebangou][2]==106 then Sasite[sasitebangou][1]="B*" end
        if Sasite[sasitebangou][2]==107 then Sasite[sasitebangou][1]="R*" end
      end
      if Sasite[sasitebangou][1]==-200 then
        if Sasite[sasitebangou][2]==201 then Sasite[sasitebangou][1]="P*" end
        if Sasite[sasitebangou][2]==202 then Sasite[sasitebangou][1]="L*" end
        if Sasite[sasitebangou][2]==203 then Sasite[sasitebangou][1]="N*" end
        if Sasite[sasitebangou][2]==204 then Sasite[sasitebangou][1]="S*" end
        if Sasite[sasitebangou][2]==205 then Sasite[sasitebangou][1]="G*" end
        if Sasite[sasitebangou][2]==206 then Sasite[sasitebangou][1]="B*" end
        if Sasite[sasitebangou][2]==207 then Sasite[sasitebangou][1]="R*" end
      end
    
    for x=1,3,2 do
      if Sasite[sasitebangou][x]==13 then Sasite[sasitebangou][x]="9a" end
      if Sasite[sasitebangou][x]==14 then Sasite[sasitebangou][x]="8a" end
      if Sasite[sasitebangou][x]==15 then Sasite[sasitebangou][x]="7a" end
      if Sasite[sasitebangou][x]==16 then Sasite[sasitebangou][x]="6a" end
      if Sasite[sasitebangou][x]==17 then Sasite[sasitebangou][x]="5a" end
      if Sasite[sasitebangou][x]==18 then Sasite[sasitebangou][x]="4a" end
      if Sasite[sasitebangou][x]==19 then Sasite[sasitebangou][x]="3a" end
      if Sasite[sasitebangou][x]==20 then Sasite[sasitebangou][x]="2a" end
      if Sasite[sasitebangou][x]==21 then Sasite[sasitebangou][x]="1a" end

      if Sasite[sasitebangou][x]==24 then Sasite[sasitebangou][x]="9b" end
      if Sasite[sasitebangou][x]==25 then Sasite[sasitebangou][x]="8b" end
      if Sasite[sasitebangou][x]==26 then Sasite[sasitebangou][x]="7b" end
      if Sasite[sasitebangou][x]==27 then Sasite[sasitebangou][x]="6b" end
      if Sasite[sasitebangou][x]==28 then Sasite[sasitebangou][x]="5b" end
      if Sasite[sasitebangou][x]==29 then Sasite[sasitebangou][x]="4b" end
      if Sasite[sasitebangou][x]==30 then Sasite[sasitebangou][x]="3b" end
      if Sasite[sasitebangou][x]==31 then Sasite[sasitebangou][x]="2b" end
      if Sasite[sasitebangou][x]==32 then Sasite[sasitebangou][x]="1b" end
      
      if Sasite[sasitebangou][x]==35 then Sasite[sasitebangou][x]="9c" end
      if Sasite[sasitebangou][x]==36 then Sasite[sasitebangou][x]="8c" end
      if Sasite[sasitebangou][x]==37 then Sasite[sasitebangou][x]="7c" end
      if Sasite[sasitebangou][x]==38 then Sasite[sasitebangou][x]="6c" end
      if Sasite[sasitebangou][x]==39 then Sasite[sasitebangou][x]="5c" end
      if Sasite[sasitebangou][x]==40 then Sasite[sasitebangou][x]="4c" end
      if Sasite[sasitebangou][x]==41 then Sasite[sasitebangou][x]="3c" end
      if Sasite[sasitebangou][x]==42 then Sasite[sasitebangou][x]="2c" end
      if Sasite[sasitebangou][x]==43 then Sasite[sasitebangou][x]="1c" end
      
      if Sasite[sasitebangou][x]==46 then Sasite[sasitebangou][x]="9d" end
      if Sasite[sasitebangou][x]==47 then Sasite[sasitebangou][x]="8d" end
      if Sasite[sasitebangou][x]==48 then Sasite[sasitebangou][x]="7d" end
      if Sasite[sasitebangou][x]==49 then Sasite[sasitebangou][x]="6d" end
      if Sasite[sasitebangou][x]==50 then Sasite[sasitebangou][x]="5d" end
      if Sasite[sasitebangou][x]==51 then Sasite[sasitebangou][x]="4d" end
      if Sasite[sasitebangou][x]==52 then Sasite[sasitebangou][x]="3d" end
      if Sasite[sasitebangou][x]==53 then Sasite[sasitebangou][x]="2d" end
      if Sasite[sasitebangou][x]==54 then Sasite[sasitebangou][x]="1d" end
      
      if Sasite[sasitebangou][x]==57 then Sasite[sasitebangou][x]="9e" end
      if Sasite[sasitebangou][x]==58 then Sasite[sasitebangou][x]="8e" end
      if Sasite[sasitebangou][x]==59 then Sasite[sasitebangou][x]="7e" end
      if Sasite[sasitebangou][x]==60 then Sasite[sasitebangou][x]="6e" end
      if Sasite[sasitebangou][x]==61 then Sasite[sasitebangou][x]="5e" end
      if Sasite[sasitebangou][x]==62 then Sasite[sasitebangou][x]="4e" end
      if Sasite[sasitebangou][x]==63 then Sasite[sasitebangou][x]="3e" end
      if Sasite[sasitebangou][x]==64 then Sasite[sasitebangou][x]="2e" end
      if Sasite[sasitebangou][x]==65 then Sasite[sasitebangou][x]="1e" end
      
      if Sasite[sasitebangou][x]==68 then Sasite[sasitebangou][x]="9f" end
      if Sasite[sasitebangou][x]==69 then Sasite[sasitebangou][x]="8f" end
      if Sasite[sasitebangou][x]==70 then Sasite[sasitebangou][x]="7f" end
      if Sasite[sasitebangou][x]==71 then Sasite[sasitebangou][x]="6f" end
      if Sasite[sasitebangou][x]==72 then Sasite[sasitebangou][x]="5f" end
      if Sasite[sasitebangou][x]==73 then Sasite[sasitebangou][x]="4f" end
      if Sasite[sasitebangou][x]==74 then Sasite[sasitebangou][x]="3f" end
      if Sasite[sasitebangou][x]==75 then Sasite[sasitebangou][x]="2f" end
      if Sasite[sasitebangou][x]==76 then Sasite[sasitebangou][x]="1f" end

      if Sasite[sasitebangou][x]==79 then Sasite[sasitebangou][x]="9g" end
      if Sasite[sasitebangou][x]==80 then Sasite[sasitebangou][x]="8g" end
      if Sasite[sasitebangou][x]==81 then Sasite[sasitebangou][x]="7g" end
      if Sasite[sasitebangou][x]==82 then Sasite[sasitebangou][x]="6g" end
      if Sasite[sasitebangou][x]==83 then Sasite[sasitebangou][x]="5g" end
      if Sasite[sasitebangou][x]==84 then Sasite[sasitebangou][x]="4g" end
      if Sasite[sasitebangou][x]==85 then Sasite[sasitebangou][x]="3g" end
      if Sasite[sasitebangou][x]==86 then Sasite[sasitebangou][x]="2g" end
      if Sasite[sasitebangou][x]==87 then Sasite[sasitebangou][x]="1g" end

      if Sasite[sasitebangou][x]==90 then Sasite[sasitebangou][x]="9h" end
      if Sasite[sasitebangou][x]==91 then Sasite[sasitebangou][x]="8h" end
      if Sasite[sasitebangou][x]==92 then Sasite[sasitebangou][x]="7h" end
      if Sasite[sasitebangou][x]==93 then Sasite[sasitebangou][x]="6h" end
      if Sasite[sasitebangou][x]==94 then Sasite[sasitebangou][x]="5h" end
      if Sasite[sasitebangou][x]==95 then Sasite[sasitebangou][x]="4h" end
      if Sasite[sasitebangou][x]==96 then Sasite[sasitebangou][x]="3h" end
      if Sasite[sasitebangou][x]==97 then Sasite[sasitebangou][x]="2h" end
      if Sasite[sasitebangou][x]==98 then Sasite[sasitebangou][x]="1h" end

      if Sasite[sasitebangou][x]==101 then Sasite[sasitebangou][x]="9i" end
      if Sasite[sasitebangou][x]==102 then Sasite[sasitebangou][x]="8i" end
      if Sasite[sasitebangou][x]==103 then Sasite[sasitebangou][x]="7i" end
      if Sasite[sasitebangou][x]==104 then Sasite[sasitebangou][x]="6i" end
      if Sasite[sasitebangou][x]==105 then Sasite[sasitebangou][x]="5i" end
      if Sasite[sasitebangou][x]==106 then Sasite[sasitebangou][x]="4i" end
      if Sasite[sasitebangou][x]==107 then Sasite[sasitebangou][x]="3i" end
      if Sasite[sasitebangou][x]==108 then Sasite[sasitebangou][x]="2i" end
      if Sasite[sasitebangou][x]==109 then Sasite[sasitebangou][x]="1i" end
    end

      if Sasite[sasitebangou][5]==10 then
        Sasite[sasitebangou][5]="+"
      else
        Sasite[sasitebangou][5]=""
      end
      
      KomaHyouka()
      tensuu=sentetoku+gotetoku+sentemamoriten-gotemamoriten  --���v�_���Bmath.random(2000)-1000
      
      print("info string ���̋��"..sentetoku.."vs���̋��"..-gotetoku)
      print("info string ���̎�萔"..sentemamorikazu.."vs���̎�萔"..gotemamorikazu)
      print("info string ���̎��_"..sentemamoriten.."vs���̎��_"..gotemamoriten)
      
      if tuikagouhousyukazu>=1 then
--        print("info string �ǉ��w���萔"..tuikagouhousyukazu)
      end
      
      if Teban==1 then
        print("info nodes "..kouhosuu+tuikagouhousyukazu.." score cp "..tensuu..
          " pv "..Sasite[sasitebangou][1]..Sasite[sasitebangou][3]..Sasite[sasitebangou][5])
      else
        print("info nodes "..kouhosuu+tuikagouhousyukazu.." score cp "..-tensuu..
          " pv "..Sasite[sasitebangou][1]..Sasite[sasitebangou][3]..Sasite[sasitebangou][5]) --�X�R�A�𔽓]
      end
      
      print("bestmove "..Sasite[sasitebangou][1]..Sasite[sasitebangou][3]..Sasite[sasitebangou][5]) --bestmove N*9e  /Sasite
      
      --[[
sfen�̏������ł��܂����Binfo score�ŃX�R�A�\��
���āAhaitidainyu���ł��Ă��܂���ł����B
���ł��Ă�H�H�H20170601

���̎��́A���悢�捇�@��̐����ł��B
���̂��Ƃ́A
�E�����_���w��
�E���l�߃��[�`��
�E�]���֐�
      ]]--
      
    end
    
    if string.match(uketori, "go m", n) ~= nil then --�l�ߏ������l����
      print("go m�A��������")
    end
    
  end

end

--������𕪊�����֐�
function Bunkatu()
  
 --uketori = "position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d"
 --position startpos moves 2g2f 5a4b 2f2e ���
 --position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b P*2e
 --position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d

 BunkatuSuu=0
 BunkatuMoji={}
 --��������̕����B�p���������؂蕶���B
 for i in uketori:gmatch("[%a%d%p]+") do 
   BunkatuSuu=BunkatuSuu+1 --�󂯎�����R�}���h�𕪊�������
   BunkatuMoji[BunkatuSuu]=i --�󂯎�����R�}���h�𕪊����Ď��[
 end
  
end

--4��������Ֆʂɑ������֐�
function HaitiDainyu(mTeme)
  if BunkatuMoji[mTeme]=="startpos" then
    HaitiGenzai={unpack(HaitiStaPos)} --{�@}��Y�ꂸ��
  end
  --�� 11/21�����܂ŁB
  MaeIti=string.sub(BunkatuMoji[mTeme],1,2)
  --���������̍ŏI�ʒu���ȗ�����ƍŌ�܂ŁB
  AtoIti=string.sub(BunkatuMoji[mTeme],3,4) 
  --���萔mTeme��BunkatuMoji����A���������2�������L�^
  Naruka=string.sub(BunkatuMoji[mTeme],5,5)  
  --���萔mTeme��BunkatuMoji����A����i+�j�����L�^
  
  if BantiHeHenkan(MaeIti)>0 then
    MaeKoma=HaitiGenzai[BantiHeHenkan(MaeIti)]
    --�������O�̈ʒu�̋�̎�ނ��L�^
    HaitiGenzai[BantiHeHenkan(MaeIti)]=0 --�����O�̈ʒu��0�ɂ���
  elseif BantiHeHenkan(MaeIti)==0 then
    MaeKoma=0
  else
    return
  end
  
  ToruKoma=HaitiGenzai[BantiHeHenkan(AtoIti)]
  --��������̈ʒu�̋�i����j�̎�ނ��L�^
  --��2��������Ԓn�ԍ��֕ϊ�����֐�
  
  UgokuKoma=MaeKoma
  
  if MaeKoma==0 then --�����O�̋�̎�ނ�0�i��j�Ȃ�
    UgokuKoma=Utu(MaeIti)
    if mTeme%2==0 then --���Ȃ�
      UgokuKoma=UgokuKoma+100
      --��UgokuKoma�ɐ����Ӗ�����100�𑫂�
      HaitiGenzai[UgokuKoma+21]=HaitiGenzai[UgokuKoma+21]-1
      --��101�Ƃ̍���+21�B������̖��������炷
    elseif mTeme%2==1 then --���Ȃ�
      UgokuKoma=UgokuKoma+200
      --��UgokuKoma�Ɍ����Ӗ�����200�𑫂�
      HaitiGenzai[UgokuKoma-71]=HaitiGenzai[UgokuKoma-71]-1
      --��201�Ƃ̍���-71�B������̖��������炷
    end
  end
  
  if ToruKoma>0 and ToruKoma<200 then --��肪�������
    HaitiGenzai[Toru(ToruKoma)-71]=HaitiGenzai[Toru(ToruKoma)-71]+1
    --��201�Ƃ̍���-71�B��������A������̖����𑝂₷
  elseif ToruKoma>200 then
    HaitiGenzai[Toru(ToruKoma)+21]=HaitiGenzai[Toru(ToruKoma)+21]+1
    --��101�Ƃ̍���+21�B��������A������̖����𑝂₷
  end

  
  if Naruka=="+" then --���鏈��
    UgokuKoma=UgokuKoma+10
  end
  
  HaitiGenzai[BantiHeHenkan(AtoIti)]=UgokuKoma
end


--�łƂ��̋�̎�ނ̊֐�
--[[
���ł�̎��
�o�k�m�r�f�a�q
�����j����p��
�P�Q�R�S�T�U�V
--]]
function Utu(KomaSyurui)
  if KomaSyurui=="P*" then return 1 end
  if KomaSyurui=="L*" then return 2 end
  if KomaSyurui=="N*" then return 3 end
  if KomaSyurui=="S*" then return 4 end
  if KomaSyurui=="G*" then return 5 end
  if KomaSyurui=="B*" then return 6 end
  if KomaSyurui=="R*" then return 7
  else return 0 end
end

--����Ƃ����Ƃ��̋�̎�ޕϊ�������֐�
function Toru(KomaSyurui)
  if KomaSyurui==101 or KomaSyurui==111 then return 201 end
  if KomaSyurui==102 or KomaSyurui==112 then return 202 end
  if KomaSyurui==103 or KomaSyurui==113 then return 203 end
  if KomaSyurui==104 or KomaSyurui==114 then return 204 end
  if KomaSyurui==105 or KomaSyurui==115 then return 205 end
  if KomaSyurui==106 or KomaSyurui==116 then return 206 end
  if KomaSyurui==107 or KomaSyurui==117 then return 207 end
  if KomaSyurui==201 or KomaSyurui==211 then return 101 end
  if KomaSyurui==202 or KomaSyurui==212 then return 102 end
  if KomaSyurui==203 or KomaSyurui==213 then return 103 end
  if KomaSyurui==204 or KomaSyurui==214 then return 104 end
  if KomaSyurui==205 or KomaSyurui==215 then return 105 end
  if KomaSyurui==206 or KomaSyurui==216 then return 106 end
  if KomaSyurui==207 or KomaSyurui==217 then return 107
  else return 0 end
end

--2��������Ԓn�ԍ��֕ϊ�����֐�
function BantiHeHenkan(ItiMoji)
  if ItiMoji=="9a" then return 13 end
  if ItiMoji=="8a" then return 14 end
  if ItiMoji=="7a" then return 15 end
  if ItiMoji=="6a" then return 16 end
  if ItiMoji=="5a" then return 17 end
  if ItiMoji=="4a" then return 18 end
  if ItiMoji=="3a" then return 19 end
  if ItiMoji=="2a" then return 20 end
  if ItiMoji=="1a" then return 21 end
  if ItiMoji=="9b" then return 24 end
  if ItiMoji=="8b" then return 25 end
  if ItiMoji=="7b" then return 26 end
  if ItiMoji=="6b" then return 27 end
  if ItiMoji=="5b" then return 28 end
  if ItiMoji=="4b" then return 29 end
  if ItiMoji=="3b" then return 30 end
  if ItiMoji=="2b" then return 31 end
  if ItiMoji=="1b" then return 32 end
  if ItiMoji=="9c" then return 35 end
  if ItiMoji=="8c" then return 36 end
  if ItiMoji=="7c" then return 37 end
  if ItiMoji=="6c" then return 38 end
  if ItiMoji=="5c" then return 39 end
  if ItiMoji=="4c" then return 40 end
  if ItiMoji=="3c" then return 41 end
  if ItiMoji=="2c" then return 42 end
  if ItiMoji=="1c" then return 43 end
  if ItiMoji=="9d" then return 46 end
  if ItiMoji=="8d" then return 47 end
  if ItiMoji=="7d" then return 48 end
  if ItiMoji=="6d" then return 49 end
  if ItiMoji=="5d" then return 50 end
  if ItiMoji=="4d" then return 51 end
  if ItiMoji=="3d" then return 52 end
  if ItiMoji=="2d" then return 53 end
  if ItiMoji=="1d" then return 54 end
  if ItiMoji=="9e" then return 57 end
  if ItiMoji=="8e" then return 58 end
  if ItiMoji=="7e" then return 59 end
  if ItiMoji=="6e" then return 60 end
  if ItiMoji=="5e" then return 61 end
  if ItiMoji=="4e" then return 62 end
  if ItiMoji=="3e" then return 63 end
  if ItiMoji=="2e" then return 64 end
  if ItiMoji=="1e" then return 65 end
  if ItiMoji=="9f" then return 68 end
  if ItiMoji=="8f" then return 69 end
  if ItiMoji=="7f" then return 70 end
  if ItiMoji=="6f" then return 71 end
  if ItiMoji=="5f" then return 72 end
  if ItiMoji=="4f" then return 73 end
  if ItiMoji=="3f" then return 74 end
  if ItiMoji=="2f" then return 75 end
  if ItiMoji=="1f" then return 76 end
  if ItiMoji=="9g" then return 79 end
  if ItiMoji=="8g" then return 80 end
  if ItiMoji=="7g" then return 81 end
  if ItiMoji=="6g" then return 82 end
  if ItiMoji=="5g" then return 83 end
  if ItiMoji=="4g" then return 84 end
  if ItiMoji=="3g" then return 85 end
  if ItiMoji=="2g" then return 86 end
  if ItiMoji=="1g" then return 87 end
  if ItiMoji=="9h" then return 90 end
  if ItiMoji=="8h" then return 91 end
  if ItiMoji=="7h" then return 92 end
  if ItiMoji=="6h" then return 93 end
  if ItiMoji=="5h" then return 94 end
  if ItiMoji=="4h" then return 95 end
  if ItiMoji=="3h" then return 96 end
  if ItiMoji=="2h" then return 97 end
  if ItiMoji=="1h" then return 98 end
  if ItiMoji=="9i" then return 101 end
  if ItiMoji=="8i" then return 102 end
  if ItiMoji=="7i" then return 103 end
  if ItiMoji=="6i" then return 104 end
  if ItiMoji=="5i" then return 105 end
  if ItiMoji=="4i" then return 106 end
  if ItiMoji=="3i" then return 107 end
  if ItiMoji=="2i" then return 108 end
  if ItiMoji=="1i" then return 109 end

  if ItiMoji=="P*" then return 0 end
  if ItiMoji=="L*" then return 0 end
  if ItiMoji=="N*" then return 0 end
  if ItiMoji=="S*" then return 0 end
  if ItiMoji=="G*" then return 0 end
  if ItiMoji=="B*" then return 0 end
  if ItiMoji=="R*" then return 0

  else return -2 end
end

function Sfen()
  
  Bunkatu()
  SfenBun={}
  HaitiGenzai={unpack(HaitiKara)}
  
  
  --SfenBun[�i��]�́A�u 5+P1gk �v�ȂǁB
  SfenBun[1],SfenBun[2],SfenBun[3],SfenBun[4],SfenBun[5],SfenBun[6],SfenBun[7],SfenBun[8],SfenBun[9]=string.match( BunkatuMoji[3] , "(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.+)" )
  
  
  SfenSuuji=0
  for i=1,9 do
    SfenDanMoji={}
    j=1
    for n in SfenBun[i]:gmatch("[%w%p]") do
      SfenDanMoji[j]=n
      j=j+1
    end
   
    if i==1 then SfenSuuji=13 --�z�u�Ԓn13-21�̈�i��
    elseif i==2 then SfenSuuji=24
    elseif i==3 then SfenSuuji=35
    elseif i==4 then SfenSuuji=46
    elseif i==5 then SfenSuuji=57
    elseif i==6 then SfenSuuji=68
    elseif i==7 then SfenSuuji=79
    elseif i==8 then SfenSuuji=90
    elseif i==9 then SfenSuuji=101    --�z�u�Ԓn101-109�̋�i��
      else SfenSuuji=999 end  --�G���[�̂Ƃ�

    SfenNari=0
    for k=1, 18 do
      if     SfenDanMoji[k]=="p" then
        HaitiGenzai[SfenSuuji]=201+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="l" then
        HaitiGenzai[SfenSuuji]=202+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="n" then
        HaitiGenzai[SfenSuuji]=203+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="s" then
        HaitiGenzai[SfenSuuji]=204+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="g" then HaitiGenzai[SfenSuuji]=205
      elseif SfenDanMoji[k]=="b" then
        HaitiGenzai[SfenSuuji]=206+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="r" then
        HaitiGenzai[SfenSuuji]=207+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="k" then HaitiGenzai[SfenSuuji]=208
      elseif SfenDanMoji[k]=="P" then
        HaitiGenzai[SfenSuuji]=101+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="L" then
        HaitiGenzai[SfenSuuji]=102+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="N" then
        HaitiGenzai[SfenSuuji]=103+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="S" then
        HaitiGenzai[SfenSuuji]=104+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="G" then HaitiGenzai[SfenSuuji]=105
      elseif SfenDanMoji[k]=="B" then
        HaitiGenzai[SfenSuuji]=106+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="R" then
        HaitiGenzai[SfenSuuji]=107+SfenNari
        if SfenNari==10 then SfenNari=0 end
      elseif SfenDanMoji[k]=="K" then HaitiGenzai[SfenSuuji]=108
      elseif SfenDanMoji[k]=="+" then
        SfenNari=10
        SfenSuuji=SfenSuuji-1
      elseif SfenDanMoji[k]==nil then
      else
        SfenSuuji=SfenSuuji+SfenDanMoji[k]-1
      end
      SfenSuuji=SfenSuuji+1
    end
  
  end
  
  --�ȉ��A������̏���
  SfenMoti={}
  j=1
  for n in BunkatuMoji[5]:gmatch("[%w%p]") do
    SfenMoti[j]=n
    j=j+1
  end
  
  Maisuu=1
  for k=1, 18 do
    
    if     SfenMoti[k]=="P" then 
          HaitiGenzai[122]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="L" then 
          HaitiGenzai[123]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="N" then 
          HaitiGenzai[124]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="S" then 
          HaitiGenzai[125]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="G" then 
          HaitiGenzai[126]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="B" then 
          HaitiGenzai[127]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="R" then 
          HaitiGenzai[128]=Maisuu
          Maisuu=1
        
    elseif SfenMoti[k]=="p" then 
          HaitiGenzai[130]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="l" then 
          HaitiGenzai[131]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="n" then 
          HaitiGenzai[132]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="s" then 
          HaitiGenzai[133]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="g" then 
          HaitiGenzai[134]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="b" then 
          HaitiGenzai[135]=Maisuu
          Maisuu=1
    elseif SfenMoti[k]=="r" then 
          HaitiGenzai[136]=Maisuu
          Maisuu=1
        
    elseif SfenMoti[k]=="1" then Maisuu=11
    elseif (SfenMoti[k]==nil or SfenMoti[k]=="-") then
    else
          Maisuu=Maisuu+SfenMoti[k]-1
    end
    
  end
  
end

--���@��𐶐�����֐�(����y��1�̂Ƃ����A-1�̂Ƃ����) �@�Ղ萶���Ղ萶������300������A��B�������ρB
function Gouhousyu(GouhouTeban)
  -- Sasite[�w����̌�␔][1:���Ԓn�A2:���̋��A3:��Ԓn�A4:��̋��A5:����+10]
  --[1]��999�̎��͂����
  --[1]��200��-200�̎��͑ł�
  --Sasite={unpack(SasiteKara)} --�w����z��̋���۔ł��R�s�[
  --������ɁA�z��̍Ō�ɏI�[�����̂悤�Ȃ��́iSasite[x][1]=999�j������
  kouhosuu=0
  
  --���̎�
  for i=13, 109 do --�Ԓn13����109�܂ł𒲂ׂĂ���
    if GouhouTeban==1 then --���̎�
      if HaitiGenzai[i]==101 or HaitiGenzai[i]==103 or HaitiGenzai[i]==104 then  --���A�j�A��̂Ƃ�
        for j=1,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              if kouhoti>=13 and kouhoti<=43 then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A�j�A��̌J��Ԃ��I���
      end --���A�j�A��A�I���
      
      if HaitiGenzai[i]==105 or HaitiGenzai[i]==108 or (HaitiGenzai[i]>=111 and HaitiGenzai[i]<=114) then  --���A���A�����̂Ƃ�
        for j=1,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A���A�����̌J��Ԃ��I���
      end --���A���A�����I���
      
      yameru=0  --��߂�t���O������0
      if HaitiGenzai[i]==102 then  --���̂Ƃ�
        for j=1,8 do --���Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              if kouhoti>=13 and kouhoti<=43 then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���̌J��Ԃ��I���
      end --���A�I���

      yameru=0  --��߂�t���O������0
      if HaitiGenzai[i]==107 or HaitiGenzai[i]==117 or HaitiGenzai[i]==106 or HaitiGenzai[i]==116 then  --��A���A�p�A�n�̂Ƃ�
        for j=1,8 do --���������Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==107 or HaitiGenzai[i]==106) and ((kouhoti>=13 and kouhoti<=43) or (i<=13 and i>=43)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
        
        yameru=0  --��߂�t���O������0
        for j=9,16 do --���Ɍ�������9����16�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==107 or HaitiGenzai[i]==106) and ((kouhoti>=13 and kouhoti<=43) or (i<=13 and i>=43)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
  
        yameru=0  --��߂�t���O������0
        for j=17,24 do --���Ɍ�������17����24�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==107 or HaitiGenzai[i]==106) and ((kouhoti>=13 and kouhoti<=43) or (i<=13 and i>=43)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
  
        yameru=0  --��߂�t���O������0
        for j=25,32 do --���Ɍ�������25����32�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==107 or HaitiGenzai[i]==106) and ((kouhoti>=13 and kouhoti<=43) or (i<=13 and i>=43)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
      end --��A�p�̏I���
      
      if HaitiGenzai[i]==117 or HaitiGenzai[i]==116 then  --�����n�̂Ƃ��̎c��
        for j=33,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=201 and HaitiGenzai[kouhoti]<=217)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A�n�̎c��̌J��Ԃ��I���
      end --���A�n�̏I���

    end --���̍�����A�I���
  end --for�I���
      
   --���̎������łƂ�
if GouhouTeban==1 then --���̎�
      if HaitiGenzai[101+21]>=1 then --���̂Ƃ�
        hunokazu=0
        HunoIti={}  --HunoIti[�Ֆʂ̕��̔ԍ�]=���̔Ԓn
        for i=1,9 do
          HunoIti[i]=-999 --HunoIti[�Ֆʂ̕��̔ԍ�]=�Ԓn
        end
        for i=13,109 do --�Ֆʂɐ��̕��̈ʒu�𒲂ׂ�
          if HaitiGenzai[i]==101 then
            hunokazu=hunokazu+1
            HunoIti[hunokazu]=i
          end
        end
        HuUteru={}
        for i=-200,200 do
          HuUteru[i]=1 --HuUteru[�Ԓn13-109]=1�@����ł���OK
        end
        if hunokazu>=1 then
          for i=1,9 do --i�͔Ֆʂ̕��̐�
            for j=0,10 do --j�́A���Ă̐�
              HuUteru[HunoIti[i]+11*j]=0
              HuUteru[HunoIti[i]-11*j]=0
            end
          end
        end
        
        for i=24,109 do  --2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
            if HuUteru[i]==1 and HaitiGenzai[i]==0 then --HuUteru[�Ԓn]��1�Ŕz�u�E���݂�0�Ȃ�A����łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=200 --���Ԓn�́A���̔ԊO�i200�j
              Sasite[kouhosuu][2]=101  --���̋��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
      end  --����ł̂͏I���

      if HaitiGenzai[102+21]>=1 then --���̂Ƃ�
        for i=24,109 do  --2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=200 --���Ԓn�́A���̔ԊO�i200�j
              Sasite[kouhosuu][2]=102  --���̋��E��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
        end
      end  --����ł̂͏I���

      if HaitiGenzai[103+21]>=1 then --�j�̂Ƃ�
        for i=35,109 do  --3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=200 --���Ԓn�́A���̔ԊO�i200�j
              Sasite[kouhosuu][2]=103  --���̋��E�j
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
        end
      end  --�j��ł̂͏I���

      for x=0,3 do
        if HaitiGenzai[104+21+x]>=1 then --��A���A�p�A��̂Ƃ�
          for i=13,109 do  --3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=200 --���Ԓn�́A���̔ԊO�i200�j
              Sasite[kouhosuu][2]=104+x  --���̋��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end
      end  --��A���A�p�A���ł̂͏I���
   end --���̎������ł̏I���

  --���̎�
  for i=13, 109 do --�Ԓn13-109�𒲂ׂĂ���
    if GouhouTeban==-1 then --���̎�
      if HaitiGenzai[i]==201 or HaitiGenzai[i]==203 or HaitiGenzai[i]==204 then  --���A�j�A��̂Ƃ�
        for j=1,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              if kouhoti>=79 and kouhoti<=109 then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A�j�A��̌J��Ԃ��I���
      end --���A�j�A��A�I���
      
      if HaitiGenzai[i]==205 or HaitiGenzai[i]==208 or (HaitiGenzai[i]>=211 and HaitiGenzai[i]<=214) then  --���A���A�����̂Ƃ�
        for j=1,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A���A�����̌J��Ԃ��I���
      end --���A���A�����I���
      
      yameru=0  --��߂�t���O������0
      if HaitiGenzai[i]==202 then  --���̂Ƃ�
        for j=1,8 do --���Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              if kouhoti>=79 and kouhoti<=109 then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���̌J��Ԃ��I���
      end --���A�I���

      yameru=0  --��߂�t���O������0
      if HaitiGenzai[i]==207 or HaitiGenzai[i]==217 or HaitiGenzai[i]==206 or HaitiGenzai[i]==216 then  --��A���A�p�A�n�̂Ƃ�
        for j=1,8 do --���������Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==207 or HaitiGenzai[i]==206) and ((kouhoti>=79 and kouhoti<=109) or (i<=79 and i>=109)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
        
        yameru=0  --��߂�t���O������0
        for j=9,16 do --���Ɍ�������9����16�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==207 or HaitiGenzai[i]==206) and ((kouhoti>=79 and kouhoti<=109) or (i<=79 and i>=109)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
  
        yameru=0  --��߂�t���O������0
        for j=17,24 do --���Ɍ�������17����24�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==207 or HaitiGenzai[i]==206) and ((kouhoti>=79 and kouhoti<=109) or (i<=79 and i>=109)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
  
        yameru=0  --��߂�t���O������0
        for j=25,32 do --���Ɍ�������25����32�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
          if ugokeru[HaitiGenzai[i]][j] ~=0 and yameru==0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if HaitiGenzai[kouhoti]~=0 then  --�����Ƃ��A��߂�t���O�𗧂Ă�
              yameru=1
            end
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              --�򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
              if (HaitiGenzai[i]==207 or HaitiGenzai[i]==206) and ((kouhoti>=79 and kouhoti<=109) or (i<=79 and i>=109)) then
                Sasite[kouhosuu][5]=10  --����
              else
                Sasite[kouhosuu][5]=0  --���炸
              end
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --��A���́��̌J��Ԃ��I���
      end --��A�p�̏I���
      
      if HaitiGenzai[i]==217 or HaitiGenzai[i]==216 then  --�����n�̂Ƃ��̎c��
        for j=33,36 do
          if ugokeru[HaitiGenzai[i]][j] ~=0 then --ugokeru[���܂̎��][j]��0�ȊO�œ�����
            kouhoti=i+ugokeru[HaitiGenzai[i]][j] --kouhoti ���n
            if kouhoti>=13 and kouhoti<=109 and (HaitiGenzai[kouhoti]==0 or (HaitiGenzai[kouhoti]>=101 and HaitiGenzai[kouhoti]<=117)) then
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=i --���Ԓn
              Sasite[kouhosuu][2]=HaitiGenzai[i]  --���̋��
              Sasite[kouhosuu][3]=kouhoti  --��Ԓn
              Sasite[kouhosuu][4]=HaitiGenzai[kouhoti]  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end  --���A�n�̎c��̌J��Ԃ��I���
      end --���A�n�̏I���

    end --���̍�����A�I���
  end --for�I���
      
   --���̎������łƂ�
  if GouhouTeban==-1 then --���̎�      
      if HaitiGenzai[201-71]>=1 then --���̂Ƃ�
        hunokazu=0
        HunoIti={}  --HunoIti[�Ֆʂ̕��̔ԍ�]=���̔Ԓn
        for i=1,9 do
          HunoIti[i]=-999 --HunoIti[�Ֆʂ̕��̔ԍ�]=�Ԓn
        end
        for i=13,109 do --�Ֆʂɐ��̕��̈ʒu�𒲂ׂ�
          if HaitiGenzai[i]==201 then
            hunokazu=hunokazu+1
            HunoIti[hunokazu]=i
          end
        end
        HuUteru={}
        for i=-200,200 do
          HuUteru[i]=1 --HuUteru[�Ԓn13-109]=1�@����ł���OK
        end
        if hunokazu>=1 then
          for i=1,9 do --i�͔Ֆʂ̕��̐�
            for j=0,10 do --j�́A���Ă̐�
              HuUteru[HunoIti[i]+11*j]=0
              HuUteru[HunoIti[i]-11*j]=0
            end
          end
        end
        
        for i=13,98 do  --2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
            if HuUteru[i]==1 and HaitiGenzai[i]==0 then --HuUteru[�Ԓn]��1�Ŕz�u�E���݂�0�Ȃ�A����łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=-200 --���Ԓn�́A���̔ԊO�i-200�j
              Sasite[kouhosuu][2]=201  --���̋��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
      end  --����ł̂͏I���

      if HaitiGenzai[202-71]>=1 then --���̂Ƃ�
        for i=13,98 do  --2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=-200 --���Ԓn�́A���̔ԊO�i-200�j
              Sasite[kouhosuu][2]=202  --���̋��E��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
        end
      end  --����ł̂͏I���

      if HaitiGenzai[203-71]>=1 then --�j�̂Ƃ�
        for i=13,87 do  --3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=-200 --���Ԓn�́A���̔ԊO�i-200�j
              Sasite[kouhosuu][2]=203  --���̋��E�j
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
        end
      end  --�j��ł̂͏I���

      for x=0,3 do
        if HaitiGenzai[204-71+x]>=1 then --��A���A�p�A��̂Ƃ�
          for i=13,109 do  --���ׂĂ̔Ԓn�𒲂ׂ�
            if HaitiGenzai[i]==0 then --�z�u�E���݂�0�Ȃ�A�łĂ�
              kouhosuu=kouhosuu+1
              Sasite[kouhosuu][1]=-200 --���Ԓn�́A���̔ԊO�i-200�j
              Sasite[kouhosuu][2]=204+x  --���̋��
              Sasite[kouhosuu][3]=i  --��Ԓn
              Sasite[kouhosuu][4]=0  --��̋��
              Sasite[kouhosuu][5]=0  --���炸
              -- print(kouhosuu..":"..Sasite[kouhosuu][1].." "..Sasite[kouhosuu][2].." "..Sasite[kouhosuu][3].." "..Sasite[kouhosuu][4].." "..Sasite[kouhosuu][5])
            end
          end
        end
      end  --��A���A�p�A���ł̂͏I���
   end--���̎������ł̏I���
   
   gouhousyukazu=kouhosuu
   
   Sasite[gouhousyukazu+1][1]=999 --�w����z��̍��@�萔+1�ɁA�z��I�����999������B
--   print("���@�萔"..kouhosuu.." / �w����z��̍Ō�̂���-1����+1�܂ł�[1]"..Sasite[gouhousyukazu][1].."/"..Sasite[gouhousyukazu+1][1])
--  print("KouhoSuu "..kouhosuu)
end

function KomaHyouka() --��̑����]��
  sentetoku=0
  gotetoku=0
  
  for i=13,109 do
    if HaitiGenzai[i]==101 then sentetoku=sentetoku+komakati[1] end
    if HaitiGenzai[i]==102 then sentetoku=sentetoku+komakati[2] end
    if HaitiGenzai[i]==103 then sentetoku=sentetoku+komakati[3] end
    if HaitiGenzai[i]==104 then sentetoku=sentetoku+komakati[4] end
    if HaitiGenzai[i]==105 then sentetoku=sentetoku+komakati[5] end
    if HaitiGenzai[i]==106 then sentetoku=sentetoku+komakati[6] end
    if HaitiGenzai[i]==107 then sentetoku=sentetoku+komakati[7] end
    if HaitiGenzai[i]==108 then sentetoku=sentetoku+komakati[8] end
    if HaitiGenzai[i]==111 then sentetoku=sentetoku+komakati[9] end
    if HaitiGenzai[i]==112 then sentetoku=sentetoku+komakati[9] end
    if HaitiGenzai[i]==113 then sentetoku=sentetoku+komakati[9] end
    if HaitiGenzai[i]==114 then sentetoku=sentetoku+komakati[9] end
    if HaitiGenzai[i]==116 then sentetoku=sentetoku+komakati[10] end
    if HaitiGenzai[i]==117 then sentetoku=sentetoku+komakati[11] end
  
    if HaitiGenzai[i]==201 then gotetoku=gotetoku+komakati[12] end
    if HaitiGenzai[i]==202 then gotetoku=gotetoku+komakati[13] end
    if HaitiGenzai[i]==203 then gotetoku=gotetoku+komakati[14] end
    if HaitiGenzai[i]==204 then gotetoku=gotetoku+komakati[15] end
    if HaitiGenzai[i]==205 then gotetoku=gotetoku+komakati[16] end
    if HaitiGenzai[i]==206 then gotetoku=gotetoku+komakati[17] end
    if HaitiGenzai[i]==207 then gotetoku=gotetoku+komakati[18] end
    if HaitiGenzai[i]==208 then gotetoku=gotetoku+komakati[19] end
    if HaitiGenzai[i]==211 then gotetoku=gotetoku+komakati[20] end
    if HaitiGenzai[i]==212 then gotetoku=gotetoku+komakati[20] end
    if HaitiGenzai[i]==213 then gotetoku=gotetoku+komakati[20] end
    if HaitiGenzai[i]==214 then gotetoku=gotetoku+komakati[20] end
    if HaitiGenzai[i]==216 then gotetoku=gotetoku+komakati[21] end
    if HaitiGenzai[i]==217 then gotetoku=gotetoku+komakati[22] end
  end
  
  for i=122,128 do
    if HaitiGenzai[i]>=1 then sentetoku=sentetoku+motikomakati[i-121]*HaitiGenzai[i] end
  end

  for i=129,135 do
    if HaitiGenzai[i]>=1 then gotetoku=gotetoku+motikomakati[i-121]*HaitiGenzai[i] end
  end
--��̑����]�������

--�ʎ���̕]�� 1������+200
  gyokumamori=0
  sentemamorikazu=0
  gotemamorikazu=0
  
  for i=13,109 do --���̋ʒT��
    if HaitiGenzai[i]==108 then sentegyokuiti=i end
    if HaitiGenzai[i]==208 then gotegyokuiti=i end
  end
    
  --�ʎ���̋���T��
    if HaitiGenzai[sentegyokuiti+10]==104 or HaitiGenzai[sentegyokuiti+10]==105 or HaitiGenzai[sentegyokuiti+10]==116 or 
    (HaitiGenzai[sentegyokuiti+10]>=111 and HaitiGenzai[sentegyokuiti+10]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti+11]==104 or HaitiGenzai[sentegyokuiti+11]==105 or HaitiGenzai[sentegyokuiti+11]==116 or 
    (HaitiGenzai[sentegyokuiti+11]>=111 and HaitiGenzai[sentegyokuiti+11]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti+12]==104 or HaitiGenzai[sentegyokuiti+12]==105 or HaitiGenzai[sentegyokuiti+12]==116 or 
    (HaitiGenzai[sentegyokuiti+12]>=111 and HaitiGenzai[sentegyokuiti+12]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti+1]==104 or HaitiGenzai[sentegyokuiti+1]==105 or HaitiGenzai[sentegyokuiti+1]==116 or 
    (HaitiGenzai[sentegyokuiti+1]>=111 and HaitiGenzai[sentegyokuiti+1]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti-10]==104 or HaitiGenzai[sentegyokuiti-10]==105 or HaitiGenzai[sentegyokuiti-10]==116 or 
    (HaitiGenzai[sentegyokuiti-10]>=111 and HaitiGenzai[sentegyokuiti-10]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti-11]==104 or HaitiGenzai[sentegyokuiti-11]==105 or HaitiGenzai[sentegyokuiti-11]==116 or 
    (HaitiGenzai[sentegyokuiti-11]>=111 and HaitiGenzai[sentegyokuiti-11]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti-12]==104 or HaitiGenzai[sentegyokuiti-12]==105 or HaitiGenzai[sentegyokuiti-12]==116 or 
    (HaitiGenzai[sentegyokuiti-12]>=111 and HaitiGenzai[sentegyokuiti-12]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
    if HaitiGenzai[sentegyokuiti-1]==104 or HaitiGenzai[sentegyokuiti-1]==105 or HaitiGenzai[sentegyokuiti-1]==116 or 
    (HaitiGenzai[sentegyokuiti-12]>=111 and HaitiGenzai[sentegyokuiti-12]<=114) then
      sentemamorikazu=sentemamorikazu+1
    end
  
    if HaitiGenzai[gotegyokuiti+10]==204 or HaitiGenzai[gotegyokuiti+10]==205 or HaitiGenzai[gotegyokuiti+10]==216 or 
    (HaitiGenzai[gotegyokuiti+10]>=211 and HaitiGenzai[gotegyokuiti+10]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti+11]==204 or HaitiGenzai[gotegyokuiti+11]==205 or HaitiGenzai[gotegyokuiti+11]==216 or 
    (HaitiGenzai[gotegyokuiti+11]>=211 and HaitiGenzai[gotegyokuiti+11]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti+12]==204 or HaitiGenzai[gotegyokuiti+12]==205 or HaitiGenzai[gotegyokuiti+12]==216 or 
    (HaitiGenzai[gotegyokuiti+12]>=211 and HaitiGenzai[gotegyokuiti+12]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti+1]==204 or HaitiGenzai[gotegyokuiti+1]==205 or HaitiGenzai[gotegyokuiti+1]==216 or 
    (HaitiGenzai[gotegyokuiti+1]>=211 and HaitiGenzai[gotegyokuiti+1]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti-10]==204 or HaitiGenzai[gotegyokuiti-10]==205 or HaitiGenzai[gotegyokuiti-10]==216 or 
    (HaitiGenzai[gotegyokuiti-10]>=211 and HaitiGenzai[gotegyokuiti-10]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti-11]==204 or HaitiGenzai[gotegyokuiti-11]==205 or HaitiGenzai[gotegyokuiti-11]==216 or 
    (HaitiGenzai[gotegyokuiti-11]>=211 and HaitiGenzai[gotegyokuiti-11]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti-12]==204 or HaitiGenzai[gotegyokuiti-12]==205 or HaitiGenzai[gotegyokuiti-12]==216 or 
    (HaitiGenzai[gotegyokuiti-12]>=211 and HaitiGenzai[gotegyokuiti-12]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
    if HaitiGenzai[gotegyokuiti-1]==204 or HaitiGenzai[gotegyokuiti-1]==205 or HaitiGenzai[gotegyokuiti-1]==216 or 
    (HaitiGenzai[gotegyokuiti-12]>=211 and HaitiGenzai[gotegyokuiti-12]<=214) then
      gotemamorikazu=gotemamorikazu+1
    end
  
  if sentemamorikazu<=3 then sentemamoriten=sentemamorikazu*50 else sentemamoriten=3*50 end
  if gotemamorikazu<=3 then gotemamoriten=gotemamorikazu*50 else gotemamoriten=3*50 end
    
--[[
  for i=13,109 do --�ʎ���̓������T���B����̗������l�����邱�Ƃ��������B
    if HaitiGenzai[i]==108 then sentegyokuiti=i end
    if HaitiGenzai[i]==208 then gotegyokuiti=i end
  end
--]]
--�ʎ���̕]�������

--[[
function YomiHyouka()
  for x=1,600 do
    HaitiYomi[x]={unpack(HaitiGenzai)}
  end
  
  for i=1,kouhosuu do
    HaitiYomi[i][ Sasite[i][1] ]
  end
--]]

end

--�w���萶���Ղ�̕\���i���@��Ȃǁj
function HyojiMaturi()
  Gouhousyu(Teban)
  print("����͂̍��@��i[�w����ԍ�]�����O�ʒu13109�A�����O�̋�A������̈ʒu�A������̋�A����+10�j")
  for i=1,600 do
    if Sasite[i][1]==999 then break end
    io.write("["..i.."]"..Sasite[i][1].."/"..Sasite[i][2].."/"..Sasite[i][3].."/"..Sasite[i][4].."/"..Sasite[i][5].." ")
  end
  print""
  print"������Ƒ҂��Ă�-�I��蕶����"
  
  --���Ԍv���J�n
  kurikaesisuu=10000
  
  kaisijikoku = os.clock()
  
  for i=1,kurikaesisuu do
    Gouhousyu(Teban)
  end
  
  syorijikan = os.clock() - kaisijikoku
  print("��������(s):"..syorijikan)
  print("�J��Ԃ���:"..kurikaesisuu)
  print("�b��(nps):"..math.floor(kurikaesisuu/syorijikan+0.5)) --�������l�̌ܓ�
  
  --���Ԍv���I��
    
end

--�ǂފ֐�
function Yomu(bangou) --���ԍ�
  HaitiYomi={unpack(HaitiGenzai)} --�z�u�ǂ�
  --�e�[�u�����R�s�[����Ƃ�unpack���g��Ȃ��ƘA������B{�@}��Y�ꂸ�ɁB
  if Sasite[bangou][1] ~= 999 then
    if Sasite[bangou][1] ~= 200 or Sasite[bangou][1] ~= -200 then --�ł��Ȃ��Ƃ�
      HaitiYomi[ Sasite[bangou][1] ] = 0 --���Ԓn�ɂ͋�ł���0����
      HaitiYomi[ Sasite[bangou][3] ] = Sasite[bangou][2] --��Ԓn�ɂ͌��Ԓn�̋�����
      if Sasite[bangou][5]==10 then --���鏈��
        HaitiYomi[ Sasite[bangou][3] ] = HaitiYomi[ Sasite[bangou][3] ] +10
      end
      if Sasite[bangou][4]~=0 then --����Ƃ�Ƃ�
        if Sasite[bangou][4]<=200 then --���̋���Ƃ�Ƃ�
          HaitiYomi[ Sasite[bangou][4]+90-71 ] = HaitiYomi[ Sasite[bangou][4]+90-71 ]+1
        end
        if Sasite[bangou][4]>=200 then --���̋���Ƃ�Ƃ�
          HaitiYomi[ Sasite[bangou][4]-110+21 ] = HaitiYomi[ Sasite[bangou][4]-110+21 ]+1
        end
      end
    end
  end
  
end


function main()
end

--��������
TourokuMati() --USI�G���W���o�^
BanmenSyokika() --�Ֆʂ̏�����
StaPosHaiti() --HaitiGenzai��StartPos�z�u�ɂ���
UgokeruTe() --����������������֐�
NyuryokuMati() --����������̃R�}���h�҂��̊֐�

print("end")
