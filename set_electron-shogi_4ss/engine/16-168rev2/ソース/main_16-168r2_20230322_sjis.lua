-- 170515 wcsc27 �C���� �N�W�����������B�]���l��pv���悪������ƕ\�������悤�ɒ����ł����B
-- 170524 ���@�萶���i���E����܂ށj�̏C���B�w���萶���Ղ�̕\���B
-- 170524 �w���萶�����x�A���@�萶���֐��Ɏw����z��̐��������Ă����Ƃ��A
-- �@�@�@�@�@�@�C���^�v�����^��500nps�Bluvi��1300nps�B
-- 170524 �w���萶�����x�A���@�萶���֐�����w����z��̐������o�����Ƃ��A
-- �@�@�@�@�@�@�C���^�v�����^��3000nps�Bluvi��7500nps�B
-- 170524 �w���萶�����x�A�w����z��̍Ō�ɏI���̐���999����ꂽ�Ƃ��A
-- �@�@�@�@�@�@�C���^�v�����^��3300nps�Bluvi��8000nps�B
-- ������u���ƁA������̂ŁA��������悤�ɂ���K�v����B��0601�ρB
-- 170529 �z�u�̎�����ɁA����ǉ������̂ŁA�v������0530�ρB
-- 170601 ���܂Ɍ����s���ŗ�����H
-- 190503 �C���[�K�����[�u���ł�~�X���C��
-- 20201121 3���ǂ݃~�j�}�b�N�X�@�𓋍ڒ��B��2���܂łɕύX�B20211201�B
-- 20201121 b={unpack(a)}�̂悤��1���e�[�u����
--  �󂢃R�s�[���g���Ē��g�𐮂�����
-- 20230322 sfen�ł̋������C���BElectronShogi�p��UTF8�ł��p�ӁB
--  �@�@�@�@Intel Core i7-10750H�Aluvi��5900nps�B
function hajime() end

-- �O���[�o���ϐ�
-- �z���Lua�ł́u�e�[�u���v�Ɋ܂�
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

HaitiKara = {
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1,
    -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0,
    0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0,
    0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
}
-- ����,��,�j,��,��,�p,��,��

HaitiGenzai = {} -- ���݂̔Ֆʂ̔z�u�e�[�u���B
HaitiYomi = {} -- 1���̓ǂ݂̔Ֆʂ̔z�u�e�[�u���B
HaitiYomi2 = {} -- 2���̓ǂ݂̔Ֆʂ̔z�u�e�[�u���B
HaitiItiji = {} -- ���݂̔Ֆʂ��ꎞ�ێ�����z�u�e�[�u���B
-- startpos�Ֆʂ̏����z�u�̃e�[�u���B
HaitiStaPos = {
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 202, 203, 204, 205, 208,
    205, 204, 203, 202, -1, -1, 0, 207, 0, 0, 0, 0, 0, 206, 0, -1, -1, 201, 201,
    201, 201, 201, 201, 201, 201, 201, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1,
    -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1,
    101, 101, 101, 101, 101, 101, 101, 101, 101, -1, -1, 0, 106, 0, 0, 0, 0, 0,
    107, 0, -1, -1, 102, 103, 104, 105, 108, 105, 104, 103, 102, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0
}

gouhousyukazu = 0

HaitiHyouji = {} -- �ǖʕ\������Ƃ��p�̕�����̔z��

-- Sasite[�w����̌�␔][1:���Ԓn�A2:���̋��A3:��Ԓn�A4:��̋��A5:����+10]
-- 1:999�Ȃ�w������͏I���B200�Ȃ���őłA-200�Ȃ���őłB
Sasite = {} -- �w���������z��𐶐�
SasiteItiji = {} -- �ꎞ�I�Ɏw���������z��𐶐�
SasiteGouhousyu = {} -- Gouhousyu�֐��p�̎w���������z��𐶐�
SasiteYomi = {} -- ��ǂݗp�̎w���������z��𐶐�
for i = 1, 600 do
    -- Sasite�n�̔z��̍s�̍쐬
    Sasite[i] = {}
    SasiteItiji[i] = {}
    SasiteGouhousyu[i] = {}
    SasiteYomi[i] = {}
    for j = 1, 5 do
        Sasite[i][j] = 0
        SasiteItiji[i][j] = 0
        SasiteGouhousyu[i][j] = 0
        SasiteYomi[i][j] = 0
    end
end

motikomakati = {
    125, 225, 325, 525, 625, 825, 925, -125, -225, -325, -525, -625, -825, -925
} -- ������̉��l
-- motikomakati={150,250,350,550,650,850,950, -150,-250,-350,-550,-650,-850,-950}  --������̉��l
komakati = {
    75, 175, 275, 475, 575, 775, 875, 100000, 575, 1175, 1275, -75, -175, -275,
    -475, -575, -775, -875, -100000, -575, -1175, -1275
} -- �Տ�̋�̉��l
-- komakati =   {100,200,300,500,600,800,900,10000,600,1200,1300, -100,-200,-300,-500,-600,-800,-900,-10000,-600,-1200,-1300} --�Տ�̋�̉��l
--      ���  1���A2���A3�j�A4��A5���A6�p�A7��A8��(1��)�A9�����A10�n�A11��
--      ���  12���A13���A14�j�A15��A16���A17�p�A18��A19��(1��)�A20�����A21�n�A22��
-- ���1���������A������1������遁���1������+200

sentetoku = 0
gotetoku = 0
sentemamorikazu = 0
gotemamorikazu = 0
sentemamoriten = 0
gotemamoriten = 0
saigonoiti = 0

-- �����܂ŃO���[�o���ϐ�

-- Sasite��\������֐�
-- ADD 2020-11-21
function print_sasite(Sasite)
    -- Sasite��\������
    print("�w����", "��␔:", kouhosuu)
    for i = 1, 600 do
        if Sasite[i][1] == 999 then break end
        print(i .. ":", Sasite[i][1], Sasite[i][2], Sasite[i][3], Sasite[i][4],
              Sasite[i][5])
    end
    print("")
end

-- ����������15����3������5�ɕ������A�e������𐔎�������֐��B
-- �߂�l�́A�e�[�u���B
function SpritNum15(word)
    sprit_num = {}
    if #word <= 15 then
        for i = 1, 5 do
            sprit_num[i] = tonumber(string.sub(word, 1 + (i - 1) * 3, i * 3))
        end
    else
        for i = 1, 5 do
            if i == 1 then
                sprit_num[i] = tonumber(string.sub(word, 1, 4))
            else
                sprit_num[i] = tonumber(string.sub(word, 2 + (i - 1) * 3,
                                                   i * 3 + 1))
            end
        end
    end

    return sprit_num
end

-- ����������15���������ϊ��̊֐�
-- �����̗�u018105019206010�v
-- ���w����̌����A�e�v�f3������1�̕�����i�����j�ɂ��Ċi�[���Ă���B
-- ��j�@18�@105�@19�@206�@0
-- �@���@1�F�����O�̈ʒu�A2�F��̎�ށA3�F������̈ʒu�A4�F������ɂ��錻�݂̋�̎�ށA5�F����10
-- �߂�l�̗�u4a3a+�v
-- ����2��������������̈ʒu�A����2��������������̈ʒu�A5�����ڂ�+�͐���
function Num15CharConvert(num15)
    bunkatuNum = SpritNum15(num15)
    if bunkatuNum[1] == 200 then
        if bunkatuNum[2] == 101 then bunkatuNum[1] = "P*" end
        if bunkatuNum[2] == 102 then bunkatuNum[1] = "L*" end
        if bunkatuNum[2] == 103 then bunkatuNum[1] = "N*" end
        if bunkatuNum[2] == 104 then bunkatuNum[1] = "S*" end
        if bunkatuNum[2] == 105 then bunkatuNum[1] = "G*" end
        if bunkatuNum[2] == 106 then bunkatuNum[1] = "B*" end
        if bunkatuNum[2] == 107 then bunkatuNum[1] = "R*" end
    end
    if bunkatuNum[1] == -200 then
        if bunkatuNum[2] == 201 then bunkatuNum[1] = "P*" end
        if bunkatuNum[2] == 202 then bunkatuNum[1] = "L*" end
        if bunkatuNum[2] == 203 then bunkatuNum[1] = "N*" end
        if bunkatuNum[2] == 204 then bunkatuNum[1] = "S*" end
        if bunkatuNum[2] == 205 then bunkatuNum[1] = "G*" end
        if bunkatuNum[2] == 206 then bunkatuNum[1] = "B*" end
        if bunkatuNum[2] == 207 then bunkatuNum[1] = "R*" end
    end

    for x = 1, 3, 2 do
        if bunkatuNum[x] == 13 then bunkatuNum[x] = "9a" end
        if bunkatuNum[x] == 14 then bunkatuNum[x] = "8a" end
        if bunkatuNum[x] == 15 then bunkatuNum[x] = "7a" end
        if bunkatuNum[x] == 16 then bunkatuNum[x] = "6a" end
        if bunkatuNum[x] == 17 then bunkatuNum[x] = "5a" end
        if bunkatuNum[x] == 18 then bunkatuNum[x] = "4a" end
        if bunkatuNum[x] == 19 then bunkatuNum[x] = "3a" end
        if bunkatuNum[x] == 20 then bunkatuNum[x] = "2a" end
        if bunkatuNum[x] == 21 then bunkatuNum[x] = "1a" end

        if bunkatuNum[x] == 24 then bunkatuNum[x] = "9b" end
        if bunkatuNum[x] == 25 then bunkatuNum[x] = "8b" end
        if bunkatuNum[x] == 26 then bunkatuNum[x] = "7b" end
        if bunkatuNum[x] == 27 then bunkatuNum[x] = "6b" end
        if bunkatuNum[x] == 28 then bunkatuNum[x] = "5b" end
        if bunkatuNum[x] == 29 then bunkatuNum[x] = "4b" end
        if bunkatuNum[x] == 30 then bunkatuNum[x] = "3b" end
        if bunkatuNum[x] == 31 then bunkatuNum[x] = "2b" end
        if bunkatuNum[x] == 32 then bunkatuNum[x] = "1b" end

        if bunkatuNum[x] == 35 then bunkatuNum[x] = "9c" end
        if bunkatuNum[x] == 36 then bunkatuNum[x] = "8c" end
        if bunkatuNum[x] == 37 then bunkatuNum[x] = "7c" end
        if bunkatuNum[x] == 38 then bunkatuNum[x] = "6c" end
        if bunkatuNum[x] == 39 then bunkatuNum[x] = "5c" end
        if bunkatuNum[x] == 40 then bunkatuNum[x] = "4c" end
        if bunkatuNum[x] == 41 then bunkatuNum[x] = "3c" end
        if bunkatuNum[x] == 42 then bunkatuNum[x] = "2c" end
        if bunkatuNum[x] == 43 then bunkatuNum[x] = "1c" end

        if bunkatuNum[x] == 46 then bunkatuNum[x] = "9d" end
        if bunkatuNum[x] == 47 then bunkatuNum[x] = "8d" end
        if bunkatuNum[x] == 48 then bunkatuNum[x] = "7d" end
        if bunkatuNum[x] == 49 then bunkatuNum[x] = "6d" end
        if bunkatuNum[x] == 50 then bunkatuNum[x] = "5d" end
        if bunkatuNum[x] == 51 then bunkatuNum[x] = "4d" end
        if bunkatuNum[x] == 52 then bunkatuNum[x] = "3d" end
        if bunkatuNum[x] == 53 then bunkatuNum[x] = "2d" end
        if bunkatuNum[x] == 54 then bunkatuNum[x] = "1d" end

        if bunkatuNum[x] == 57 then bunkatuNum[x] = "9e" end
        if bunkatuNum[x] == 58 then bunkatuNum[x] = "8e" end
        if bunkatuNum[x] == 59 then bunkatuNum[x] = "7e" end
        if bunkatuNum[x] == 60 then bunkatuNum[x] = "6e" end
        if bunkatuNum[x] == 61 then bunkatuNum[x] = "5e" end
        if bunkatuNum[x] == 62 then bunkatuNum[x] = "4e" end
        if bunkatuNum[x] == 63 then bunkatuNum[x] = "3e" end
        if bunkatuNum[x] == 64 then bunkatuNum[x] = "2e" end
        if bunkatuNum[x] == 65 then bunkatuNum[x] = "1e" end

        if bunkatuNum[x] == 68 then bunkatuNum[x] = "9f" end
        if bunkatuNum[x] == 69 then bunkatuNum[x] = "8f" end
        if bunkatuNum[x] == 70 then bunkatuNum[x] = "7f" end
        if bunkatuNum[x] == 71 then bunkatuNum[x] = "6f" end
        if bunkatuNum[x] == 72 then bunkatuNum[x] = "5f" end
        if bunkatuNum[x] == 73 then bunkatuNum[x] = "4f" end
        if bunkatuNum[x] == 74 then bunkatuNum[x] = "3f" end
        if bunkatuNum[x] == 75 then bunkatuNum[x] = "2f" end
        if bunkatuNum[x] == 76 then bunkatuNum[x] = "1f" end

        if bunkatuNum[x] == 79 then bunkatuNum[x] = "9g" end
        if bunkatuNum[x] == 80 then bunkatuNum[x] = "8g" end
        if bunkatuNum[x] == 81 then bunkatuNum[x] = "7g" end
        if bunkatuNum[x] == 82 then bunkatuNum[x] = "6g" end
        if bunkatuNum[x] == 83 then bunkatuNum[x] = "5g" end
        if bunkatuNum[x] == 84 then bunkatuNum[x] = "4g" end
        if bunkatuNum[x] == 85 then bunkatuNum[x] = "3g" end
        if bunkatuNum[x] == 86 then bunkatuNum[x] = "2g" end
        if bunkatuNum[x] == 87 then bunkatuNum[x] = "1g" end

        if bunkatuNum[x] == 90 then bunkatuNum[x] = "9h" end
        if bunkatuNum[x] == 91 then bunkatuNum[x] = "8h" end
        if bunkatuNum[x] == 92 then bunkatuNum[x] = "7h" end
        if bunkatuNum[x] == 93 then bunkatuNum[x] = "6h" end
        if bunkatuNum[x] == 94 then bunkatuNum[x] = "5h" end
        if bunkatuNum[x] == 95 then bunkatuNum[x] = "4h" end
        if bunkatuNum[x] == 96 then bunkatuNum[x] = "3h" end
        if bunkatuNum[x] == 97 then bunkatuNum[x] = "2h" end
        if bunkatuNum[x] == 98 then bunkatuNum[x] = "1h" end

        if bunkatuNum[x] == 101 then bunkatuNum[x] = "9i" end
        if bunkatuNum[x] == 102 then bunkatuNum[x] = "8i" end
        if bunkatuNum[x] == 103 then bunkatuNum[x] = "7i" end
        if bunkatuNum[x] == 104 then bunkatuNum[x] = "6i" end
        if bunkatuNum[x] == 105 then bunkatuNum[x] = "5i" end
        if bunkatuNum[x] == 106 then bunkatuNum[x] = "4i" end
        if bunkatuNum[x] == 107 then bunkatuNum[x] = "3i" end
        if bunkatuNum[x] == 108 then bunkatuNum[x] = "2i" end
        if bunkatuNum[x] == 109 then bunkatuNum[x] = "1i" end
    end

    if bunkatuNum[5] == 10 then
        bunkatuNum[5] = "+"
    else
        bunkatuNum[5] = ""
    end
    return bunkatuNum[1] .. bunkatuNum[3] .. bunkatuNum[5]
end

-- �ǖʂ�\������֐�
function hyouji()
    for i = 1, 121 do
        if HaitiGenzai[i] == 101 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 102 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 103 then
            HaitiHyouji[i] = "�j "
        elseif HaitiGenzai[i] == 104 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 105 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 106 then
            HaitiHyouji[i] = "�p "
        elseif HaitiGenzai[i] == 107 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 108 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 111 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 112 then
            HaitiHyouji[i] = "�� "
        elseif HaitiGenzai[i] == 113 then
            HaitiHyouji[i] = "�� " -- ����j
        elseif HaitiGenzai[i] == 114 then
            HaitiHyouji[i] = "�S "
        elseif HaitiGenzai[i] == 116 then
            HaitiHyouji[i] = "�n "
        elseif HaitiGenzai[i] == 117 then
            HaitiHyouji[i] = "�� "

        elseif HaitiGenzai[i] == 201 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 202 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 203 then
            HaitiHyouji[i] = "�jv"
        elseif HaitiGenzai[i] == 204 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 205 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 206 then
            HaitiHyouji[i] = "�pv"
        elseif HaitiGenzai[i] == 207 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 208 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 211 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 212 then
            HaitiHyouji[i] = "��v"
        elseif HaitiGenzai[i] == 213 then
            HaitiHyouji[i] = "��v" -- �j�n�̐���i�����u�j�̂��ւ�Ȃ��v���g���ƕ�����������j
        elseif HaitiGenzai[i] == 214 then
            HaitiHyouji[i] = "�Sv"
        elseif HaitiGenzai[i] == 216 then
            HaitiHyouji[i] = "�nv"
        elseif HaitiGenzai[i] == 217 then
            HaitiHyouji[i] = "��v"

        elseif HaitiGenzai[i] == -1 then
            HaitiHyouji[i] = "// "
        elseif HaitiGenzai[i] == 0 then
            HaitiHyouji[i] = "�� "
        else
            HaitiHyouji[i] = "0"
        end
        io.write(HaitiHyouji[i] .. ",") -- ���s�Ȃ��o��
        if i % 11 == 0 then print("") end
    end
    print("")
    print("���̎�����F��" .. HaitiGenzai[122] .. " ��" ..
              HaitiGenzai[123] .. " �j" .. HaitiGenzai[124] .. " ��" ..
              HaitiGenzai[125] .. " ��" .. HaitiGenzai[126] .. " �p" ..
              HaitiGenzai[127] .. " ��" .. HaitiGenzai[128])
    print("���̎�����F��" .. HaitiGenzai[130] .. " ��" ..
              HaitiGenzai[131] .. " �j" .. HaitiGenzai[132] .. " ��" ..
              HaitiGenzai[133] .. " ��" .. HaitiGenzai[134] .. " �p" ..
              HaitiGenzai[135] .. " ��" .. HaitiGenzai[136])
    -- ���̍��@��̕\���͖���
    print("")
    print("����͂̎�ԁi���1�A���-1�j�F " .. Teban) -- sjis�̂Ƃ��u�\\�Z������͂̎�ԁF�v 
    print("���܂ł̎萔�F " .. TeSuu)
end


-- USI�G���W���o�^�̊֐�
function TourokuMati()
    while true do
        uketori = io.read()

        io.stdout:setvbuf("no") -- �o�͂��o�b�t�@�����O���Ȃ��ݒ�B

        print("[" .. uketori .. "]")

        -- usi�G���W���o�^
        if uketori == "usi" then
            print("id name 16-168rev2-sjis_20230322")
            -- print�֐��́A�Ō�ɉ��s���t��
            print("id author R.Sueyoshi")
            print("usiok")
        end

        -- �I���R�}���h
        if uketori == "quit" then break end

        -- �΋Ǐ���
        if uketori == "isready" then print("readyok") end

        if uketori == "usinewgame" or uketori == "a" then
            -- �ua�v�Ɠ��͂��Ă��uusinewgame�v�����������B�R�}���h���C���p�B
            print(
                "�e�X�g�ǖʂœ���m�F����ꍇ�́A����͐��utb�v�A����͌��utw�v����͂��Ă�������")
            print("�w���萶�����x���m�F����ꍇ�́umaturi�v����͂��Ă�������")
            break
        end

    end

end

-- ���݂̔Ֆʂɋ���ۂ̔Ֆʂ�������֐�
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
    HaitiGenzai = {unpack(HaitiKara)}
    -- �e�[�u�����R�s�[����Ƃ�unpack���g��Ȃ��ƘA������B{�@}��Y�ꂸ�ɁB
end

-- ���݂̔Ֆʂ�StartPos�̔z�u��������֐�
function StaPosHaiti() HaitiGenzai = {unpack(HaitiStaPos)} end

-- ����������������֐�
function UgokeruTe()
    --[[
�g������
-24,-23,-22,-21,-20
-13,-12,-11,-10, -9
 -2, -1,[0],  1,  2
  9, 10, 11, 12, 13
 20, 21, 22, 23, 24
--]]

    ugokeru = {} -- ������2�����e�[�u���̐���
    for i = 101, 217 do
        ugokeru[i] = {} -- �s�̍쐬
        for j = 1, 36 do
            ugokeru[i][j] = 0 -- �Ƃ肠����0����
        end
    end

    ugokeru[101][1] = -11 -- ���̕��̓�����Ƃ���
    -- ���̍��̓�����Ƃ���
    for ugoki = 1, 8 do ugokeru[102][ugoki] = -11 * ugoki end
    ugokeru[103][1] = -23 -- ���̌j�̓�����Ƃ���
    ugokeru[103][2] = -21 -- ���̌j�̓�����Ƃ���
    ugokeru[104][1] = -12 -- ���̋�̓�����Ƃ���
    ugokeru[104][2] = -11 -- ���̋�̓�����Ƃ���
    ugokeru[104][3] = -10 -- ���̋�̓�����Ƃ���
    ugokeru[104][4] = 10 -- ���̋�̓�����Ƃ���
    ugokeru[104][5] = 12 -- ���̋�̓�����Ƃ���
    ugokeru[105][1] = -10 -- ���̋��̓�����Ƃ���
    ugokeru[105][2] = -12 -- ���̋��̓�����Ƃ���
    ugokeru[105][3] = -11 -- ���̋��̓�����Ƃ���
    ugokeru[105][4] = -1 -- ���̋��̓�����Ƃ���
    ugokeru[105][5] = 1 -- ���̋��̓�����Ƃ���
    ugokeru[105][6] = 11 -- ���̋��̓�����Ƃ���
    -- ���̊p�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[106][ugoki] = -12 * ugoki
        ugokeru[106][ugoki + 8] = 12 * ugoki
        ugokeru[106][ugoki + 16] = -10 * ugoki
        ugokeru[106][ugoki + 24] = 10 * ugoki
    end
    -- ���̔�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[107][ugoki] = -11 * ugoki
        ugokeru[107][ugoki + 8] = 11 * ugoki
        ugokeru[107][ugoki + 16] = -1 * ugoki
        ugokeru[107][ugoki + 24] = 1 * ugoki
    end
    ugokeru[108][1] = -12 -- ���̉��̓�����Ƃ���
    ugokeru[108][2] = -11 -- ���̉��̓�����Ƃ���
    ugokeru[108][3] = -10 -- ���̉��̓�����Ƃ���
    ugokeru[108][4] = -1 -- ���̉��̓�����Ƃ���
    ugokeru[108][5] = 1 -- ���̉��̓�����Ƃ���
    ugokeru[108][6] = 10 -- ���̉��̓�����Ƃ���
    ugokeru[108][7] = 11 -- ���̉��̓�����Ƃ���
    ugokeru[108][8] = 12 -- ���̉��̓�����Ƃ���

    ugokeru[111][1] = -10 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[111][2] = -12 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[111][3] = -11 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[111][4] = -1 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[111][5] = 1 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[111][6] = 11 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[112][1] = -10 -- ���̈ǂ̓�����Ƃ���
    ugokeru[112][2] = -12 -- ���̈ǂ̓�����Ƃ���
    ugokeru[112][3] = -11 -- ���̈ǂ̓�����Ƃ���
    ugokeru[112][4] = -1 -- ���̈ǂ̓�����Ƃ���
    ugokeru[112][5] = 1 -- ���̈ǂ̓�����Ƃ���
    ugokeru[112][6] = 11 -- ���̈ǂ̓�����Ƃ���
    ugokeru[113][1] = -10 -- ���̌\�̓�����Ƃ���
    ugokeru[113][2] = -12 -- ���̌\�̓�����Ƃ���
    ugokeru[113][3] = -11 -- ���̌\�̓�����Ƃ���
    ugokeru[113][4] = -1 -- ���̌\�̓�����Ƃ���
    ugokeru[113][5] = 1 -- ���̌\�̓�����Ƃ���
    ugokeru[113][6] = 11 -- ���̌\�̓�����Ƃ���
    ugokeru[114][1] = -10 -- ���̑S�̓�����Ƃ���
    ugokeru[114][2] = -12 -- ���̑S�̓�����Ƃ���
    ugokeru[114][3] = -11 -- ���̑S�̓�����Ƃ���
    ugokeru[114][4] = -1 -- ���̑S�̓�����Ƃ���
    ugokeru[114][5] = 1 -- ���̑S�̓�����Ƃ���
    ugokeru[114][6] = 11 -- ���̑S�̓�����Ƃ���
    -- ���̔n�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[116][ugoki] = -12 * ugoki
        ugokeru[116][ugoki + 8] = 12 * ugoki
        ugokeru[116][ugoki + 16] = -10 * ugoki
        ugokeru[116][ugoki + 24] = 10 * ugoki
    end
    ugokeru[116][33] = -11 -- ���̔n�̓�����Ƃ���
    ugokeru[116][34] = -1 -- ���̔n�̓�����Ƃ���
    ugokeru[116][35] = 1 -- ���̔n�̓�����Ƃ���
    ugokeru[116][36] = 11 -- ���̔n�̓�����Ƃ���
    -- ���̗��̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[117][ugoki] = -11 * ugoki
        ugokeru[117][ugoki + 8] = 11 * ugoki
        ugokeru[117][ugoki + 16] = -1 * ugoki
        ugokeru[117][ugoki + 24] = 1 * ugoki
    end
    ugokeru[117][33] = -12 -- ���̗��̓�����Ƃ���
    ugokeru[117][34] = -10 -- ���̗��̓�����Ƃ���
    ugokeru[117][35] = 10 -- ���̗��̓�����Ƃ���
    ugokeru[117][36] = 12 -- ���̗��̓�����Ƃ���

    ugokeru[201][1] = 11 -- ���̕��̓�����Ƃ���
    -- ���̍��̓�����Ƃ���
    for ugoki = 1, 8 do ugokeru[202][ugoki] = 11 * ugoki end
    ugokeru[203][1] = 21 -- ���̌j�̓�����Ƃ���
    ugokeru[203][2] = 23 -- ���̌j�̓�����Ƃ���
    ugokeru[204][1] = -12 -- ���̋�̓�����Ƃ���
    ugokeru[204][2] = -10 -- ���̋�̓�����Ƃ���
    ugokeru[204][3] = 10 -- ���̋�̓�����Ƃ���
    ugokeru[204][4] = 11 -- ���̋�̓�����Ƃ���
    ugokeru[204][5] = 12 -- ���̋�̓�����Ƃ���
    ugokeru[205][1] = -11 -- ���̋��̓�����Ƃ���
    ugokeru[205][2] = -1 -- ���̋��̓�����Ƃ���
    ugokeru[205][3] = 1 -- ���̋��̓�����Ƃ���
    ugokeru[205][4] = 10 -- ���̋��̓�����Ƃ���
    ugokeru[205][5] = 11 -- ���̋��̓�����Ƃ���
    ugokeru[205][6] = 12 -- ���̋��̓�����Ƃ���
    -- ���̊p�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[206][ugoki] = -12 * ugoki
        ugokeru[206][ugoki + 8] = 12 * ugoki
        ugokeru[206][ugoki + 16] = -10 * ugoki
        ugokeru[206][ugoki + 24] = 10 * ugoki
    end
    -- ���̔�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[207][ugoki] = -11 * ugoki
        ugokeru[207][ugoki + 8] = 11 * ugoki
        ugokeru[207][ugoki + 16] = -1 * ugoki
        ugokeru[207][ugoki + 24] = 1 * ugoki
    end
    ugokeru[208][1] = -12 -- ���̉��̓�����Ƃ���
    ugokeru[208][2] = -11 -- ���̉��̓�����Ƃ���
    ugokeru[208][3] = -10 -- ���̉��̓�����Ƃ���
    ugokeru[208][4] = -1 -- ���̉��̓�����Ƃ���
    ugokeru[208][5] = 1 -- ���̉��̓�����Ƃ���
    ugokeru[208][6] = 10 -- ���̉��̓�����Ƃ���
    ugokeru[208][7] = 11 -- ���̉��̓�����Ƃ���
    ugokeru[208][8] = 12 -- ���̉��̓�����Ƃ���
    ugokeru[211][1] = -11 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[211][2] = -1 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[211][3] = 1 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[211][4] = 10 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[211][5] = 11 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[211][6] = 12 -- ���̂Ƃ̓�����Ƃ���
    ugokeru[212][1] = -11 -- ���̈ǂ̓�����Ƃ���
    ugokeru[212][2] = -1 -- ���̈ǂ̓�����Ƃ���
    ugokeru[212][3] = 1 -- ���̈ǂ̓�����Ƃ���
    ugokeru[212][4] = 10 -- ���̈ǂ̓�����Ƃ���
    ugokeru[212][5] = 11 -- ���̈ǂ̓�����Ƃ���
    ugokeru[212][6] = 12 -- ���̈ǂ̓�����Ƃ���
    ugokeru[213][1] = -11 -- ���̌\�̓�����Ƃ���
    ugokeru[213][2] = -1 -- ���̌\�̓�����Ƃ���
    ugokeru[213][3] = 1 -- ���̌\�̓�����Ƃ���
    ugokeru[213][4] = 10 -- ���̌\�̓�����Ƃ���
    ugokeru[213][5] = 11 -- ���̌\�̓�����Ƃ���
    ugokeru[213][6] = 12 -- ���̌\�̓�����Ƃ���
    ugokeru[214][1] = -11 -- ���̑S�̓�����Ƃ���
    ugokeru[214][2] = -1 -- ���̑S�̓�����Ƃ���
    ugokeru[214][3] = 1 -- ���̑S�̓�����Ƃ���
    ugokeru[214][4] = 10 -- ���̑S�̓�����Ƃ���
    ugokeru[214][5] = 11 -- ���̑S�̓�����Ƃ���
    ugokeru[214][6] = 12 -- ���̑S�̓�����Ƃ���
    -- ���̔n�̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[216][ugoki] = -12 * ugoki
        ugokeru[216][ugoki + 8] = 12 * ugoki
        ugokeru[216][ugoki + 16] = -10 * ugoki
        ugokeru[216][ugoki + 24] = 10 * ugoki
    end
    ugokeru[216][33] = -11 -- ���̔n�̓�����Ƃ���
    ugokeru[216][34] = -1 -- ���̔n�̓�����Ƃ���
    ugokeru[216][35] = 1 -- ���̔n�̓�����Ƃ���
    ugokeru[216][36] = 11 -- ���̔n�̓�����Ƃ���
    -- ���̗��̓�����Ƃ���
    for ugoki = 1, 8 do
        ugokeru[217][ugoki] = -11 * ugoki
        ugokeru[217][ugoki + 8] = 11 * ugoki
        ugokeru[217][ugoki + 16] = -1 * ugoki
        ugokeru[217][ugoki + 24] = 1 * ugoki
    end
    ugokeru[217][33] = -12 -- ���̗��̓�����Ƃ���
    ugokeru[217][34] = -10 -- ���̗��̓�����Ƃ���
    ugokeru[217][35] = 10 -- ���̗��̓�����Ƃ���
    ugokeru[217][36] = 12 -- ���̗��̓�����Ƃ���

end

-- ����������̃R�}���h�҂��̊֐�
function NyuryokuMati()
    while true do
        uketori = io.read()

        io.stdout:setvbuf("no") -- �o�͂��o�b�t�@�����O���Ȃ��ݒ�B

        --    print("["..uketori.."]") --���͕����̊m�F�p

        -- �I���R�}���h
        if uketori == "quit" then break end

        -- �΋Ǐ���
        if uketori == "isready" then print("readyok") end

        --[[���͂̏ȗ�
--]]
        if uketori == "s" then
            uketori = "position startpos"
            -- ��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
            print([[�uposition startpos�v���Z�b�g���܂����B
�����́uc�v����͂��Ă��������B]])
        end

        if uketori == "tb" then -- �e�X�g�ǖ� ����͐��
            uketori =
                "position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b"
            -- ��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
            print(
                [[�uposition startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b�v���Z�b�g���܂����B
�����́A�uc�v����͂��Ă��������B]])
        end

        if uketori == "tw" then -- �e�X�g�ǖ� ����͌��
            uketori =
                "position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f"
            -- ��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
            print(
                [[�uposition startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f�v���Z�b�g���܂����B
�����́A�uc�v����͂��Ă��������B]])
        end

        if uketori == "c" then
            uketori = "go btime 3599000 wtime 3597000 byoyomi 0"
        end

        --[[�������̃G���W��1�ցi�܂��̓R�}���h���C���Łj�A
   �umaturi�v���蓮���͂����
		�����w���萶���Ղ�̋ǖʃZ�b�g�B���Ԃ�198��B���E��������199��B
--]]
        if uketori == "maturi" then
            uketori =
                "position sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1"
            -- ��[[�@]]�͉��s���Ƃ��̂܂܏o�͂���
            print(
                [[�w���萶���Ղ�̋ǖʃZ�b�g�uposition sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1�v���Z�b�g���܂����B
�����́umaturi2�v����͂��Ă��������B]])
            maturi = 1 -- �����́Amaturi2�ցB
        end

        if uketori == "maturi2" then
            if maturi ~= 1 then
                print("��Ɂumaturi�v����͂��Ă��������B")
            else
                HyojiMaturi()
            end -- �Ղ�p�Ֆʕ\��
        end

        -- hyouji�Ɠ��͂���ƁA�Ֆʏ󋵂�\������
        if uketori == "hyouji" then
            hyouji()
        end

        -- �ȉ��A�uposition�v�Ɓugo�v�R�}���h�̑Ή�  
        if string.match(uketori, "position st", n) ~= nil then -- startpos��ݒ�
            Bunkatu()
            if BunkatuSuu == 2 then
                Teban = 1 -- ����͂̎�Ԃ����i1�j
                TeSuu = 1
            elseif BunkatuSuu % 2 == 1 then -- ��Ȃ���
                Teban = 1
                TeSuu = BunkatuSuu - 2 -- moves�̎��̕������TeSuu=1
            elseif BunkatuSuu % 2 == 0 then -- �����Ȃ���
                Teban = -1 -- ����͂̎�Ԃ����i-1�j
                TeSuu = BunkatuSuu - 2 -- moves�̎��̕������TeSuu=1
            end

            ItijiTeban = Teban  -- �ꎞ�I�ɂ���͂̎�Ԃ�ۑ�����B
            -- moves�̂�����̎w���肪���ԁi1�j�ɂȂ�悤�ɒ����B
            Teban = -1
            for i = 1, 550 do -- BunkatuMoji��1��ڂ��珇�ɑ�����Ă������[�v�B�������肷��ő�萔���傫������B
                if BunkatuMoji[i] == nil then
                    saigonoiti = BantiHeHenkan(AtoIti) -- �Ō�̑���̈���ۑ��B�ǋL170602
                    Teban = ItijiTeban  -- ����͂̎�Ԃ����ɖ߂��B
                    break
                end
                HaitiDainyu(i, Teban) -- 4��������Ֆʂɑ������֐�
                Teban = -Teban
            end
        end

        if string.match(uketori, "position sf", n) ~= nil then -- sfen��ݒ�
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
      ]] --

            if BunkatuMoji[4] == "b" then
                if BunkatuSuu == 6 then
                    Teban = 1 -- ����͂̎�Ԃ����i1�j
                    TeSuu = 1
                elseif BunkatuSuu % 2 == 1 then -- ��Ȃ���
                    Teban = 1
                    TeSuu = BunkatuSuu - 6 -- moves�̎��̕������TeSuu=1
                elseif BunkatuSuu % 2 == 0 then -- �����Ȃ���
                    Teban = -1 -- ����͂̎�Ԃ����i-1�j
                    TeSuu = BunkatuSuu - 6 -- moves�̎��̕������TeSuu=1
                end
            else -- BunkatuMoji[4]=="w"�̂Ƃ�
                if BunkatuSuu == 6 then
                    Teban = -1 -- ����͂̎�Ԃ����i1�j
                    TeSuu = 1
                elseif BunkatuSuu % 2 == 1 then -- ��Ȃ���
                    Teban = -1
                    TeSuu = BunkatuSuu - 6 -- moves�̎��̕������TeSuu=1
                elseif BunkatuSuu % 2 == 0 then -- �����Ȃ���
                    Teban = 1 -- ����͂̎�Ԃ����i-1�j
                    TeSuu = BunkatuSuu - 6 -- moves�̎��̕������TeSuu=1
                end
            end
            
            Bunkatu()
            ItijiTeban = Teban  -- �ꎞ�I�ɂ���͂̎�Ԃ�ۑ�����B
            -- �����Ă���sfen��index4���ub�v�Ȃ�moves�̂�����̎w���肪���ԁi1�j�ɂȂ�悤�ɒ����B
            if BunkatuMoji[4] == "b" then
                Teban = -1
            end
            
            for i = 1, 550 do -- BunkatuMoji��1��ڂ��珇�ɑ�����Ă������[�v�B�������肷��ő�萔���傫������B
                if BunkatuMoji[i] == nil then
                    saigonoiti = BantiHeHenkan(AtoIti) -- �Ō�̑���̈���ۑ��B�ǋL170602
                    Teban = ItijiTeban  -- ����͂̎�Ԃ����ɖ߂��B
                    break
                end
                HaitiDainyu(i,Teban) -- 4��������Ֆʂɑ������֐�
                Teban = -Teban -- ��Ԃ����ւ���
            end
        end
        
        -- bestmove���l����
        if string.match(uketori, "go b", n) ~= nil then
            -- �ǖʂ�\������
            hyouji()
            -- 513��𒴂��Ă��邩���`�F�b�N
            if TeSuu >= 513 then
                print(
                    "info string 513��𒴂��Ă��܂��I�H�c�c�܂���܂���orz") -- ��������
                print("bestmove resign") -- ��������
            end
            
            -- ���ǖʂ�\������
            
            -- ���ǖʂŁA����͂̎���1��ڂ̍��@��̐�������B
            -- Sasite[x][1-5]�ɍ��@��𐶐�����B
            Gouhousyu(Teban, HaitiGenzai, Sasite)

            -- �m�[�h��
            nodesuu = gouhousyukazu
            print("info depth 1 nodes " .. nodesuu)

            -- 2017/01/04�����܂ŁB
            -- Sasite�Ɍ��ǖʂ̂���͂̎���1��ڂ̍��@����c���A
            -- ���@����i�荞�ނ��߂�SasiteItiji��Sasite���R�s�[����B
            for i = 1, 600 do
                if Sasite[i][1] == 999 then
                    SasiteItiji[i][1] = 999
                    --print("1�F999����ꂽ�BSasiteItiji[i]",i)
                    break
                end
                for j = 1, 5 do SasiteItiji[i][j] = Sasite[i][j] end
            end

            -- HaitiItiji�ɂ��鍇�@��̍i�荞�݁B
            -- �Ȃ����ł�̎��A�������łƂ��Ƃ���B�@��170602�ɏC���ς݁B
            x = 1
            tuikagouhousyukazu = 0
            for i = 1, 600 do 
                if Sasite[i][1] == 999 then
                    -- print("Sasite��999����i,x:",i,x)
                    -- print("")
                    -- �ǒn�\�����[�h���Ō�␔�����炵������SasiteItiji�����炷����999������
                    --SasiteItiji[x][1] = 999
                    --print("2�F999����ꂽ�BSasiteItiji[x]",x)
                    SasiteItiji[i][1] = 999
                    --print("2'�F999����ꂽ�BSasiteItiji[i]",i)
                    break
                end

                -- �ʂׂ̗ɉ�����d�|���Ă�����A�ʂŎ��B
                -- ��␔��1�ɂ���B�@�����ԍ�2��[1]��999�ɂ���B
                if Sasite[i][3] == saigonoiti and
                    (Sasite[i][2] == 108 or Sasite[i][2] == 208) then
                    for j = 1, 5 do
                        SasiteItiji[1][j] = Sasite[i][j]
                        SasiteItiji[2][1] = 999
                        --print("3�F999����ꂽ�B���łƂ�Sasite[i]",i, unpack(Sasite[i]) )
                        tuikagouhousyukazu = 1
                        gouhousyukazu = 1
                    end
                    break
                end

                -- �ǒn���[�hOn�Bwcsc29���ɓ��ځB
                -- ����͂̎���1�肪�A����̍Ō�̎�̋߂����ǂ������m�F����B
                -- ����̍Ō�Ɏw������̈ʒu�₻�̎��ӂɁA����h������łw������W�߂�B
                -- �ǒn���[�h�Ń����_���w���̏ꍇ�́A�ǒn�\�����[�h�B
                if Sasite[i][3] == saigonoiti - 12 or Sasite[i][3] ==
                    saigonoiti - 11 or Sasite[i][3] == saigonoiti - 10 or
                    Sasite[i][3] == saigonoiti - 1 or Sasite[i][3] ==
                    saigonoiti or Sasite[i][3] == saigonoiti + 1 or
                    Sasite[i][3] == saigonoiti + 10 or Sasite[i][3] ==
                    saigonoiti + 11 or Sasite[i][3] == saigonoiti + 12 then
                    -- SasiteItiji��1���珇�ɏ㏑������B��������B
                    for j = 1, 5 do
                        SasiteItiji[x][j] = Sasite[i][j]
                    end
                    tuikagouhousyukazu = x
                    -- �ǒn�\�����[�h���̎w���萔
                    gouhousyukazu = x
                    x = x + 1
                    -- SasiteItiji��1���珇�ɏ㏑������B�����܂ŁB
                end
            end

            -- 2017/5/3�w����ԍ��A�����_���������B
            math.randomseed(os.time())
            -- 2020-11-21�@����͂̌�␔�̊m�F�̂���
            -- print("�ȉ��͋ǒn���[�h�̏����������w����")
            print("�ǒn���[�h��gouhousyukazu:", gouhousyukazu)
            kouhosuu = gouhousyukazu
            -- print_sasite(Sasite)
            -- ��␔gouhousyukazu����A�w����ԍ��������_���Ɍ��߂�
            -- �w����̑I������
            sentakusisuu = gouhousyukazu

            -- 2019-05-03�܂�
            -- sasitebangou = math.random(sentakusisuu)
            -- 2019-11-21�Ɉȉ��ɕύX
            -- ���݂̔Ֆ�
            -- �[��1�@�T����
            -- �w����̌����A�e�v�f3������1�̕�����i�����j�ɂ��Ċi�[����B
            -- ��jSasite�@1:�@18�@105�@19�@206�@0
            -- �@���@SasiteAll1�@018105019206000
            -- 1���̕]���l������
            -- �@���@SasiteValueAll1�@{3456,5678,7890}
            SasiteAll1 = {}
            SasiteValueAll1 = {}
            for i = 1, sentakusisuu do
                SasiteAll1[i] = ""
                for j = 1, 5 do
                    SasiteAll1[i] = SasiteAll1[i] ..
                                        string.format("%03d", SasiteItiji[i][j])
                end
                -- 1����ǂށB
                -- Yomu(Sasite[index])��HaitiYomi
                -- �����ESasite��index�̂��̂��A�ǖ�HaitiYomi�ɓ����B
                Yomu(i)
                print("info depth 1 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                          " score cp " .. KyokumenHyouka(HaitiYomi))
            end
            -- print("SasiteAll1", unpack(SasiteAll1) )
            -- print("SasiteValueAll1", unpack(SasiteValueAll1) )
            print("")
            -- �����܂ŁA���݂̔Ֆ�

            -- 1���̋ǖ�
            -- �]���l�����郊�X�g
            HyokaList = {}
            -- �w����̌����A�e�v�f3������1�̕�����i�����j�ɂ��Ċi�[����B
            -- ��jSasite�@1:�@18�@105�@19�@206�@0
            -- �@���@SasiteAll2[x]�@018105019206000
            -- �]���l�����郊�X�g
            -- �@���@SasiteValueAll2[x]�@���l
            SasiteAll2 = {}
            SasiteValueAll2 = {}
            -- �Ő[���̕]���l������
            finalVlue1 = {}
            finalVlue2 = {}
            -- �Ő[���܂ł̎w���������
            finalindex1 = {}
            finalindex2 = {}
            -- SasiteItiji�̊e�w����ԍ��̎w����̋ǖʂ��쐬����B
            -- 1����index����maxn()�Œ��ׂ�
            for i = 1, table.maxn(SasiteAll1) do
                -- ��������A1���
                -- ������SasiteItiji�̎w����ԍ��B���̎w������ǖ�HaitiYomi�ɓ����B
                Yomu(i)
                -- SasiteYomi�̏�����
                SasiteYomi = {}
                for j = 1, 600 do
                    -- Sasite�n�̔z��̍s�̍쐬
                    SasiteYomi[j] = {}
                    for k = 1, 5 do SasiteYomi[j][k] = 0 end
                end
                -- �����܂ŁASasiteYomi�̏�����
                -- 2���A����̍��@����l����BGouhousyu(1:���,-1:���, HaitiYomi, Sasite�n)
                Gouhousyu(-Teban, HaitiYomi, SasiteYomi)
                print("SasiteYomi-index:", i, SasiteAll1[i])
                -- print_sasite( SasiteYomi )
                -- �����܂ŁA1���

                -- ��������A2���
                -- �[��2�@�T����
                SasiteAll2[i] = {}
                SasiteValueAll2[i] = {}
                finalVlue2[i] = {}
                finalindex2[i] = {}
                -- 2���̌�␔
                for j = 1, kouhosuu do
                    SasiteAll2[i][j] = {}
                    SasiteValueAll2[i][j] = {}
                    finalVlue2[i][j] = {}
                    SasiteAll2[i][j] = ""
                    for k = 1, 5 do
                        SasiteAll2[i][j] =
                            SasiteAll2[i][j] ..
                                string.format("%03d", SasiteYomi[j][k])
                    end
                    -- 2����ǂށB
                    -- Yomu2(SasiteYomi[index])��HaitiYomi2
                    -- �����ESasiteYomi��index�̂��̂��A�ǖ�HaitiYomi2�ɓ����B
                    Yomu2(j)
                    -- 2��ڂƁA2���̕]���l��\������
                    --[[
                        print(
                        "info depth 2 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                            " " .. Num15CharConvert(SasiteAll2[i][j]) .. " " ..
                            "score cp " .. KyokumenHyouka(HaitiYomi2))
                    --]]
                    -- �e�ǖʂ̕]���l�����߂�B
                    SasiteValueAll2[i][j] = KyokumenHyouka(HaitiYomi2)
                    HyokaList[i] = KyokumenHyouka(HaitiYomi)
                    -- �Ő[���̍ŏ��̕]���l������
                    finalVlue2[i][j] = KyokumenHyouka(HaitiYomi2)
                end
                finalVlue1[i] = {}
                finalindex1[i] = {}
                -- �Ő[���̍ŏ��̕]���l�ŁA2��掞�̎w���蓙������
                if Teban == 1 then
                    index2, value2 = min(finalVlue2[i])
                    finalVlue1[i] = value2
                    print("2���i���j�̍ŏ��lvalue2", value2)
                    finalindex1[i] = SasiteAll2[i][index2]
                    print("2���i���j�̍ŏ��l�̎w����",
                          SasiteAll2[i][index2])
                else
                    index2, value2 = max(finalVlue2[i])
                    finalVlue1[i] = value2
                    print("2���i���j�̍ő�lvalue2", value2)
                    finalindex1[i] = SasiteAll2[i][index2]
                    print("2���i���j�̍ő�l�̎w����",
                          SasiteAll2[i][index2])
                end
                --2���̑I�яo�����w����Ƃ��̕]�����o�͂���
                print(
                    "info depth 2 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                        " " .. Num15CharConvert( SasiteAll2[i][index2] ) .. " " ..
                        "score cp " .. value2 )

                -- node���v������
                nodesuu = nodesuu + kouhosuu
                print("info depth 2 nodes " .. nodesuu)
                print("")
                -- print("SasiteAll2[i]:",i, unpack(SasiteAll2[i]) )
                -- print("SasiteValueAll2[i]:",i, unpack(SasiteValueAll2[i]) )
                -- �����܂ŁA2���
                -- �����܂ŁA1���̋ǖ�
            end

            -- 1���̕]���l�̒��ł̍ő�l�i�ŏ��l�j
            -- ����͂����̏ꍇ�B
            if Teban == 1 then
                index1, value1 = max(finalVlue1)
                -- �Ő[���܂ŒT���������̂ł̓ǂ݂ōőP��i�]���l�A���index�j
                saizen = {}
                saizen["hyouka"] = value1
                saizen["index"] = SasiteAll1[index1] .. finalindex1[index1]
                print("saizen.hyouka(max), saizen.index:", saizen.hyouka,
                      saizen.index)
                print("Teban:1, ", Teban)
            -- ����͂����̏ꍇ�B
            else
                index1, value1 = min(finalVlue1)
                -- �Ő[���܂ŒT���������̂ł̓ǂ݂ōőP��i�]���l�A���index�j
                saizen = {}
                saizen["hyouka"] = value1
                saizen["index"] = SasiteAll1[index1] .. finalindex1[index1]
                print("saizen.hyouka(min), saizen.index:", saizen.hyouka,
                      saizen.index)
                print("Teban:-1, ", Teban)
            end
            -- �őP���index
            sasitebangou = index1

            -- ����͂̉����Ƃ��邩�`�F�b�N�B�@��MOD:020-12-02�����B
            -- Yomu��Sashiteitiji���g���B
            Yomu(sasitebangou)
            -- ����͐��B
            if Teban ~= 0 then
                Gouhousyu(-Teban, HaitiYomi, SasiteYomi)
                --print("����͂̉��Ƃ��`�F�b�N")
                for i = 1, 600 do
                    --print("SasiteYomi[",i,"]", unpack(SasiteYomi[i]) )
                    -- 999�̎��͌������I������B
                    if SasiteYomi[i][1] == 999 then
                        --print("Teban:1, SasiteYomi[i]:999 ",i)
                        break
                    end
                    --print("��������邩�`�F�b�NSasiteYomi�F", i, unpack(SasiteYomi[i]))
                    -- ����͂̉��������Ȃ瓊������B
                    if SasiteYomi[i][4] == 108 or SasiteYomi[i][4] == 208 then
                        print("info string �I�H�c�c�܂���܂���orz")
                        print("bestmove resign") 
                    end
                end
            end
            -- �����܂ŁA����͂̉����Ƃ��邩�`�F�b�N

            -- 2019/05/03 <ADD 2020/11/21 <MOD
            print("�ŏI�̍��@�萔: ", sentakusisuu)
            print("�w����ԍ�: ", sasitebangou)
            -- 2019/05/03 ADD>

            -- �����������ϊ�
            -- 2020/11/22�֐���
            -- Sasite��usi�v���g�R���ő��镶����
            sasiteMoji = ""
            for i = 1, 5 do
                sasiteMoji = sasiteMoji ..
                                 string.format("%03d", SasiteItiji[sasitebangou][i])
            end

            -- �]���l�̌v�Z������
            -- tensuu = math.random(2000)-1000
            tensuu = KyokumenHyouka(HaitiGenzai)

            print("info string ���̋��" .. sentetoku ..
                      "vs���̋��" .. -gotetoku)
            print("info string ���̎�萔" .. sentemamorikazu ..
                      "vs���̎�萔" .. gotemamorikazu)
            print("info string ���̎��_" .. sentemamoriten ..
                      "vs���̎��_" .. gotemamoriten)

            if tuikagouhousyukazu >= 1 then
                --        print("info string �ǉ��w���萔"..tuikagouhousyukazu)
            end

            if Teban == 1 then
                print("info nodes " .. nodesuu .. " score cp " .. tensuu ..
                          " pv " .. Num15CharConvert(sasiteMoji))
            else
                -- Teban��-1�̂Ƃ��X�R�A�𔽓]
                print("info nodes " .. nodesuu .. " score cp " .. -tensuu ..
                          " pv " .. Num15CharConvert(sasiteMoji))
            end
            -- ���̈��𑗐M����B
            -- ��j�@bestmove N*9e
            print("b-move2:", sasiteMoji)
            print("bestmove " .. Num15CharConvert(sasiteMoji))
            -- �v�l���̕\�� info time 0 depth 2 nodes 218 score cp 193 pv 8i7g 8e8f
            --[[
sfen�̏������ł��܂����Binfo score�ŃX�R�A�\��
���āAhaitidainyu���ł��Ă��܂���ł����B
���ł��Ă�H�H�H20170601

���̎��́A���悢�捇�@��̐����ł��B
���̂��Ƃ́A
�E�����_���w��
�E���l�߃��[�`��
�E�]���֐�
      ]] --

        end

        if string.match(uketori, "go m", n) ~= nil then -- �l�ߏ������l����
            print("go m�A��������")
        end

    end

end

-- ������𕪊�����֐�
function Bunkatu()

    -- uketori = "position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d"
    -- position startpos moves 2g2f 5a4b 2f2e ���
    -- position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b P*2e
    -- position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d

    BunkatuSuu = 0
    BunkatuMoji = {}
    -- ��������̕����B�p���������؂蕶���B
    for i in uketori:gmatch("[%a%d%p]+") do
        BunkatuSuu = BunkatuSuu + 1 -- �󂯎�����R�}���h�𕪊�������
        BunkatuMoji[BunkatuSuu] = i -- �󂯎�����R�}���h�𕪊����Ď��[
    end

end

-- 4��������Ֆʂɑ������֐�
function HaitiDainyu(mTeme, haitiTeban)
    if BunkatuMoji[mTeme] == "startpos" then
        HaitiGenzai = {unpack(HaitiStaPos)} -- {�@}��Y�ꂸ��
    end
    -- �� 11/21�����܂ŁB
    MaeIti = string.sub(BunkatuMoji[mTeme], 1, 2)
    -- ���������̍ŏI�ʒu���ȗ�����ƍŌ�܂ŁB
    AtoIti = string.sub(BunkatuMoji[mTeme], 3, 4)
    -- ���萔mTeme��BunkatuMoji����A���������2�������L�^
    Naruka = string.sub(BunkatuMoji[mTeme], 5, 5)
    -- ���萔mTeme��BunkatuMoji����A����i+�j�����L�^

    if BantiHeHenkan(MaeIti) > 0 then
        MaeKoma = HaitiGenzai[BantiHeHenkan(MaeIti)]
        -- �������O�̈ʒu�̋�̎�ނ��L�^
        HaitiGenzai[BantiHeHenkan(MaeIti)] = 0 -- �����O�̈ʒu��0�ɂ���
    elseif BantiHeHenkan(MaeIti) == 0 then
        MaeKoma = 0
    else
        return
    end

    ToruKoma = HaitiGenzai[BantiHeHenkan(AtoIti)]
    -- ��������̈ʒu�̋�i����j�̎�ނ��L�^
    -- ��2��������Ԓn�ԍ��֕ϊ�����֐�

    UgokuKoma = MaeKoma

    if MaeKoma == 0 then -- �����O�̋�̎�ނ�0�i��j�Ȃ�
        UgokuKoma = Utu(MaeIti)
        if haitiTeban == 1 then -- ���Ȃ�
            UgokuKoma = UgokuKoma + 100
            -- ��UgokuKoma�ɐ����Ӗ�����100�𑫂�
            HaitiGenzai[UgokuKoma + 21] = HaitiGenzai[UgokuKoma + 21] - 1
            -- ��101�Ƃ̍���+21�B������̖��������炷
        else -- ���Ȃ�
            UgokuKoma = UgokuKoma + 200
            -- ��UgokuKoma�Ɍ����Ӗ�����200�𑫂�
            HaitiGenzai[UgokuKoma - 71] = HaitiGenzai[UgokuKoma - 71] - 1
            -- ��201�Ƃ̍���-71�B������̖��������炷
        end
    end

    if ToruKoma > 0 and ToruKoma < 200 then -- ��肪�������
        HaitiGenzai[Toru(ToruKoma) - 71] = HaitiGenzai[Toru(ToruKoma) - 71] + 1
        -- ��201�Ƃ̍���-71�B��������A������̖����𑝂₷
    elseif ToruKoma > 200 then
        HaitiGenzai[Toru(ToruKoma) + 21] = HaitiGenzai[Toru(ToruKoma) + 21] + 1
        -- ��101�Ƃ̍���+21�B��������A������̖����𑝂₷
    end

    if Naruka == "+" then -- ���鏈��
        UgokuKoma = UgokuKoma + 10
    end

    HaitiGenzai[BantiHeHenkan(AtoIti)] = UgokuKoma
end

-- �łƂ��̋�̎�ނ̊֐�
--[[
���ł�̎��
�o�k�m�r�f�a�q
�����j����p��
�P�Q�R�S�T�U�V
--]]
function Utu(KomaSyurui)
    if KomaSyurui == "P*" then return 1 end
    if KomaSyurui == "L*" then return 2 end
    if KomaSyurui == "N*" then return 3 end
    if KomaSyurui == "S*" then return 4 end
    if KomaSyurui == "G*" then return 5 end
    if KomaSyurui == "B*" then return 6 end
    if KomaSyurui == "R*" then
        return 7
    else
        return 0
    end
end

-- ����Ƃ����Ƃ��̋�̎�ޕϊ�������֐�
function Toru(KomaSyurui)
    if KomaSyurui == 101 or KomaSyurui == 111 then return 201 end
    if KomaSyurui == 102 or KomaSyurui == 112 then return 202 end
    if KomaSyurui == 103 or KomaSyurui == 113 then return 203 end
    if KomaSyurui == 104 or KomaSyurui == 114 then return 204 end
    if KomaSyurui == 105 or KomaSyurui == 115 then return 205 end
    if KomaSyurui == 106 or KomaSyurui == 116 then return 206 end
    if KomaSyurui == 107 or KomaSyurui == 117 then return 207 end
    if KomaSyurui == 201 or KomaSyurui == 211 then return 101 end
    if KomaSyurui == 202 or KomaSyurui == 212 then return 102 end
    if KomaSyurui == 203 or KomaSyurui == 213 then return 103 end
    if KomaSyurui == 204 or KomaSyurui == 214 then return 104 end
    if KomaSyurui == 205 or KomaSyurui == 215 then return 105 end
    if KomaSyurui == 206 or KomaSyurui == 216 then return 106 end
    if KomaSyurui == 207 or KomaSyurui == 217 then
        return 107
    else
        return 0
    end
end

-- 2��������Ԓn�ԍ��֕ϊ�����֐�
function BantiHeHenkan(ItiMoji)
    if ItiMoji == "9a" then return 13 end
    if ItiMoji == "8a" then return 14 end
    if ItiMoji == "7a" then return 15 end
    if ItiMoji == "6a" then return 16 end
    if ItiMoji == "5a" then return 17 end
    if ItiMoji == "4a" then return 18 end
    if ItiMoji == "3a" then return 19 end
    if ItiMoji == "2a" then return 20 end
    if ItiMoji == "1a" then return 21 end
    if ItiMoji == "9b" then return 24 end
    if ItiMoji == "8b" then return 25 end
    if ItiMoji == "7b" then return 26 end
    if ItiMoji == "6b" then return 27 end
    if ItiMoji == "5b" then return 28 end
    if ItiMoji == "4b" then return 29 end
    if ItiMoji == "3b" then return 30 end
    if ItiMoji == "2b" then return 31 end
    if ItiMoji == "1b" then return 32 end
    if ItiMoji == "9c" then return 35 end
    if ItiMoji == "8c" then return 36 end
    if ItiMoji == "7c" then return 37 end
    if ItiMoji == "6c" then return 38 end
    if ItiMoji == "5c" then return 39 end
    if ItiMoji == "4c" then return 40 end
    if ItiMoji == "3c" then return 41 end
    if ItiMoji == "2c" then return 42 end
    if ItiMoji == "1c" then return 43 end
    if ItiMoji == "9d" then return 46 end
    if ItiMoji == "8d" then return 47 end
    if ItiMoji == "7d" then return 48 end
    if ItiMoji == "6d" then return 49 end
    if ItiMoji == "5d" then return 50 end
    if ItiMoji == "4d" then return 51 end
    if ItiMoji == "3d" then return 52 end
    if ItiMoji == "2d" then return 53 end
    if ItiMoji == "1d" then return 54 end
    if ItiMoji == "9e" then return 57 end
    if ItiMoji == "8e" then return 58 end
    if ItiMoji == "7e" then return 59 end
    if ItiMoji == "6e" then return 60 end
    if ItiMoji == "5e" then return 61 end
    if ItiMoji == "4e" then return 62 end
    if ItiMoji == "3e" then return 63 end
    if ItiMoji == "2e" then return 64 end
    if ItiMoji == "1e" then return 65 end
    if ItiMoji == "9f" then return 68 end
    if ItiMoji == "8f" then return 69 end
    if ItiMoji == "7f" then return 70 end
    if ItiMoji == "6f" then return 71 end
    if ItiMoji == "5f" then return 72 end
    if ItiMoji == "4f" then return 73 end
    if ItiMoji == "3f" then return 74 end
    if ItiMoji == "2f" then return 75 end
    if ItiMoji == "1f" then return 76 end
    if ItiMoji == "9g" then return 79 end
    if ItiMoji == "8g" then return 80 end
    if ItiMoji == "7g" then return 81 end
    if ItiMoji == "6g" then return 82 end
    if ItiMoji == "5g" then return 83 end
    if ItiMoji == "4g" then return 84 end
    if ItiMoji == "3g" then return 85 end
    if ItiMoji == "2g" then return 86 end
    if ItiMoji == "1g" then return 87 end
    if ItiMoji == "9h" then return 90 end
    if ItiMoji == "8h" then return 91 end
    if ItiMoji == "7h" then return 92 end
    if ItiMoji == "6h" then return 93 end
    if ItiMoji == "5h" then return 94 end
    if ItiMoji == "4h" then return 95 end
    if ItiMoji == "3h" then return 96 end
    if ItiMoji == "2h" then return 97 end
    if ItiMoji == "1h" then return 98 end
    if ItiMoji == "9i" then return 101 end
    if ItiMoji == "8i" then return 102 end
    if ItiMoji == "7i" then return 103 end
    if ItiMoji == "6i" then return 104 end
    if ItiMoji == "5i" then return 105 end
    if ItiMoji == "4i" then return 106 end
    if ItiMoji == "3i" then return 107 end
    if ItiMoji == "2i" then return 108 end
    if ItiMoji == "1i" then return 109 end

    if ItiMoji == "P*" then return 0 end
    if ItiMoji == "L*" then return 0 end
    if ItiMoji == "N*" then return 0 end
    if ItiMoji == "S*" then return 0 end
    if ItiMoji == "G*" then return 0 end
    if ItiMoji == "B*" then return 0 end
    if ItiMoji == "R*" then
        return 0

    else
        return -2
    end
end

function Sfen()

    Bunkatu()
    SfenBun = {}
    HaitiGenzai = {unpack(HaitiKara)}

    -- SfenBun[�i��]�́A�u 5+P1gk �v�ȂǁB
    SfenBun[1], SfenBun[2], SfenBun[3], SfenBun[4], SfenBun[5], SfenBun[6], SfenBun[7], SfenBun[8], SfenBun[9] =
        string.match(BunkatuMoji[3],
                     "(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.-)%/(.+)")

    SfenSuuji = 0
    for i = 1, 9 do
        SfenDanMoji = {}
        j = 1
        for n in SfenBun[i]:gmatch("[%w%p]") do
            SfenDanMoji[j] = n
            j = j + 1
        end

        if i == 1 then
            SfenSuuji = 13 -- �z�u�Ԓn13-21�̈�i��
        elseif i == 2 then
            SfenSuuji = 24
        elseif i == 3 then
            SfenSuuji = 35
        elseif i == 4 then
            SfenSuuji = 46
        elseif i == 5 then
            SfenSuuji = 57
        elseif i == 6 then
            SfenSuuji = 68
        elseif i == 7 then
            SfenSuuji = 79
        elseif i == 8 then
            SfenSuuji = 90
        elseif i == 9 then
            SfenSuuji = 101 -- �z�u�Ԓn101-109�̋�i��
        else
            SfenSuuji = 999
            --print("4�F999����ꂽ�Bsfen")
        end -- �G���[�̂Ƃ�

        SfenNari = 0
        for k = 1, 18 do
            if SfenDanMoji[k] == "p" then
                HaitiGenzai[SfenSuuji] = 201 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "l" then
                HaitiGenzai[SfenSuuji] = 202 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "n" then
                HaitiGenzai[SfenSuuji] = 203 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "s" then
                HaitiGenzai[SfenSuuji] = 204 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "g" then
                HaitiGenzai[SfenSuuji] = 205
            elseif SfenDanMoji[k] == "b" then
                HaitiGenzai[SfenSuuji] = 206 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "r" then
                HaitiGenzai[SfenSuuji] = 207 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "k" then
                HaitiGenzai[SfenSuuji] = 208
            elseif SfenDanMoji[k] == "P" then
                HaitiGenzai[SfenSuuji] = 101 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "L" then
                HaitiGenzai[SfenSuuji] = 102 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "N" then
                HaitiGenzai[SfenSuuji] = 103 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "S" then
                HaitiGenzai[SfenSuuji] = 104 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "G" then
                HaitiGenzai[SfenSuuji] = 105
            elseif SfenDanMoji[k] == "B" then
                HaitiGenzai[SfenSuuji] = 106 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "R" then
                HaitiGenzai[SfenSuuji] = 107 + SfenNari
                if SfenNari == 10 then SfenNari = 0 end
            elseif SfenDanMoji[k] == "K" then
                HaitiGenzai[SfenSuuji] = 108
            elseif SfenDanMoji[k] == "+" then
                SfenNari = 10
                SfenSuuji = SfenSuuji - 1
            elseif SfenDanMoji[k] == nil then
            else
                SfenSuuji = SfenSuuji + SfenDanMoji[k] - 1
            end
            SfenSuuji = SfenSuuji + 1
        end

    end

    -- �ȉ��A������̏���
    SfenMoti = {}
    j = 1
    for n in BunkatuMoji[5]:gmatch("[%w%p]") do
        SfenMoti[j] = n
        j = j + 1
    end

    Maisuu = 1
    for k = 1, 18 do

        if SfenMoti[k] == "P" then
            HaitiGenzai[122] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "L" then
            HaitiGenzai[123] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "N" then
            HaitiGenzai[124] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "S" then
            HaitiGenzai[125] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "G" then
            HaitiGenzai[126] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "B" then
            HaitiGenzai[127] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "R" then
            HaitiGenzai[128] = Maisuu
            Maisuu = 1

        elseif SfenMoti[k] == "p" then
            HaitiGenzai[130] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "l" then
            HaitiGenzai[131] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "n" then
            HaitiGenzai[132] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "s" then
            HaitiGenzai[133] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "g" then
            HaitiGenzai[134] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "b" then
            HaitiGenzai[135] = Maisuu
            Maisuu = 1
        elseif SfenMoti[k] == "r" then
            HaitiGenzai[136] = Maisuu
            Maisuu = 1

        elseif SfenMoti[k] == "1" then
            Maisuu = 11
        elseif (SfenMoti[k] == nil or SfenMoti[k] == "-") then
        else
            Maisuu = Maisuu + SfenMoti[k] - 1
        end

    end

end

-- ���@��𐶐�����֐�(����GouhouTeban�F1���/-1�F���AHaiti�z�u�n�A�o�͂���Sasite�n)
-- �Ղ萶���Ղ萶������300������A��B�������ρB
-- HaitiGouhousyu2�Ɉ����̔Ֆʂ��Č����A�ύX���Ă����B
-- �֐����Ăяo������́A�ǂ񂾌��HaitiGouhousyu2���g���B
function Gouhousyu(GouhouTeban, HaitiGouhousyu, SasiteGouhousyu)
    -- Sasite[�w����̌��ԍ�][1:���Ԓn�A2:���̋��A3:��Ԓn�A4:��̋��A5:����+10]
    -- [1]��999�̎��͂����
    -- [1]��200��-200�̎��͑ł�
    kouhosuu = 0
    HaitiGouhousyu2 = {unpack(HaitiGouhousyu)}
    -- SasiteGohosyu��������
    for i = 1, 600 do
        -- Sasite�n�̔z��̍s�̍쐬
        SasiteGouhousyu[i] = {}
        for j = 1, 5 do
            SasiteGouhousyu[i][j] = 0
        end
    end

    -- ���̎�
    for i = 13, 109 do -- �Ԓn13����109�܂ł𒲂ׂĂ���
        if GouhouTeban == 1 then -- ���̎�
            if HaitiGouhousyu2[i] == 101 or HaitiGouhousyu2[i] == 103 or
                HaitiGouhousyu2[i] == 104 then -- ���A�j�A��̂Ƃ�
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            if kouhoti >= 13 and kouhoti <= 43 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ���A�j�A��̌J��Ԃ��I���
            end -- ���A�j�A��A�I���

            if HaitiGouhousyu2[i] == 105 or HaitiGouhousyu2[i] == 108 or
                (HaitiGouhousyu2[i] >= 111 and HaitiGouhousyu2[i] <= 114) then -- ���A���A�����̂Ƃ�
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                        end
                    end
                end -- ���A���A�����̌J��Ԃ��I���
            end -- ���A���A�����I���

            yameru = 0 -- ��߂�t���O������0
            if HaitiGouhousyu2[i] == 102 then -- ���̂Ƃ�
                for j = 1, 8 do -- ���Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            if kouhoti >= 13 and kouhoti <= 43 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ���̌J��Ԃ��I���
            end -- ���A�I���

            yameru = 0 -- ��߂�t���O������0
            if HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] == 117 or
                HaitiGouhousyu2[i] == 106 or HaitiGouhousyu2[i] == 116 then -- ��A���A�p�A�n�̂Ƃ�
                for j = 1, 8 do -- ���������Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 9, 16 do -- ���Ɍ�������9����16�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 17, 24 do -- ���Ɍ�������17����24�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 25, 32 do -- ���Ɍ�������25����32�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���
            end -- ��A�p�̏I���

            if HaitiGouhousyu2[i] == 117 or HaitiGouhousyu2[i] == 116 then -- �����n�̂Ƃ��̎c��
                for j = 33, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                        end
                    end
                end -- ���A�n�̎c��̌J��Ԃ��I���
            end -- ���A�n�̏I���

        end -- ���̎w����A�I���
    end -- for�I���

    -- ���̎������łƂ�
    if GouhouTeban == 1 then -- ���̎�
        if HaitiGouhousyu2[101 + 21] >= 1 then -- ���̂Ƃ�
            hunokazu = 0
            HunoIti = {} -- HunoIti[�Ֆʂ̕��̔ԍ�]=���̔Ԓn
            for i = 1, 9 do
                HunoIti[i] = -999 -- HunoIti[�Ֆʂ̕��̔ԍ�]=�Ԓn
            end
            for i = 13, 109 do -- �Ֆʂɐ��̕��̈ʒu�𒲂ׂ�
                if HaitiGouhousyu2[i] == 101 then
                    hunokazu = hunokazu + 1
                    HunoIti[hunokazu] = i
                end
            end
            HuUteru = {}
            for i = -200, 200 do
                HuUteru[i] = 1 -- HuUteru[�Ԓn13-109]=1�@����ł���OK
            end
            if hunokazu >= 1 then
                for i = 1, 9 do -- i�͔Ֆʂ̕��̐�
                    for j = 0, 10 do -- j�́A���Ă̐�
                        HuUteru[HunoIti[i] + 11 * j] = 0
                        HuUteru[HunoIti[i] - 11 * j] = 0
                    end
                end
            end

            for i = 24, 109 do -- 2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
                if HuUteru[i] == 1 and HaitiGouhousyu2[i] == 0 then -- HuUteru[�Ԓn]��1�Ŕz�u�E���݂�0�Ȃ�A����łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- ���Ԓn�́A���̔ԊO�i200�j
                    SasiteGouhousyu[kouhosuu][2] = 101 -- ���̋��
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- ����ł̂͏I���

        if HaitiGouhousyu2[102 + 21] >= 1 then -- ���̂Ƃ�
            for i = 24, 109 do -- 2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
                if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- ���Ԓn�́A���̔ԊO�i200�j
                    SasiteGouhousyu[kouhosuu][2] = 102 -- ���̋��E��
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- ����ł̂͏I���

        if HaitiGouhousyu2[103 + 21] >= 1 then -- �j�̂Ƃ�
            for i = 35, 109 do -- 3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
                if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- ���Ԓn�́A���̔ԊO�i200�j
                    SasiteGouhousyu[kouhosuu][2] = 103 -- ���̋��E�j
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- �j��ł̂͏I���

        for x = 0, 3 do
            if HaitiGouhousyu2[104 + 21 + x] >= 1 then -- ��A���A�p�A��̂Ƃ�
                for i = 13, 109 do -- 3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
                    if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                        kouhosuu = kouhosuu + 1
                        SasiteGouhousyu[kouhosuu][1] = 200 -- ���Ԓn�́A���̔ԊO�i200�j
                        SasiteGouhousyu[kouhosuu][2] = 104 + x -- ���̋��
                        SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                        SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                        SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                    end
                end
            end
        end -- ��A���A�p�A���ł̂͏I���
    end -- ���̎������ł̏I���

    -- ���̎�
    for i = 13, 109 do -- �Ԓn13-109�𒲂ׂĂ���
        if GouhouTeban == -1 then -- ���̎�
            if HaitiGouhousyu2[i] == 201 or HaitiGouhousyu2[i] == 203 or
                HaitiGouhousyu2[i] == 204 then -- ���A�j�A��̂Ƃ�
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            if kouhoti >= 79 and kouhoti <= 109 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ���A�j�A��̌J��Ԃ��I���
            end -- ���A�j�A��A�I���

            if HaitiGouhousyu2[i] == 205 or HaitiGouhousyu2[i] == 208 or
                (HaitiGouhousyu2[i] >= 211 and HaitiGouhousyu2[i] <= 214) then -- ���A���A�����̂Ƃ�
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                        end
                    end
                end -- ���A���A�����̌J��Ԃ��I���
            end -- ���A���A�����I���

            yameru = 0 -- ��߂�t���O������0
            if HaitiGouhousyu2[i] == 202 then -- ���̂Ƃ�
                for j = 1, 8 do -- ���Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            if kouhoti >= 79 and kouhoti <= 109 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ���̌J��Ԃ��I���
            end -- ���A�I���

            yameru = 0 -- ��߂�t���O������0
            if HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] == 217 or
                HaitiGouhousyu2[i] == 206 or HaitiGouhousyu2[i] == 216 then -- ��A���A�p�A�n�̂Ƃ�
                for j = 1, 8 do -- ���������Ɍ�������1����8�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 9, 16 do -- ���Ɍ�������9����16�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 17, 24 do -- ���Ɍ�������17����24�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���

                yameru = 0 -- ��߂�t���O������0
                for j = 25, 32 do -- ���Ɍ�������25����32�Ԗڂ܂ŁB�r���ŋ����ƃX�g�b�v�Byameru��߂�t���O��1�ɂ���B
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����A��߂�t���O�����ĂȂ��Ƃ��B
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- �����Ƃ��A��߂�t���O�𗧂Ă�
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            -- �򂩊p�́A���ʒu����ʒu������w�n�̂Ƃ��A���遫
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- ����
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                            end
                        end
                    end
                end -- ��A���́��̌J��Ԃ��I���
            end -- ��A�p�̏I���

            if HaitiGouhousyu2[i] == 217 or HaitiGouhousyu2[i] == 216 then -- �����n�̂Ƃ��̎c��
                for j = 33, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[���܂̎��][j]��0�ȊO�œ�����
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti ���n
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- ���Ԓn
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- ���̋��
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- ��Ԓn
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- ��̋��
                            SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                        end
                    end
                end -- ���A�n�̎c��̌J��Ԃ��I���
            end -- ���A�n�̏I���

        end -- ���̎w����A�I���
    end -- for�I���

    -- ���̎������łƂ�
    if GouhouTeban == -1 then -- ���̎�      
        if HaitiGouhousyu2[201 - 71] >= 1 then -- ���̂Ƃ�
            hunokazu = 0
            HunoIti = {} -- HunoIti[�Ֆʂ̕��̔ԍ�]=���̔Ԓn
            for i = 1, 9 do
                HunoIti[i] = -999 -- HunoIti[�Ֆʂ̕��̔ԍ�]=�Ԓn
            end
            for i = 13, 109 do -- �Ֆʂɐ��̕��̈ʒu�𒲂ׂ�
                if HaitiGouhousyu2[i] == 201 then
                    hunokazu = hunokazu + 1
                    HunoIti[hunokazu] = i
                end
            end
            HuUteru = {}
            for i = -200, 200 do
                HuUteru[i] = 1 -- HuUteru[�Ԓn13-109]=1�@����ł���OK
            end
            if hunokazu >= 1 then
                for i = 1, 9 do -- i�͔Ֆʂ̕��̐�
                    for j = 0, 10 do -- j�́A���Ă̐�
                        HuUteru[HunoIti[i] + 11 * j] = 0
                        HuUteru[HunoIti[i] - 11 * j] = 0
                    end
                end
            end

            for i = 13, 98 do -- 2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
                if HuUteru[i] == 1 and HaitiGouhousyu2[i] == 0 then -- HuUteru[�Ԓn]��1�Ŕz�u�E���݂�0�Ȃ�A����łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- ���Ԓn�́A���̔ԊO�i-200�j
                    SasiteGouhousyu[kouhosuu][2] = 201 -- ���̋��
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- ����ł̂͏I���

        if HaitiGouhousyu2[202 - 71] >= 1 then -- ���̂Ƃ�
            for i = 13, 98 do -- 2�i�ڂ���̔Ԓn�𒲂ׂ�i����1�i�ڂ̓_���j
                if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- ���Ԓn�́A���̔ԊO�i-200�j
                    SasiteGouhousyu[kouhosuu][2] = 202 -- ���̋��E��
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- ����ł̂͏I���

        if HaitiGouhousyu2[203 - 71] >= 1 then -- �j�̂Ƃ�
            for i = 13, 87 do -- 3�i�ڂ���̔Ԓn�𒲂ׂ�i�j��1-2�i�ڂ̓_���j
                if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- ���Ԓn�́A���̔ԊO�i-200�j
                    SasiteGouhousyu[kouhosuu][2] = 203 -- ���̋��E�j
                    SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                    SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                    SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                end
            end
        end -- �j��ł̂͏I���

        for x = 0, 3 do
            if HaitiGouhousyu2[204 - 71 + x] >= 1 then -- ��A���A�p�A��̂Ƃ�
                for i = 13, 109 do -- ���ׂĂ̔Ԓn�𒲂ׂ�
                    if HaitiGouhousyu2[i] == 0 then -- �z�u�E���݂�0�Ȃ�A�łĂ�
                        kouhosuu = kouhosuu + 1
                        SasiteGouhousyu[kouhosuu][1] = -200 -- ���Ԓn�́A���̔ԊO�i-200�j
                        SasiteGouhousyu[kouhosuu][2] = 204 + x -- ���̋��
                        SasiteGouhousyu[kouhosuu][3] = i -- ��Ԓn
                        SasiteGouhousyu[kouhosuu][4] = 0 -- ��̋��
                        SasiteGouhousyu[kouhosuu][5] = 0 -- ���炸
                    end
                end
            end
        end -- ��A���A�p�A���ł̂͏I���
    end -- ���̎������ł̏I���

    gouhousyukazu = kouhosuu

    -- 2019-05-03�@���ԍ�1�̎肪���������Ȃ邱�Ƃ��C��
    if gouhousyukazu ~= 0 then
        SasiteGouhousyu[gouhousyukazu + 1][1] = 999 -- �w����z��̍��@�萔+1�ɁA�z��I�����999������B
        --print("5�F999����ꂽ�B", gouhousyukazu + 1)
        -- print("999�����钼�O��gouhousyukazu:",gouhousyukazu)
        -- print_sasite(Sasite)
    end
    -- 2019-05-03�C��
    --   print("���@�萔"..kouhosuu.." / �w����z��̍Ō�̂���-1����+1�܂ł�[1]"..Sasite[gouhousyukazu][1].."/"..Sasite[gouhousyukazu+1][1])
    --  print("KouhoSuu "..kouhosuu)

    -- return 
end

-- �]���֐�
-- ��̑����]���@+������̎��]��
-- ������HaitiGenzai���̋ǖ�
function KyokumenHyouka(HaitiHyouka)
    sentetoku = 0
    gotetoku = 0

    -- ��̑����]��
    for i = 13, 109 do
        if HaitiHyouka[i] == 101 then sentetoku = sentetoku + komakati[1] end
        if HaitiHyouka[i] == 102 then sentetoku = sentetoku + komakati[2] end
        if HaitiHyouka[i] == 103 then sentetoku = sentetoku + komakati[3] end
        if HaitiHyouka[i] == 104 then sentetoku = sentetoku + komakati[4] end
        if HaitiHyouka[i] == 105 then sentetoku = sentetoku + komakati[5] end
        if HaitiHyouka[i] == 106 then sentetoku = sentetoku + komakati[6] end
        if HaitiHyouka[i] == 107 then sentetoku = sentetoku + komakati[7] end
        if HaitiHyouka[i] == 108 then sentetoku = sentetoku + komakati[8] end
        if HaitiHyouka[i] == 111 then sentetoku = sentetoku + komakati[9] end
        if HaitiHyouka[i] == 112 then sentetoku = sentetoku + komakati[9] end
        if HaitiHyouka[i] == 113 then sentetoku = sentetoku + komakati[9] end
        if HaitiHyouka[i] == 114 then sentetoku = sentetoku + komakati[9] end
        if HaitiHyouka[i] == 116 then
            sentetoku = sentetoku + komakati[10]
        end
        if HaitiHyouka[i] == 117 then
            sentetoku = sentetoku + komakati[11]
        end

        if HaitiHyouka[i] == 201 then gotetoku = gotetoku + komakati[12] end
        if HaitiHyouka[i] == 202 then gotetoku = gotetoku + komakati[13] end
        if HaitiHyouka[i] == 203 then gotetoku = gotetoku + komakati[14] end
        if HaitiHyouka[i] == 204 then gotetoku = gotetoku + komakati[15] end
        if HaitiHyouka[i] == 205 then gotetoku = gotetoku + komakati[16] end
        if HaitiHyouka[i] == 206 then gotetoku = gotetoku + komakati[17] end
        if HaitiHyouka[i] == 207 then gotetoku = gotetoku + komakati[18] end
        if HaitiHyouka[i] == 208 then gotetoku = gotetoku + komakati[19] end
        if HaitiHyouka[i] == 211 then gotetoku = gotetoku + komakati[20] end
        if HaitiHyouka[i] == 212 then gotetoku = gotetoku + komakati[20] end
        if HaitiHyouka[i] == 213 then gotetoku = gotetoku + komakati[20] end
        if HaitiHyouka[i] == 214 then gotetoku = gotetoku + komakati[20] end
        if HaitiHyouka[i] == 216 then gotetoku = gotetoku + komakati[21] end
        if HaitiHyouka[i] == 217 then gotetoku = gotetoku + komakati[22] end
    end

    for i = 122, 128 do
        if HaitiHyouka[i] >= 1 then
            sentetoku = sentetoku + motikomakati[i - 121] * HaitiHyouka[i]
        end
    end

    for i = 129, 135 do
        if HaitiHyouka[i] >= 1 then
            gotetoku = gotetoku + motikomakati[i - 121] * HaitiHyouka[i]
        end
    end
    -- ��̑����]���A�����܂�

    -- ������̎��]��
    -- 1������+200
    gyokumamori = 0
    sentemamorikazu = 0
    gotemamorikazu = 0

    for i = 13, 109 do -- ���̋ʒT��
        if HaitiHyouka[i] == 108 then sentegyokuiti = i end
        if HaitiHyouka[i] == 208 then gotegyokuiti = i end
    end

    -- ������̋���T��
    if HaitiHyouka[sentegyokuiti + 10] == 104 or HaitiHyouka[sentegyokuiti + 10] ==
        105 or HaitiHyouka[sentegyokuiti + 10] == 116 or
        (HaitiHyouka[sentegyokuiti + 10] >= 111 and
            HaitiHyouka[sentegyokuiti + 10] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti + 11] == 104 or HaitiHyouka[sentegyokuiti + 11] ==
        105 or HaitiHyouka[sentegyokuiti + 11] == 116 or
        (HaitiHyouka[sentegyokuiti + 11] >= 111 and
            HaitiHyouka[sentegyokuiti + 11] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti + 12] == 104 or HaitiHyouka[sentegyokuiti + 12] ==
        105 or HaitiHyouka[sentegyokuiti + 12] == 116 or
        (HaitiHyouka[sentegyokuiti + 12] >= 111 and
            HaitiHyouka[sentegyokuiti + 12] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti + 1] == 104 or HaitiHyouka[sentegyokuiti + 1] ==
        105 or HaitiHyouka[sentegyokuiti + 1] == 116 or
        (HaitiHyouka[sentegyokuiti + 1] >= 111 and
            HaitiHyouka[sentegyokuiti + 1] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti - 10] == 104 or HaitiHyouka[sentegyokuiti - 10] ==
        105 or HaitiHyouka[sentegyokuiti - 10] == 116 or
        (HaitiHyouka[sentegyokuiti - 10] >= 111 and
            HaitiHyouka[sentegyokuiti - 10] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti - 11] == 104 or HaitiHyouka[sentegyokuiti - 11] ==
        105 or HaitiHyouka[sentegyokuiti - 11] == 116 or
        (HaitiHyouka[sentegyokuiti - 11] >= 111 and
            HaitiHyouka[sentegyokuiti - 11] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti - 12] == 104 or HaitiHyouka[sentegyokuiti - 12] ==
        105 or HaitiHyouka[sentegyokuiti - 12] == 116 or
        (HaitiHyouka[sentegyokuiti - 12] >= 111 and
            HaitiHyouka[sentegyokuiti - 12] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end
    if HaitiHyouka[sentegyokuiti - 1] == 104 or HaitiHyouka[sentegyokuiti - 1] ==
        105 or HaitiHyouka[sentegyokuiti - 1] == 116 or
        (HaitiHyouka[sentegyokuiti - 12] >= 111 and
            HaitiHyouka[sentegyokuiti - 12] <= 114) then
        sentemamorikazu = sentemamorikazu + 1
    end

    if HaitiHyouka[gotegyokuiti + 10] == 204 or HaitiHyouka[gotegyokuiti + 10] ==
        205 or HaitiHyouka[gotegyokuiti + 10] == 216 or
        (HaitiHyouka[gotegyokuiti + 10] >= 211 and
            HaitiHyouka[gotegyokuiti + 10] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti + 11] == 204 or HaitiHyouka[gotegyokuiti + 11] ==
        205 or HaitiHyouka[gotegyokuiti + 11] == 216 or
        (HaitiHyouka[gotegyokuiti + 11] >= 211 and
            HaitiHyouka[gotegyokuiti + 11] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti + 12] == 204 or HaitiHyouka[gotegyokuiti + 12] ==
        205 or HaitiHyouka[gotegyokuiti + 12] == 216 or
        (HaitiHyouka[gotegyokuiti + 12] >= 211 and
            HaitiHyouka[gotegyokuiti + 12] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti + 1] == 204 or HaitiHyouka[gotegyokuiti + 1] ==
        205 or HaitiHyouka[gotegyokuiti + 1] == 216 or
        (HaitiHyouka[gotegyokuiti + 1] >= 211 and HaitiHyouka[gotegyokuiti + 1] <=
            214) then gotemamorikazu = gotemamorikazu + 1 end
    if HaitiHyouka[gotegyokuiti - 10] == 204 or HaitiHyouka[gotegyokuiti - 10] ==
        205 or HaitiHyouka[gotegyokuiti - 10] == 216 or
        (HaitiHyouka[gotegyokuiti - 10] >= 211 and
            HaitiHyouka[gotegyokuiti - 10] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti - 11] == 204 or HaitiHyouka[gotegyokuiti - 11] ==
        205 or HaitiHyouka[gotegyokuiti - 11] == 216 or
        (HaitiHyouka[gotegyokuiti - 11] >= 211 and
            HaitiHyouka[gotegyokuiti - 11] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti - 12] == 204 or HaitiHyouka[gotegyokuiti - 12] ==
        205 or HaitiHyouka[gotegyokuiti - 12] == 216 or
        (HaitiHyouka[gotegyokuiti - 12] >= 211 and
            HaitiHyouka[gotegyokuiti - 12] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end
    if HaitiHyouka[gotegyokuiti - 1] == 204 or HaitiHyouka[gotegyokuiti - 1] ==
        205 or HaitiHyouka[gotegyokuiti - 1] == 216 or
        (HaitiHyouka[gotegyokuiti - 12] >= 211 and
            HaitiHyouka[gotegyokuiti - 12] <= 214) then
        gotemamorikazu = gotemamorikazu + 1
    end

    if sentemamorikazu <= 3 then
        sentemamoriten = sentemamorikazu * 50
    else
        sentemamoriten = 3 * 50
    end
    if gotemamorikazu <= 3 then
        gotemamoriten = gotemamorikazu * 50
    else
        gotemamoriten = 3 * 50
    end

    --[[
  for i=13,109 do --������̓������T���B����̗������l�����邱�Ƃ��������B
    if HaitiHyouka[i]==108 then sentegyokuiti=i end
    if HaitiHyouka[i]==208 then gotegyokuiti=i end
  end
--]]
    -- ������̎��]���A�����܂�

    --[[
function YomiHyouka()
  for x=1,600 do
    HaitiYomi[x]={unpack(HaitiHyouka)}
  end
  
  for i=1,kouhosuu do
    HaitiYomi[i][ Sasite[i][1] ]
  end
--]]

    -- ���]����߂�l�ɓ����
    return sentetoku + gotetoku + sentemamoriten - gotemamoriten
end

-- �w���萶���Ղ�̕\���i���@��Ȃǁj
function HyojiMaturi()
    Gouhousyu(Teban, HaitiGenzai, Sasite)
    print(
        "����͂̍��@��i[�w����ԍ�]�����O�ʒu13109�A�����O�̋�A������̈ʒu�A������̋�A����+10�j")
    for i = 1, 600 do
        if Sasite[i][1] == 999 then break end
        io.write(
            "[" .. i .. "]" .. Sasite[i][1] .. "/" .. Sasite[i][2] .. "/" ..
                Sasite[i][3] .. "/" .. Sasite[i][4] .. "/" .. Sasite[i][5] ..
                " ")
    end
    print ""
    print "������Ƒ҂��Ă�-�I��蕶����"

    -- ���Ԍv���J�n
    kurikaesisuu = 10000

    kaisijikoku = os.clock()

    for i = 1, kurikaesisuu do Gouhousyu(Teban, HaitiGenzai, Sasite) end

    syorijikan = os.clock() - kaisijikoku
    print("��������(s):" .. syorijikan)
    print("�J��Ԃ���:" .. kurikaesisuu)
    print("�b��(nps):" .. math.floor(kurikaesisuu / syorijikan + 0.5)) -- �������l�̌ܓ�

    -- ���Ԍv���I��

end

-- ���݂̔Ֆ�HaitiGenzai��1����ǂފ֐�
-- �����̔ԍ�����ASasiteItiji�̔ԍ��̎w�����HaitiYomi�ɓ����
function Yomu(index) -- ���ԍ�
    HaitiYomi = {unpack(HaitiGenzai)} -- �z�u�ǂ�
    -- �e�[�u�����R�s�[����Ƃ�unpack���g��Ȃ��ƘA������B{�@}��Y�ꂸ�ɁB
    if SasiteItiji[index][1] ~= 999 then
        if SasiteItiji[index][1] ~= 200 or SasiteItiji[index][1] ~= -200 then -- �ł��Ȃ��Ƃ�
            HaitiYomi[SasiteItiji[index][1]] = 0 -- ���Ԓn�ɂ͋�ł���0����
            HaitiYomi[SasiteItiji[index][3]] = SasiteItiji[index][2] -- ��Ԓn�ɂ͌��Ԓn�̋�����
            if SasiteItiji[index][5] == 10 then -- ���鏈��
                HaitiYomi[SasiteItiji[index][3]] = HaitiYomi[SasiteItiji[index][3]] + 10
            end
            if SasiteItiji[index][4] ~= 0 then -- ����Ƃ�Ƃ�
                if SasiteItiji[index][4] <= 200 then -- ���̋���Ƃ�Ƃ�
                    HaitiYomi[SasiteItiji[index][4] + 90 - 71] =
                        HaitiYomi[SasiteItiji[index][4] + 90 - 71] + 1
                end
                if SasiteItiji[index][4] >= 200 then -- ���̋���Ƃ�Ƃ�
                    HaitiYomi[SasiteItiji[index][4] - 110 + 21] =
                        HaitiYomi[SasiteItiji[index][4] - 110 + 21] + 1
                end
            end
        end
    end

end

-- ���݂̔Ֆ�HaitiGenzai��2����ǂފ֐�
-- 1���̔Ֆ�HaitiYomi��1����ǂ�
-- SasiteYomi[����index]��index�̎w�����HaitiYomi2�ɓ����
function Yomu2(index)
    HaitiYomi2 = {unpack(HaitiYomi)} -- �z�u�ǂ�
    -- �e�[�u�����R�s�[����Ƃ�unpack���g��Ȃ��ƘA������B{�@}��Y�ꂸ�ɁB
    if SasiteYomi[index][1] ~= 999 then
        if SasiteYomi[index][1] ~= 200 or SasiteYomi[index][1] ~= -200 then -- �ł��Ȃ��Ƃ�
            HaitiYomi2[SasiteYomi[index][1]] = 0 -- ���Ԓn�ɂ͋�ł���0����
            HaitiYomi2[SasiteYomi[index][3]] = SasiteYomi[index][2] -- ��Ԓn�ɂ͌��Ԓn�̋�����
            if SasiteYomi[index][5] == 10 then -- ���鏈��
                HaitiYomi2[SasiteYomi[index][3]] =
                    HaitiYomi2[SasiteYomi[index][3]] + 10
            end
            if SasiteYomi[index][4] ~= 0 then -- ����Ƃ�Ƃ�
                if SasiteYomi[index][4] <= 200 then -- ���̋���Ƃ�Ƃ�
                    HaitiYomi2[SasiteYomi[index][4] + 90 - 71] =
                        HaitiYomi2[SasiteYomi[index][4] + 90 - 71] + 1
                end
                if SasiteYomi[index][4] >= 200 then -- ���̋���Ƃ�Ƃ�
                    HaitiYomi2[SasiteYomi[index][4] - 110 + 21] =
                        HaitiYomi2[SasiteYomi[index][4] - 110 + 21] + 1
                end
            end
        end
    end

end

-- ��������BADD:3���ǂ݃~�j�}�b�N�X�@�@2020-11-21
-- �e�[�u����3�����B3���܂ŁB
-- �ő升�@��ǖʁi��Ԏw���Ă̑����ǖʁj��593�ʂ�
-- 1���̕]���l�̒��ł̍ő�l�i3���̓ǂ݂̍őP��j
-- print( "1te,max: ",saizen3["index"], saizen3["hyouka"] )

-- �e�[�u�����̍ő�l�����߂�֐�
-- max�i�e�[�u�����j
-- �߂�l�́Akey��index�l�Avalue�͍ő�l
function max(table_name)
    if #table_name == 0 then return nil, nil end
    local key, value = 1, table_name[1]
    for i = 2, #table_name do
        if value < table_name[i] then key, value = i, table_name[i] end
    end
    return key, value
end

-- �e�[�u�����̍ŏ��l�����߂�֐�
-- min�i�e�[�u�����j
-- �߂�l�́Akey��index�l�Avalue�͍ŏ��l
function min(table_name)
    if #table_name == 0 then return nil, nil end
    local key, value = 1, table_name[1]
    for i = 2, #table_name do
        if value > table_name[i] then key, value = i, table_name[i] end
    end
    return key, value
end

-- �ǖʐ� max593�B�f�t�H���g�F150�iluvi��5�b�j
kyokumen_suu = 10

-- 3���̕]���l������e�[�u��
-- �s��̐���
hyouka_3tesaki = {}
-- 3���܂ł̎w����index������e�[�u��
-- (1���[3]2���[4]3���[5]�̏ꍇ�A003004005)
-- �s��̐���
sasite_3tesaki = {}
-- 3���̕]���l�Ǝw����index������
-- 1���i�����j
for i = 1, kyokumen_suu do
    -- 1�s�ڂ̍쐬
    hyouka_3tesaki[i] = {}
    sasite_3tesaki[i] = {}
    -- 2���i����j
    for j = 1, kyokumen_suu do
        -- 2�s�ڂ̍쐬
        hyouka_3tesaki[i][j] = {}
        sasite_3tesaki[i][j] = {}
        -- 3���i�����j
        for k = 1, kyokumen_suu do
            -- �u-10^4/2�v����u10^4/2�v�܂ł̗���������
            hyouka_3tesaki[i][j][k] = math.random(1, 10 ^ 4) - 10 ^ 4 / 2
            sasite_3tesaki[i][j][k] = string.format("%03d%03d%03d", i, j, k)
        end
    end
end

-- 2���]���l������e�[�u��
-- (3���index�]���l)
-- �s��̐���
hyouka_2tesaki = {}
-- 2���܂ł̎w����ɁA3���܂ł�index������e�[�u��
-- (1���[3]2���[4]�ŁA3����max��index��5�̏ꍇ�A003004005)
-- �s��̐���
sasite_2tesaki = {}
-- 2���̕]���l�Ǝw����index������B
-- 3���̕]���l��max�łӂ邢�ɂ�����B
-- 1���i�����j
for i = 1, kyokumen_suu do
    -- 1�s�ڂ̍쐬
    hyouka_2tesaki[i] = {}
    sasite_2tesaki[i] = {}
    -- 2���i����j
    for j = 1, kyokumen_suu do
        hyouka_2tesaki[i][j] = {}
        sasite_2tesaki[i][j] = {}
        -- 3���̕]���l��max��2���ɓ����B
        -- hyouka_2tesaki�ɂ͕]���l�݂̂�����B
        index3, value3 = max(hyouka_3tesaki[i][j])
        hyouka_2tesaki[i][j] = value3
        -- sasite_2tesaki�ɂ�sasite_3tesaki[x][y][z]������
        -- ��jsasite_3tesaki[1][2][3]�̏ꍇ
        -- �@�@001002003
        -- sasite_2tesaki[i][j] = string.format("%03d%03d%03d",i,j,index3)
        sasite_2tesaki[i][j] = sasite_3tesaki[i][j][index3]
    end
end

-- 1���]���l������e�[�u��
-- (3���index�]���l)
-- �s��̐���
hyouka_1tesaki = {}
-- 1���܂ł̎w����ɁA3���܂ł�index������e�[�u��
-- (1���[3]�ŁA3����max��index��5�A2����min��index��4�̏ꍇ�A003004005)
-- �s��̐���
sasite_1tesaki = {}
-- 1���̕]���l�Ǝw����index������B
-- 2���̕]���l��min�łӂ邢�ɂ�����B
-- 1���i�����j
for i = 1, kyokumen_suu do
    -- 1�s�ڂ̍쐬
    hyouka_1tesaki[i] = {}
    sasite_1tesaki[i] = {}
    -- 2���̕]���l��min��1���ɓ����B
    -- hyouka_1tesaki�ɂ͕]���l�݂̂�����B
    index2, value2 = min(hyouka_2tesaki[i])
    hyouka_1tesaki[i] = value2
    -- sasite_1tesaki�ɂ�sasite_3tesaki[x][y][z]������
    -- ��jsasite_3tesaki[1][2][3]�̏ꍇ
    -- �@�@001002003
    sasite_1tesaki[i] = sasite_2tesaki[i][index2]
end

-- 1���̕]���l�̒��ł̍ő�l
index1, value1 = max(hyouka_1tesaki)
-- 3���̓ǂ݂ł̍őP��i�]���l�A���index�j
saizen3 = {}
saizen3["hyouka"] = value1
saizen3["index"] = sasite_1tesaki[index1]

-- �����܂ŁBADD:3���ǂ݃~�j�}�b�N�X�@�@2020-11-21

function main() end

-- ��������
print("����m�F����ꍇ�́ua�v����͂��Ă�������")
TourokuMati() -- USI�G���W���o�^
BanmenSyokika() -- �Ֆʂ̏�����
StaPosHaiti() -- HaitiGenzai��StartPos�z�u�ɂ���
UgokeruTe() -- ����������������֐�
NyuryokuMati() -- ����������̃R�}���h�҂��̊֐�

print("end")
