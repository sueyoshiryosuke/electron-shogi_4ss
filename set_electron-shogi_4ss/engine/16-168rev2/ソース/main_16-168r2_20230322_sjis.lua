-- 170515 wcsc27 修正版 クジラちゃん向け。評価値やpv一手先がきちんと表示されるように調整できた。
-- 170524 合法手生成（自殺手を含む）の修正。指し手生成祭りの表示。
-- 170524 指し手生成速度、合法手生成関数に指し手配列の生成を入れていたとき、
-- 　　　　　　インタプリンタで500nps。luviで1300nps。
-- 170524 指し手生成速度、合法手生成関数から指し手配列の生成を出したとき、
-- 　　　　　　インタプリンタで3000nps。luviで7500nps。
-- 170524 指し手生成速度、指し手配列の最後に終わりの数字999を入れたとき、
-- 　　　　　　インタプリンタで3300nps。luviで8000nps。
-- 王手放置だと、落ちるので、投了するようにする必要あり。→0601済。
-- 170529 配置の持ち駒に、王を追加したので、要調整→0530済。
-- 170601 たまに原因不明で落ちる？
-- 190503 イリーガルムーブがでるミスを修正
-- 20201121 3手先読みミニマックス法を搭載中。←2手先までに変更。20211201。
-- 20201121 b={unpack(a)}のように1次テーブルの
--  浅いコピーを使って中身を整え直す
-- 20230322 sfenでの挙動を修正。ElectronShogi用にUTF8版も用意。
--  　　　　Intel Core i7-10750H、luviで5900nps。
function hajime() end

-- グローバル変数
-- 配列はLuaでは「テーブル」に含む
--[[盤面の配置の空っぽのテーブル。
盤面の番地は1から121。壁には-1。
122から137まで持ち駒の枚数。
先手
122 歩 ←101との差が+21
123 香
124 桂
125 銀
126 金
127 角
128 飛
129 王
後手
130 歩 ←201との差が-71
131 香
132 桂
133 銀
134 金
135 角
136 飛
137 玉

/*
将棋盤とコマンドの変換表
 壁| ９, ８, ７, ６, ５, ４, ３, ２, １| 壁|
---|-----------------------------------|---|
  1|  2,  3,  4,  5,  6,  7,  8,  9, 10| 11|壁
---|-----------------------------------|---|
 12| 13, 14, 15, 16, 17, 18, 19, 20, 21| 22|一
   | 9a, 8a, 7a, 6a, 5a, 4a, 3a, 2a, 1a|   |a↑
 23| 24, 25, 26, 27, 28, 29, 30, 31, 32| 33|二
   | 9b, 8b, 7b, 6b, 5b, 4b, 3b, 2b, 1b|   |b↑
 34| 35, 36, 37, 38, 39, 40, 41, 42, 43| 44|三
   | 9c, 8c, 7c, 6c, 5c, 4c, 3c, 2c, 1c|   |c↑
 45| 46, 47, 48, 49, 50, 51, 52, 53, 54| 55|四
   | 9d, 8d, 7d, 6d, 5d, 4d, 3d, 2d, 1d|   |d↑
 56| 57, 58, 59, 60, 61, 62, 63, 64, 65| 66|五
   | 9e, 8e, 7e, 6e, 5e, 4e, 3e, 2e, 1e|   |e↑
 67| 68, 69, 70, 71, 72, 73, 74, 75, 76| 77|六
   | 9f, 8f, 7f, 6f, 5f, 4f, 3f, 2f, 1f|   |f↑
 78| 79, 80, 81, 82, 83, 84, 85, 86, 87| 88|七
   | 9g, 8g, 7g, 6g, 5g, 4g, 3g, 2g, 1g|   |g↑
 89| 90, 91, 92, 93, 94, 95, 96, 97, 98| 99|八
   | 9h, 8h, 7h, 6h, 5h, 4h, 3h, 2h, 1h|   |h↑
100|101,102,103,104,105,106,107,108,109|110|九
   | 9i, 8i, 7i, 6i, 5i, 4i, 3i, 2i, 1i|   |i↑
---|-----------------------------------|---|
111|112,113,114,115,116,117,118,119,120|121|壁

壁には-1、空っぽは0です。
]]

HaitiKara = {
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1,
    -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0,
    0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0,
    0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
}
-- ↑歩,香,桂,銀,金,角,飛,王

HaitiGenzai = {} -- 現在の盤面の配置テーブル。
HaitiYomi = {} -- 1手先の読みの盤面の配置テーブル。
HaitiYomi2 = {} -- 2手先の読みの盤面の配置テーブル。
HaitiItiji = {} -- 現在の盤面を一時保持する配置テーブル。
-- startpos盤面の初期配置のテーブル。
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

HaitiHyouji = {} -- 局面表示するとき用の文字列の配列

-- Sasite[指し手の候補数][1:元番地、2:元の駒種、3:先番地、4:先の駒種、5:成り+10]
-- 1:999なら指し手候補は終わり。200なら先手で打つ、-200なら後手で打つ。
Sasite = {} -- 指し手を入れる配列を生成
SasiteItiji = {} -- 一時的に指し手を入れる配列を生成
SasiteGouhousyu = {} -- Gouhousyu関数用の指し手を入れる配列を生成
SasiteYomi = {} -- 先読み用の指し手を入れる配列を生成
for i = 1, 600 do
    -- Sasite系の配列の行の作成
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
} -- 持ち駒の価値
-- motikomakati={150,250,350,550,650,850,950, -150,-250,-350,-550,-650,-850,-950}  --持ち駒の価値
komakati = {
    75, 175, 275, 475, 575, 775, 875, 100000, 575, 1175, 1275, -75, -175, -275,
    -475, -575, -775, -875, -100000, -575, -1175, -1275
} -- 盤上の駒の価値
-- komakati =   {100,200,300,500,600,800,900,10000,600,1200,1300, -100,-200,-300,-500,-600,-800,-900,-10000,-600,-1200,-1300} --盤上の駒の価値
--      先手  1歩、2香、3桂、4銀、5金、6角、7飛、8王(1万)、9成金、10馬、11竜
--      後手  12歩、13香、14桂、15銀、16金、17角、18飛、19王(1万)、20成金、21馬、22竜
-- 先手1枚歩を取る、後手歩を1枚取られる＝先手1歩得＝+200

sentetoku = 0
gotetoku = 0
sentemamorikazu = 0
gotemamorikazu = 0
sentemamoriten = 0
gotemamoriten = 0
saigonoiti = 0

-- ここまでグローバル変数

-- Sasiteを表示する関数
-- ADD 2020-11-21
function print_sasite(Sasite)
    -- Sasiteを表示する
    print("指し手", "候補数:", kouhosuu)
    for i = 1, 600 do
        if Sasite[i][1] == 999 then break end
        print(i .. ":", Sasite[i][1], Sasite[i][2], Sasite[i][3], Sasite[i][4],
              Sasite[i][5])
    end
    print("")
end

-- 数字文字列15桁を3桁ずつ5つに分割し、各文字列を数字化する関数。
-- 戻り値は、テーブル。
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

-- 数字文字列15桁→文字変換の関数
-- 引数の例「018105019206010」
-- ↑指し手の候補を、各要素3桁ずつ1つの文字列（数字）にして格納している。
-- 例）　18　105　19　206　0
-- 　→　1：動く前の位置、2：駒の種類、3：動く先の位置、4：動く先にある現在の駒の種類、5：成る10
-- 戻り値の例「4a3a+」
-- 文頭2文字が動かす駒の位置、次の2文字が動かす先の位置、5文字目の+は成る
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

-- 局面を表示する関数
function hyouji()
    for i = 1, 121 do
        if HaitiGenzai[i] == 101 then
            HaitiHyouji[i] = "歩 "
        elseif HaitiGenzai[i] == 102 then
            HaitiHyouji[i] = "香 "
        elseif HaitiGenzai[i] == 103 then
            HaitiHyouji[i] = "桂 "
        elseif HaitiGenzai[i] == 104 then
            HaitiHyouji[i] = "銀 "
        elseif HaitiGenzai[i] == 105 then
            HaitiHyouji[i] = "金 "
        elseif HaitiGenzai[i] == 106 then
            HaitiHyouji[i] = "角 "
        elseif HaitiGenzai[i] == 107 then
            HaitiHyouji[i] = "飛 "
        elseif HaitiGenzai[i] == 108 then
            HaitiHyouji[i] = "王 "
        elseif HaitiGenzai[i] == 111 then
            HaitiHyouji[i] = "と "
        elseif HaitiGenzai[i] == 112 then
            HaitiHyouji[i] = "杏 "
        elseif HaitiGenzai[i] == 113 then
            HaitiHyouji[i] = "成 " -- 成り桂
        elseif HaitiGenzai[i] == 114 then
            HaitiHyouji[i] = "全 "
        elseif HaitiGenzai[i] == 116 then
            HaitiHyouji[i] = "馬 "
        elseif HaitiGenzai[i] == 117 then
            HaitiHyouji[i] = "竜 "

        elseif HaitiGenzai[i] == 201 then
            HaitiHyouji[i] = "歩v"
        elseif HaitiGenzai[i] == 202 then
            HaitiHyouji[i] = "香v"
        elseif HaitiGenzai[i] == 203 then
            HaitiHyouji[i] = "桂v"
        elseif HaitiGenzai[i] == 204 then
            HaitiHyouji[i] = "銀v"
        elseif HaitiGenzai[i] == 205 then
            HaitiHyouji[i] = "金v"
        elseif HaitiGenzai[i] == 206 then
            HaitiHyouji[i] = "角v"
        elseif HaitiGenzai[i] == 207 then
            HaitiHyouji[i] = "飛v"
        elseif HaitiGenzai[i] == 208 then
            HaitiHyouji[i] = "玉v"
        elseif HaitiGenzai[i] == 211 then
            HaitiHyouji[i] = "とv"
        elseif HaitiGenzai[i] == 212 then
            HaitiHyouji[i] = "杏v"
        elseif HaitiGenzai[i] == 213 then
            HaitiHyouji[i] = "成v" -- 桂馬の成駒（漢字「桂のきへんなし」を使うと文字化けする）
        elseif HaitiGenzai[i] == 214 then
            HaitiHyouji[i] = "全v"
        elseif HaitiGenzai[i] == 216 then
            HaitiHyouji[i] = "馬v"
        elseif HaitiGenzai[i] == 217 then
            HaitiHyouji[i] = "竜v"

        elseif HaitiGenzai[i] == -1 then
            HaitiHyouji[i] = "// "
        elseif HaitiGenzai[i] == 0 then
            HaitiHyouji[i] = "□ "
        else
            HaitiHyouji[i] = "0"
        end
        io.write(HaitiHyouji[i] .. ",") -- 改行なし出力
        if i % 11 == 0 then print("") end
    end
    print("")
    print("先手の持ち駒：歩" .. HaitiGenzai[122] .. " 香" ..
              HaitiGenzai[123] .. " 桂" .. HaitiGenzai[124] .. " 銀" ..
              HaitiGenzai[125] .. " 金" .. HaitiGenzai[126] .. " 角" ..
              HaitiGenzai[127] .. " 飛" .. HaitiGenzai[128])
    print("後手の持ち駒：歩" .. HaitiGenzai[130] .. " 香" ..
              HaitiGenzai[131] .. " 桂" .. HaitiGenzai[132] .. " 銀" ..
              HaitiGenzai[133] .. " 金" .. HaitiGenzai[134] .. " 角" ..
              HaitiGenzai[135] .. " 飛" .. HaitiGenzai[136])
    -- 次の合法手の表示は未完
    print("")
    print("いろはの手番（先手1、後手-1）： " .. Teban) -- sjisのとき「十\六式いろはの手番：」 
    print("今までの手数： " .. TeSuu)
end


-- USIエンジン登録の関数
function TourokuMati()
    while true do
        uketori = io.read()

        io.stdout:setvbuf("no") -- 出力をバッファリングしない設定。

        print("[" .. uketori .. "]")

        -- usiエンジン登録
        if uketori == "usi" then
            print("id name 16-168rev2-sjis_20230322")
            -- print関数は、最後に改行が付く
            print("id author R.Sueyoshi")
            print("usiok")
        end

        -- 終了コマンド
        if uketori == "quit" then break end

        -- 対局準備
        if uketori == "isready" then print("readyok") end

        if uketori == "usinewgame" or uketori == "a" then
            -- 「a」と入力しても「usinewgame」も同じ扱い。コマンドライン用。
            print(
                "テスト局面で動作確認する場合は、いろは先手「tb」、いろは後手「tw」を入力してください")
            print("指し手生成速度を確認する場合は「maturi」を入力してください")
            break
        end

    end

end

-- 現在の盤面に空っぽの盤面を代入する関数
--[[
将棋盤とコマンドの変換表
 壁| ９, ８, ７, ６, ５, ４, ３, ２, １| 壁|
---|-----------------------------------|---|
  1|  2,  3,  4,  5,  6,  7,  8,  9, 10| 11|壁
---|-----------------------------------|---|
 12| 13, 14, 15, 16, 17, 18, 19, 20, 21| 22|一
   | 9a, 8a, 7a, 6a, 5a, 4a, 3a, 2a, 1a|   |a↑
 23| 24, 25, 26, 27, 28, 29, 30, 31, 32| 33|二
   | 9b, 8b, 7b, 6b, 5b, 4b, 3b, 2b, 1b|   |b↑
 34| 35, 36, 37, 38, 39, 40, 41, 42, 43| 44|三
   | 9c, 8c, 7c, 6c, 5c, 4c, 3c, 2c, 1c|   |c↑
 45| 46, 47, 48, 49, 50, 51, 52, 53, 54| 55|四
   | 9d, 8d, 7d, 6d, 5d, 4d, 3d, 2d, 1d|   |d↑
 56| 57, 58, 59, 60, 61, 62, 63, 64, 65| 66|五
   | 9e, 8e, 7e, 6e, 5e, 4e, 3e, 2e, 1e|   |e↑
 67| 68, 69, 70, 71, 72, 73, 74, 75, 76| 77|六
   | 9f, 8f, 7f, 6f, 5f, 4f, 3f, 2f, 1f|   |f↑
 78| 79, 80, 81, 82, 83, 84, 85, 86, 87| 88|七
   | 9g, 8g, 7g, 6g, 5g, 4g, 3g, 2g, 1g|   |g↑
 89| 90, 91, 92, 93, 94, 95, 96, 97, 98| 99|八
   | 9h, 8h, 7h, 6h, 5h, 4h, 3h, 2h, 1h|   |h↑
100|101,102,103,104,105,106,107,108,109|110|九
   | 9i, 8i, 7i, 6i, 5i, 4i, 3i, 2i, 1i|   |i↑
---|-----------------------------------|---|
111|112,113,114,115,116,117,118,119,120|121|壁

壁には-1、盤上は0を代入する
]]
function BanmenSyokika()
    HaitiGenzai = {unpack(HaitiKara)}
    -- テーブルをコピーするときunpackを使わないと連動する。{　}を忘れずに。
end

-- 現在の盤面にStartPosの配置を代入する関数
function StaPosHaiti() HaitiGenzai = {unpack(HaitiStaPos)} end

-- 動ける手を準備する関数
function UgokeruTe()
    --[[
使う方向
-24,-23,-22,-21,-20
-13,-12,-11,-10, -9
 -2, -1,[0],  1,  2
  9, 10, 11, 12, 13
 20, 21, 22, 23, 24
--]]

    ugokeru = {} -- 動ける2次元テーブルの生成
    for i = 101, 217 do
        ugokeru[i] = {} -- 行の作成
        for j = 1, 36 do
            ugokeru[i][j] = 0 -- とりあえず0を代入
        end
    end

    ugokeru[101][1] = -11 -- 先手の歩の動けるところ
    -- 先手の香の動けるところ
    for ugoki = 1, 8 do ugokeru[102][ugoki] = -11 * ugoki end
    ugokeru[103][1] = -23 -- 先手の桂の動けるところ
    ugokeru[103][2] = -21 -- 先手の桂の動けるところ
    ugokeru[104][1] = -12 -- 先手の銀の動けるところ
    ugokeru[104][2] = -11 -- 先手の銀の動けるところ
    ugokeru[104][3] = -10 -- 先手の銀の動けるところ
    ugokeru[104][4] = 10 -- 先手の銀の動けるところ
    ugokeru[104][5] = 12 -- 先手の銀の動けるところ
    ugokeru[105][1] = -10 -- 先手の金の動けるところ
    ugokeru[105][2] = -12 -- 先手の金の動けるところ
    ugokeru[105][3] = -11 -- 先手の金の動けるところ
    ugokeru[105][4] = -1 -- 先手の金の動けるところ
    ugokeru[105][5] = 1 -- 先手の金の動けるところ
    ugokeru[105][6] = 11 -- 先手の金の動けるところ
    -- 先手の角の動けるところ
    for ugoki = 1, 8 do
        ugokeru[106][ugoki] = -12 * ugoki
        ugokeru[106][ugoki + 8] = 12 * ugoki
        ugokeru[106][ugoki + 16] = -10 * ugoki
        ugokeru[106][ugoki + 24] = 10 * ugoki
    end
    -- 先手の飛の動けるところ
    for ugoki = 1, 8 do
        ugokeru[107][ugoki] = -11 * ugoki
        ugokeru[107][ugoki + 8] = 11 * ugoki
        ugokeru[107][ugoki + 16] = -1 * ugoki
        ugokeru[107][ugoki + 24] = 1 * ugoki
    end
    ugokeru[108][1] = -12 -- 先手の王の動けるところ
    ugokeru[108][2] = -11 -- 先手の王の動けるところ
    ugokeru[108][3] = -10 -- 先手の王の動けるところ
    ugokeru[108][4] = -1 -- 先手の王の動けるところ
    ugokeru[108][5] = 1 -- 先手の王の動けるところ
    ugokeru[108][6] = 10 -- 先手の王の動けるところ
    ugokeru[108][7] = 11 -- 先手の王の動けるところ
    ugokeru[108][8] = 12 -- 先手の王の動けるところ

    ugokeru[111][1] = -10 -- 先手のとの動けるところ
    ugokeru[111][2] = -12 -- 先手のとの動けるところ
    ugokeru[111][3] = -11 -- 先手のとの動けるところ
    ugokeru[111][4] = -1 -- 先手のとの動けるところ
    ugokeru[111][5] = 1 -- 先手のとの動けるところ
    ugokeru[111][6] = 11 -- 先手のとの動けるところ
    ugokeru[112][1] = -10 -- 先手の杏の動けるところ
    ugokeru[112][2] = -12 -- 先手の杏の動けるところ
    ugokeru[112][3] = -11 -- 先手の杏の動けるところ
    ugokeru[112][4] = -1 -- 先手の杏の動けるところ
    ugokeru[112][5] = 1 -- 先手の杏の動けるところ
    ugokeru[112][6] = 11 -- 先手の杏の動けるところ
    ugokeru[113][1] = -10 -- 先手の圭の動けるところ
    ugokeru[113][2] = -12 -- 先手の圭の動けるところ
    ugokeru[113][3] = -11 -- 先手の圭の動けるところ
    ugokeru[113][4] = -1 -- 先手の圭の動けるところ
    ugokeru[113][5] = 1 -- 先手の圭の動けるところ
    ugokeru[113][6] = 11 -- 先手の圭の動けるところ
    ugokeru[114][1] = -10 -- 先手の全の動けるところ
    ugokeru[114][2] = -12 -- 先手の全の動けるところ
    ugokeru[114][3] = -11 -- 先手の全の動けるところ
    ugokeru[114][4] = -1 -- 先手の全の動けるところ
    ugokeru[114][5] = 1 -- 先手の全の動けるところ
    ugokeru[114][6] = 11 -- 先手の全の動けるところ
    -- 先手の馬の動けるところ
    for ugoki = 1, 8 do
        ugokeru[116][ugoki] = -12 * ugoki
        ugokeru[116][ugoki + 8] = 12 * ugoki
        ugokeru[116][ugoki + 16] = -10 * ugoki
        ugokeru[116][ugoki + 24] = 10 * ugoki
    end
    ugokeru[116][33] = -11 -- 先手の馬の動けるところ
    ugokeru[116][34] = -1 -- 先手の馬の動けるところ
    ugokeru[116][35] = 1 -- 先手の馬の動けるところ
    ugokeru[116][36] = 11 -- 先手の馬の動けるところ
    -- 先手の竜の動けるところ
    for ugoki = 1, 8 do
        ugokeru[117][ugoki] = -11 * ugoki
        ugokeru[117][ugoki + 8] = 11 * ugoki
        ugokeru[117][ugoki + 16] = -1 * ugoki
        ugokeru[117][ugoki + 24] = 1 * ugoki
    end
    ugokeru[117][33] = -12 -- 先手の竜の動けるところ
    ugokeru[117][34] = -10 -- 先手の竜の動けるところ
    ugokeru[117][35] = 10 -- 先手の竜の動けるところ
    ugokeru[117][36] = 12 -- 先手の竜の動けるところ

    ugokeru[201][1] = 11 -- 後手の歩の動けるところ
    -- 後手の香の動けるところ
    for ugoki = 1, 8 do ugokeru[202][ugoki] = 11 * ugoki end
    ugokeru[203][1] = 21 -- 後手の桂の動けるところ
    ugokeru[203][2] = 23 -- 後手の桂の動けるところ
    ugokeru[204][1] = -12 -- 後手の銀の動けるところ
    ugokeru[204][2] = -10 -- 後手の銀の動けるところ
    ugokeru[204][3] = 10 -- 後手の銀の動けるところ
    ugokeru[204][4] = 11 -- 後手の銀の動けるところ
    ugokeru[204][5] = 12 -- 後手の銀の動けるところ
    ugokeru[205][1] = -11 -- 後手の金の動けるところ
    ugokeru[205][2] = -1 -- 後手の金の動けるところ
    ugokeru[205][3] = 1 -- 後手の金の動けるところ
    ugokeru[205][4] = 10 -- 後手の金の動けるところ
    ugokeru[205][5] = 11 -- 後手の金の動けるところ
    ugokeru[205][6] = 12 -- 後手の金の動けるところ
    -- 後手の角の動けるところ
    for ugoki = 1, 8 do
        ugokeru[206][ugoki] = -12 * ugoki
        ugokeru[206][ugoki + 8] = 12 * ugoki
        ugokeru[206][ugoki + 16] = -10 * ugoki
        ugokeru[206][ugoki + 24] = 10 * ugoki
    end
    -- 後手の飛の動けるところ
    for ugoki = 1, 8 do
        ugokeru[207][ugoki] = -11 * ugoki
        ugokeru[207][ugoki + 8] = 11 * ugoki
        ugokeru[207][ugoki + 16] = -1 * ugoki
        ugokeru[207][ugoki + 24] = 1 * ugoki
    end
    ugokeru[208][1] = -12 -- 後手の王の動けるところ
    ugokeru[208][2] = -11 -- 後手の王の動けるところ
    ugokeru[208][3] = -10 -- 後手の王の動けるところ
    ugokeru[208][4] = -1 -- 後手の王の動けるところ
    ugokeru[208][5] = 1 -- 後手の王の動けるところ
    ugokeru[208][6] = 10 -- 後手の王の動けるところ
    ugokeru[208][7] = 11 -- 後手の王の動けるところ
    ugokeru[208][8] = 12 -- 後手の王の動けるところ
    ugokeru[211][1] = -11 -- 後手のとの動けるところ
    ugokeru[211][2] = -1 -- 後手のとの動けるところ
    ugokeru[211][3] = 1 -- 後手のとの動けるところ
    ugokeru[211][4] = 10 -- 後手のとの動けるところ
    ugokeru[211][5] = 11 -- 後手のとの動けるところ
    ugokeru[211][6] = 12 -- 後手のとの動けるところ
    ugokeru[212][1] = -11 -- 後手の杏の動けるところ
    ugokeru[212][2] = -1 -- 後手の杏の動けるところ
    ugokeru[212][3] = 1 -- 後手の杏の動けるところ
    ugokeru[212][4] = 10 -- 後手の杏の動けるところ
    ugokeru[212][5] = 11 -- 後手の杏の動けるところ
    ugokeru[212][6] = 12 -- 後手の杏の動けるところ
    ugokeru[213][1] = -11 -- 後手の圭の動けるところ
    ugokeru[213][2] = -1 -- 後手の圭の動けるところ
    ugokeru[213][3] = 1 -- 後手の圭の動けるところ
    ugokeru[213][4] = 10 -- 後手の圭の動けるところ
    ugokeru[213][5] = 11 -- 後手の圭の動けるところ
    ugokeru[213][6] = 12 -- 後手の圭の動けるところ
    ugokeru[214][1] = -11 -- 後手の全の動けるところ
    ugokeru[214][2] = -1 -- 後手の全の動けるところ
    ugokeru[214][3] = 1 -- 後手の全の動けるところ
    ugokeru[214][4] = 10 -- 後手の全の動けるところ
    ugokeru[214][5] = 11 -- 後手の全の動けるところ
    ugokeru[214][6] = 12 -- 後手の全の動けるところ
    -- 後手の馬の動けるところ
    for ugoki = 1, 8 do
        ugokeru[216][ugoki] = -12 * ugoki
        ugokeru[216][ugoki + 8] = 12 * ugoki
        ugokeru[216][ugoki + 16] = -10 * ugoki
        ugokeru[216][ugoki + 24] = 10 * ugoki
    end
    ugokeru[216][33] = -11 -- 後手の馬の動けるところ
    ugokeru[216][34] = -1 -- 後手の馬の動けるところ
    ugokeru[216][35] = 1 -- 後手の馬の動けるところ
    ugokeru[216][36] = 11 -- 後手の馬の動けるところ
    -- 後手の竜の動けるところ
    for ugoki = 1, 8 do
        ugokeru[217][ugoki] = -11 * ugoki
        ugokeru[217][ugoki + 8] = 11 * ugoki
        ugokeru[217][ugoki + 16] = -1 * ugoki
        ugokeru[217][ugoki + 24] = 1 * ugoki
    end
    ugokeru[217][33] = -12 -- 後手の竜の動けるところ
    ugokeru[217][34] = -10 -- 後手の竜の動けるところ
    ugokeru[217][35] = 10 -- 後手の竜の動けるところ
    ugokeru[217][36] = 12 -- 後手の竜の動けるところ

end

-- 将棋所からのコマンド待ちの関数
function NyuryokuMati()
    while true do
        uketori = io.read()

        io.stdout:setvbuf("no") -- 出力をバッファリングしない設定。

        --    print("["..uketori.."]") --入力文字の確認用

        -- 終了コマンド
        if uketori == "quit" then break end

        -- 対局準備
        if uketori == "isready" then print("readyok") end

        --[[入力の省略
--]]
        if uketori == "s" then
            uketori = "position startpos"
            -- ↓[[　]]は改行ごとそのまま出力する
            print([[「position startpos」をセットしました。
続きは「c」を入力してください。]])
        end

        if uketori == "tb" then -- テスト局面 いろは先手
            uketori =
                "position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b"
            -- ↓[[　]]は改行ごとそのまま出力する
            print(
                [[「position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f 6a7a P*8b 8a7c 6c7c 5b6a 6b6a+ 7a8a 8b8a+ 4a5b G*4a 3b2b」をセットしました。
続きは、「c」を入力してください。]])
        end

        if uketori == "tw" then -- テスト局面 いろは後手
            uketori =
                "position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f"
            -- ↓[[　]]は改行ごとそのまま出力する
            print(
                [[「position startpos moves 2g2f 5a5b 9i9h 8b6b 8g8f 6b8b 2h7h 2c2d 2f2e 7a6b 9g9f 6b5a 9h9g 4a3b 8f8e 6a7b 7h2h 3a4b 6g6f 6c6d 6f6e 7b6c 6e6d 2b3a 2h7h 9c9d 8e8d 9a9c 8d8c+ 5b4a 6i5h 6c6b 8c7c 8b9b 7c8c 5a5b 6d6c+ 2d2e P*2f 1a1b 8c9c 6b6a P*6b P*8f L*7f」をセットしました。
続きは、「c」を入力してください。]])
        end

        if uketori == "c" then
            uketori = "go btime 3599000 wtime 3597000 byoyomi 0"
        end

        --[[将棋所のエンジン1へ（またはコマンドラインで）、
   「maturi」を手動入力すると
		生成指し手生成祭りの局面セット。たぶん198手。自殺手を入れると199手。
--]]
        if uketori == "maturi" then
            uketori =
                "position sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1"
            -- ↓[[　]]は改行ごとそのまま出力する
            print(
                [[指し手生成祭りの局面セット「position sfen l6nl/5+P1gk/2np1S3/p1p4Pp/3P2Sp1/1PPb2P1P/P5GS1/R8/LN4bKL w GR5pnsg 1」をセットしました。
続きは「maturi2」を入力してください。]])
            maturi = 1 -- 続きは、maturi2へ。
        end

        if uketori == "maturi2" then
            if maturi ~= 1 then
                print("先に「maturi」を入力してください。")
            else
                HyojiMaturi()
            end -- 祭り用盤面表示
        end

        -- hyoujiと入力すると、盤面状況を表示する
        if uketori == "hyouji" then
            hyouji()
        end

        -- 以下、「position」と「go」コマンドの対応  
        if string.match(uketori, "position st", n) ~= nil then -- startposを設定
            Bunkatu()
            if BunkatuSuu == 2 then
                Teban = 1 -- いろはの手番が先手（1）
                TeSuu = 1
            elseif BunkatuSuu % 2 == 1 then -- 奇数なら先手
                Teban = 1
                TeSuu = BunkatuSuu - 2 -- movesの次の文字列はTeSuu=1
            elseif BunkatuSuu % 2 == 0 then -- 偶数なら後手
                Teban = -1 -- いろはの手番が後手（-1）
                TeSuu = BunkatuSuu - 2 -- movesの次の文字列はTeSuu=1
            end

            ItijiTeban = Teban  -- 一時的にいろはの手番を保存する。
            -- movesのすぐ後の指し手が先手番（1）になるように調整。
            Teban = -1
            for i = 1, 550 do -- BunkatuMojiを1手目から順に代入していくループ。負け判定する最大手数より大きくする。
                if BunkatuMoji[i] == nil then
                    saigonoiti = BantiHeHenkan(AtoIti) -- 最後の相手の一手を保存。追記170602
                    Teban = ItijiTeban  -- いろはの手番を元に戻す。
                    break
                end
                HaitiDainyu(i, Teban) -- 4文字から盤面に代入する関数
                Teban = -Teban
            end
        end

        if string.match(uketori, "position sf", n) ~= nil then -- sfenを設定
            Sfen()

            --[[
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 b Ps4p 1
      ↑BunkatuSuu 6 個 →先手
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 b Ps4p 1 moves S*8h 7g7f
      ↑BunkatuSuu 9 個（奇数） →先手
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 b Ps4p 1 moves S*8h
      ↑BunkatuSuu 8 個（偶数） →後手
      
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 w Ps4p 1
      ↑BunkatuSuu 6 個 →後手
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 w Ps4p 1 moves S*8h 7g7f
      ↑BunkatuSuu 9 個（奇数） →後手
      position sfen 1n4snl/（略）/2KG3+n1/LNSG5 w Ps4p 1 moves S*8h
      ↑BunkatuSuu 8 個（偶数） →先手
      
      bのとき、move直後は先手
      wのとき、move直後は後手
      ]] --

            if BunkatuMoji[4] == "b" then
                if BunkatuSuu == 6 then
                    Teban = 1 -- いろはの手番が先手（1）
                    TeSuu = 1
                elseif BunkatuSuu % 2 == 1 then -- 奇数なら先手
                    Teban = 1
                    TeSuu = BunkatuSuu - 6 -- movesの次の文字列はTeSuu=1
                elseif BunkatuSuu % 2 == 0 then -- 偶数なら後手
                    Teban = -1 -- いろはの手番が後手（-1）
                    TeSuu = BunkatuSuu - 6 -- movesの次の文字列はTeSuu=1
                end
            else -- BunkatuMoji[4]=="w"のとき
                if BunkatuSuu == 6 then
                    Teban = -1 -- いろはの手番が後手（1）
                    TeSuu = 1
                elseif BunkatuSuu % 2 == 1 then -- 奇数なら後手
                    Teban = -1
                    TeSuu = BunkatuSuu - 6 -- movesの次の文字列はTeSuu=1
                elseif BunkatuSuu % 2 == 0 then -- 偶数なら先手
                    Teban = 1 -- いろはの手番が先手（-1）
                    TeSuu = BunkatuSuu - 6 -- movesの次の文字列はTeSuu=1
                end
            end
            
            Bunkatu()
            ItijiTeban = Teban  -- 一時的にいろはの手番を保存する。
            -- 送られてきたsfenでindex4が「b」ならmovesのすぐ後の指し手が先手番（1）になるように調整。
            if BunkatuMoji[4] == "b" then
                Teban = -1
            end
            
            for i = 1, 550 do -- BunkatuMojiを1手目から順に代入していくループ。負け判定する最大手数より大きくする。
                if BunkatuMoji[i] == nil then
                    saigonoiti = BantiHeHenkan(AtoIti) -- 最後の相手の一手を保存。追記170602
                    Teban = ItijiTeban  -- いろはの手番を元に戻す。
                    break
                end
                HaitiDainyu(i,Teban) -- 4文字から盤面に代入する関数
                Teban = -Teban -- 手番を入れ替える
            end
        end
        
        -- bestmoveを考える
        if string.match(uketori, "go b", n) ~= nil then
            -- 局面を表示する
            hyouji()
            -- 513手を超えているかをチェック
            if TeSuu >= 513 then
                print(
                    "info string 513手を超えています！？……まいりましたorz") -- 投了する
                print("bestmove resign") -- 投了する
            end
            
            -- 現局面を表示する
            
            -- 現局面で、いろはの次の1手目の合法手の生成する。
            -- Sasite[x][1-5]に合法手を生成する。
            Gouhousyu(Teban, HaitiGenzai, Sasite)

            -- ノード数
            nodesuu = gouhousyukazu
            print("info depth 1 nodes " .. nodesuu)

            -- 2017/01/04ここまで。
            -- Sasiteに現局面のいろはの次の1手目の合法手を残し、
            -- 合法手を絞り込むためのSasiteItijiにSasiteをコピーする。
            for i = 1, 600 do
                if Sasite[i][1] == 999 then
                    SasiteItiji[i][1] = 999
                    --print("1：999を入れた。SasiteItiji[i]",i)
                    break
                end
                for j = 1, 5 do SasiteItiji[i][j] = Sasite[i][j] end
            end

            -- HaitiItijiにある合法手の絞り込み。
            -- なぜか打つ手の時、無い駒を打とうとする。　←170602に修正済み。
            x = 1
            tuikagouhousyukazu = 0
            for i = 1, 600 do 
                if Sasite[i][1] == 999 then
                    -- print("Sasiteが999時のi,x:",i,x)
                    -- print("")
                    -- 局地暴走モード等で候補数を減らした時にSasiteItijiを減らすため999を入れる
                    --SasiteItiji[x][1] = 999
                    --print("2：999を入れた。SasiteItiji[x]",x)
                    SasiteItiji[i][1] = 999
                    --print("2'：999を入れた。SasiteItiji[i]",i)
                    break
                end

                -- 玉の隣に王手を仕掛けてきたら、玉で取る。
                -- 候補数を1にする。　←候補番号2の[1]を999にする。
                if Sasite[i][3] == saigonoiti and
                    (Sasite[i][2] == 108 or Sasite[i][2] == 208) then
                    for j = 1, 5 do
                        SasiteItiji[1][j] = Sasite[i][j]
                        SasiteItiji[2][1] = 999
                        --print("3：999を入れた。王でとるSasite[i]",i, unpack(Sasite[i]) )
                        tuikagouhousyukazu = 1
                        gouhousyukazu = 1
                    end
                    break
                end

                -- 局地モードOn。wcsc29時に搭載。
                -- いろはの次の1手が、相手の最後の手の近くかどうかを確認する。
                -- 相手の最後に指した駒の位置やその周辺に、駒を刺したり打つ指し手を集める。
                -- 局地モードでランダム指しの場合は、局地暴走モード。
                if Sasite[i][3] == saigonoiti - 12 or Sasite[i][3] ==
                    saigonoiti - 11 or Sasite[i][3] == saigonoiti - 10 or
                    Sasite[i][3] == saigonoiti - 1 or Sasite[i][3] ==
                    saigonoiti or Sasite[i][3] == saigonoiti + 1 or
                    Sasite[i][3] == saigonoiti + 10 or Sasite[i][3] ==
                    saigonoiti + 11 or Sasite[i][3] == saigonoiti + 12 then
                    -- SasiteItijiを1から順に上書きする。ここから。
                    for j = 1, 5 do
                        SasiteItiji[x][j] = Sasite[i][j]
                    end
                    tuikagouhousyukazu = x
                    -- 局地暴走モード時の指し手数
                    gouhousyukazu = x
                    x = x + 1
                    -- SasiteItijiを1から順に上書きする。ここまで。
                end
            end

            -- 2017/5/3指し手番号、ランダム初期化。
            math.randomseed(os.time())
            -- 2020-11-21　いろはの候補数の確認のため
            -- print("以下は局地モードの処理をした指し手")
            print("局地モードのgouhousyukazu:", gouhousyukazu)
            kouhosuu = gouhousyukazu
            -- print_sasite(Sasite)
            -- 候補数gouhousyukazuから、指し手番号をランダムに決める
            -- 指し手の選択肢数
            sentakusisuu = gouhousyukazu

            -- 2019-05-03まで
            -- sasitebangou = math.random(sentakusisuu)
            -- 2019-11-21に以下に変更
            -- 現在の盤面
            -- 深さ1　探索中
            -- 指し手の候補を、各要素3桁ずつ1つの文字列（数字）にして格納する。
            -- 例）Sasite　1:　18　105　19　206　0
            -- 　→　SasiteAll1　018105019206000
            -- 1手先の評価値を入れる
            -- 　→　SasiteValueAll1　{3456,5678,7890}
            SasiteAll1 = {}
            SasiteValueAll1 = {}
            for i = 1, sentakusisuu do
                SasiteAll1[i] = ""
                for j = 1, 5 do
                    SasiteAll1[i] = SasiteAll1[i] ..
                                        string.format("%03d", SasiteItiji[i][j])
                end
                -- 1手先を読む。
                -- Yomu(Sasite[index])→HaitiYomi
                -- 引数・Sasiteのindexのものを、局面HaitiYomiに入れる。
                Yomu(i)
                print("info depth 1 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                          " score cp " .. KyokumenHyouka(HaitiYomi))
            end
            -- print("SasiteAll1", unpack(SasiteAll1) )
            -- print("SasiteValueAll1", unpack(SasiteValueAll1) )
            print("")
            -- ここまで、現在の盤面

            -- 1手先の局面
            -- 評価値を入れるリスト
            HyokaList = {}
            -- 指し手の候補を、各要素3桁ずつ1つの文字列（数字）にして格納する。
            -- 例）Sasite　1:　18　105　19　206　0
            -- 　→　SasiteAll2[x]　018105019206000
            -- 評価値を入れるリスト
            -- 　→　SasiteValueAll2[x]　数値
            SasiteAll2 = {}
            SasiteValueAll2 = {}
            -- 最深部の評価値を入れる
            finalVlue1 = {}
            finalVlue2 = {}
            -- 最深部までの指し手を入れる
            finalindex1 = {}
            finalindex2 = {}
            -- SasiteItijiの各指し手番号の指し手の局面を作成する。
            -- 1手先のindex数をmaxn()で調べる
            for i = 1, table.maxn(SasiteAll1) do
                -- ここから、1手先
                -- 引数はSasiteItijiの指し手番号。その指し手を局面HaitiYomiに入れる。
                Yomu(i)
                -- SasiteYomiの初期化
                SasiteYomi = {}
                for j = 1, 600 do
                    -- Sasite系の配列の行の作成
                    SasiteYomi[j] = {}
                    for k = 1, 5 do SasiteYomi[j][k] = 0 end
                end
                -- ここまで、SasiteYomiの初期化
                -- 2手先、相手の合法手を考える。Gouhousyu(1:先手,-1:後手, HaitiYomi, Sasite系)
                Gouhousyu(-Teban, HaitiYomi, SasiteYomi)
                print("SasiteYomi-index:", i, SasiteAll1[i])
                -- print_sasite( SasiteYomi )
                -- ここまで、1手先

                -- ここから、2手先
                -- 深さ2　探索中
                SasiteAll2[i] = {}
                SasiteValueAll2[i] = {}
                finalVlue2[i] = {}
                finalindex2[i] = {}
                -- 2手先の候補数
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
                    -- 2手先を読む。
                    -- Yomu2(SasiteYomi[index])→HaitiYomi2
                    -- 引数・SasiteYomiのindexのものを、局面HaitiYomi2に入れる。
                    Yomu2(j)
                    -- 2手目と、2手先の評価値を表示する
                    --[[
                        print(
                        "info depth 2 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                            " " .. Num15CharConvert(SasiteAll2[i][j]) .. " " ..
                            "score cp " .. KyokumenHyouka(HaitiYomi2))
                    --]]
                    -- 各局面の評価値を求める。
                    SasiteValueAll2[i][j] = KyokumenHyouka(HaitiYomi2)
                    HyokaList[i] = KyokumenHyouka(HaitiYomi)
                    -- 最深部の最小の評価値を入れる
                    finalVlue2[i][j] = KyokumenHyouka(HaitiYomi2)
                end
                finalVlue1[i] = {}
                finalindex1[i] = {}
                -- 最深部の最小の評価値で、2手先時の指し手等を入れる
                if Teban == 1 then
                    index2, value2 = min(finalVlue2[i])
                    finalVlue1[i] = value2
                    print("2手先（後手）の最小値value2", value2)
                    finalindex1[i] = SasiteAll2[i][index2]
                    print("2手先（後手）の最小値の指し手",
                          SasiteAll2[i][index2])
                else
                    index2, value2 = max(finalVlue2[i])
                    finalVlue1[i] = value2
                    print("2手先（先手）の最大値value2", value2)
                    finalindex1[i] = SasiteAll2[i][index2]
                    print("2手先（先手）の最大値の指し手",
                          SasiteAll2[i][index2])
                end
                --2手先の選び出した指し手とその評価を出力する
                print(
                    "info depth 2 pv " .. Num15CharConvert(SasiteAll1[i]) ..
                        " " .. Num15CharConvert( SasiteAll2[i][index2] ) .. " " ..
                        "score cp " .. value2 )

                -- node合計を入れる
                nodesuu = nodesuu + kouhosuu
                print("info depth 2 nodes " .. nodesuu)
                print("")
                -- print("SasiteAll2[i]:",i, unpack(SasiteAll2[i]) )
                -- print("SasiteValueAll2[i]:",i, unpack(SasiteValueAll2[i]) )
                -- ここまで、2手先
                -- ここまで、1手先の局面
            end

            -- 1手先の評価値の中での最大値（最小値）
            -- いろはが先手の場合。
            if Teban == 1 then
                index1, value1 = max(finalVlue1)
                -- 最深部まで探索したものでの読みで最善手（評価値、手筋index）
                saizen = {}
                saizen["hyouka"] = value1
                saizen["index"] = SasiteAll1[index1] .. finalindex1[index1]
                print("saizen.hyouka(max), saizen.index:", saizen.hyouka,
                      saizen.index)
                print("Teban:1, ", Teban)
            -- いろはが後手の場合。
            else
                index1, value1 = min(finalVlue1)
                -- 最深部まで探索したものでの読みで最善手（評価値、手筋index）
                saizen = {}
                saizen["hyouka"] = value1
                saizen["index"] = SasiteAll1[index1] .. finalindex1[index1]
                print("saizen.hyouka(min), saizen.index:", saizen.hyouka,
                      saizen.index)
                print("Teban:-1, ", Teban)
            end
            -- 最善手のindex
            sasitebangou = index1

            -- いろはの王がとられるかチェック。　←MOD:020-12-02完了。
            -- YomuはSashiteitijiを使う。
            Yomu(sasitebangou)
            -- いろは先手。
            if Teban ~= 0 then
                Gouhousyu(-Teban, HaitiYomi, SasiteYomi)
                --print("いろはの王とられチェック")
                for i = 1, 600 do
                    --print("SasiteYomi[",i,"]", unpack(SasiteYomi[i]) )
                    -- 999の時は検討を終了する。
                    if SasiteYomi[i][1] == 999 then
                        --print("Teban:1, SasiteYomi[i]:999 ",i)
                        break
                    end
                    --print("王を取られるかチェックSasiteYomi：", i, unpack(SasiteYomi[i]))
                    -- いろはの王が取られるなら投了する。
                    if SasiteYomi[i][4] == 108 or SasiteYomi[i][4] == 208 then
                        print("info string ！？……まいりましたorz")
                        print("bestmove resign") 
                    end
                end
            end
            -- ここまで、いろはの王がとられるかチェック

            -- 2019/05/03 <ADD 2020/11/21 <MOD
            print("最終の合法手数: ", sentakusisuu)
            print("指し手番号: ", sasitebangou)
            -- 2019/05/03 ADD>

            -- 数字→文字変換
            -- 2020/11/22関数化
            -- Sasiteをusiプロトコルで送る文字列化
            sasiteMoji = ""
            for i = 1, 5 do
                sasiteMoji = sasiteMoji ..
                                 string.format("%03d", SasiteItiji[sasitebangou][i])
            end

            -- 評価値の計算をする
            -- tensuu = math.random(2000)-1000
            tensuu = KyokumenHyouka(HaitiGenzai)

            print("info string 先手の駒損得" .. sentetoku ..
                      "vs後手の駒損得" .. -gotetoku)
            print("info string 先手の守り数" .. sentemamorikazu ..
                      "vs後手の守り数" .. gotemamorikazu)
            print("info string 先手の守り点" .. sentemamoriten ..
                      "vs後手の守り点" .. gotemamoriten)

            if tuikagouhousyukazu >= 1 then
                --        print("info string 追加指し手数"..tuikagouhousyukazu)
            end

            if Teban == 1 then
                print("info nodes " .. nodesuu .. " score cp " .. tensuu ..
                          " pv " .. Num15CharConvert(sasiteMoji))
            else
                -- Tebanが-1のときスコアを反転
                print("info nodes " .. nodesuu .. " score cp " .. -tensuu ..
                          " pv " .. Num15CharConvert(sasiteMoji))
            end
            -- 次の一手を送信する。
            -- 例）　bestmove N*9e
            print("b-move2:", sasiteMoji)
            print("bestmove " .. Num15CharConvert(sasiteMoji))
            -- 思考中の表示 info time 0 depth 2 nodes 218 score cp 193 pv 8i7g 8e8f
            --[[
sfenの処理ができました。info scoreでスコア表示
って、haitidainyuができていませんでした。
↑できてる？？？20170601

その次は、いよいよ合法手の生成です。
そのあとは、
・ランダム指し
・一手詰めルーチン
・評価関数
      ]] --

        end

        if string.match(uketori, "go m", n) ~= nil then -- 詰め将棋を考える
            print("go m、あったよ")
        end

    end

end

-- 文字列を分割する関数
function Bunkatu()

    -- uketori = "position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d"
    -- position startpos moves 2g2f 5a4b 2f2e 後手
    -- position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b P*2e
    -- position startpos moves 2g2f 5a4b 2f2e 4b3b 2e2d 6a5b 2d2c+ 3b4b 7g7f 3a3b 7f7e 9a9b 7e7d 4c4d 6g6f 1a1b 6f6e 7a7b 6e6d 4b5a 5g5f 3b2c 5f5e 6c6d 5e5d 6d6e 2h2e 5a4b 2e4e 5c5d 4e4d P*4c 4d5d

    BunkatuSuu = 0
    BunkatuMoji = {}
    -- ↓文字列の分割。英数文字や区切り文字。
    for i in uketori:gmatch("[%a%d%p]+") do
        BunkatuSuu = BunkatuSuu + 1 -- 受け取ったコマンドを分割した数
        BunkatuMoji[BunkatuSuu] = i -- 受け取ったコマンドを分割して収納
    end

end

-- 4文字から盤面に代入する関数
function HaitiDainyu(mTeme, haitiTeban)
    if BunkatuMoji[mTeme] == "startpos" then
        HaitiGenzai = {unpack(HaitiStaPos)} -- {　}を忘れずに
    end
    -- ↑ 11/21ここまで。
    MaeIti = string.sub(BunkatuMoji[mTeme], 1, 2)
    -- ↑さいごの最終位置を省略すると最後まで。
    AtoIti = string.sub(BunkatuMoji[mTeme], 3, 4)
    -- ↑手数mTemeのBunkatuMojiから、動かす先の2文字を記録
    Naruka = string.sub(BunkatuMoji[mTeme], 5, 5)
    -- ↑手数mTemeのBunkatuMojiから、成る（+）かを記録

    if BantiHeHenkan(MaeIti) > 0 then
        MaeKoma = HaitiGenzai[BantiHeHenkan(MaeIti)]
        -- ↑動く前の位置の駒の種類を記録
        HaitiGenzai[BantiHeHenkan(MaeIti)] = 0 -- 動く前の位置は0にする
    elseif BantiHeHenkan(MaeIti) == 0 then
        MaeKoma = 0
    else
        return
    end

    ToruKoma = HaitiGenzai[BantiHeHenkan(AtoIti)]
    -- ↑動く先の位置の駒（取る駒）の種類を記録
    -- ↑2文字から番地番号へ変換する関数

    UgokuKoma = MaeKoma

    if MaeKoma == 0 then -- 動く前の駒の種類が0（空）なら
        UgokuKoma = Utu(MaeIti)
        if haitiTeban == 1 then -- 先手なら
            UgokuKoma = UgokuKoma + 100
            -- ↑UgokuKomaに先手を意味する100を足す
            HaitiGenzai[UgokuKoma + 21] = HaitiGenzai[UgokuKoma + 21] - 1
            -- ↑101との差が+21。持ち駒の枚数を減らす
        else -- 後手なら
            UgokuKoma = UgokuKoma + 200
            -- ↑UgokuKomaに後手を意味する200を足す
            HaitiGenzai[UgokuKoma - 71] = HaitiGenzai[UgokuKoma - 71] - 1
            -- ↑201との差が-71。持ち駒の枚数を減らす
        end
    end

    if ToruKoma > 0 and ToruKoma < 200 then -- 先手が駒を取ると
        HaitiGenzai[Toru(ToruKoma) - 71] = HaitiGenzai[Toru(ToruKoma) - 71] + 1
        -- ↑201との差が-71。取った分、持ち駒の枚数を増やす
    elseif ToruKoma > 200 then
        HaitiGenzai[Toru(ToruKoma) + 21] = HaitiGenzai[Toru(ToruKoma) + 21] + 1
        -- ↑101との差が+21。取った分、持ち駒の枚数を増やす
    end

    if Naruka == "+" then -- 成る処理
        UgokuKoma = UgokuKoma + 10
    end

    HaitiGenzai[BantiHeHenkan(AtoIti)] = UgokuKoma
end

-- 打つときの駒の種類の関数
--[[
↓打つ駒の種類
ＰＬＮＳＧＢＲ
歩香桂銀金角飛
１２３４５６７
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

-- 駒をとったときの駒の種類変換をする関数
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

-- 2文字から番地番号へ変換する関数
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

    -- SfenBun[段目]は、「 5+P1gk 」など。
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
            SfenSuuji = 13 -- 配置番地13-21の一段目
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
            SfenSuuji = 101 -- 配置番地101-109の九段目
        else
            SfenSuuji = 999
            --print("4：999を入れた。sfen")
        end -- エラーのとき

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

    -- 以下、持ち駒の処理
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

-- 合法手を生成する関数(引数GouhouTeban：1先手/-1：後手、Haiti配置系、出力するSasite系)
-- 祭り生成祭り生成数が300超える、謎。→解決済。
-- HaitiGouhousyu2に引数の盤面を再現し、変更していく。
-- 関数を呼び出した後の、読んだ後のHaitiGouhousyu2を使う。
function Gouhousyu(GouhouTeban, HaitiGouhousyu, SasiteGouhousyu)
    -- Sasite[指し手の候補番号][1:元番地、2:元の駒種、3:先番地、4:先の駒種、5:成り+10]
    -- [1]が999の時はおわり
    -- [1]が200か-200の時は打つ
    kouhosuu = 0
    HaitiGouhousyu2 = {unpack(HaitiGouhousyu)}
    -- SasiteGohosyuを初期化
    for i = 1, 600 do
        -- Sasite系の配列の行の作成
        SasiteGouhousyu[i] = {}
        for j = 1, 5 do
            SasiteGouhousyu[i][j] = 0
        end
    end

    -- 先手の時
    for i = 13, 109 do -- 番地13から109までを調べていく
        if GouhouTeban == 1 then -- 先手の時
            if HaitiGouhousyu2[i] == 101 or HaitiGouhousyu2[i] == 103 or
                HaitiGouhousyu2[i] == 104 then -- 歩、桂、銀のとき
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            if kouhoti >= 13 and kouhoti <= 43 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 歩、桂、銀の繰り返し終わり
            end -- 歩、桂、銀、終わり

            if HaitiGouhousyu2[i] == 105 or HaitiGouhousyu2[i] == 108 or
                (HaitiGouhousyu2[i] >= 111 and HaitiGouhousyu2[i] <= 114) then -- 金、王、成金のとき
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                        end
                    end
                end -- 金、王、成金の繰り返し終わり
            end -- 金、王、成金終わり

            yameru = 0 -- やめるフラグ初期化0
            if HaitiGouhousyu2[i] == 102 then -- 香のとき
                for j = 1, 8 do -- ↑に向かって1から8番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            if kouhoti >= 13 and kouhoti <= 43 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 香の繰り返し終わり
            end -- 香、終わり

            yameru = 0 -- やめるフラグ初期化0
            if HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] == 117 or
                HaitiGouhousyu2[i] == 106 or HaitiGouhousyu2[i] == 116 then -- 飛、竜、角、馬のとき
                for j = 1, 8 do -- ↑か←↑に向かって1から8番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の↑の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 9, 16 do -- ↓に向かって9から16番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の↑の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 17, 24 do -- ←に向かって17から24番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の←の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 25, 32 do -- →に向かって25から32番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 107 or HaitiGouhousyu2[i] ==
                                106) and
                                ((kouhoti >= 13 and kouhoti <= 43) or
                                    (i <= 13 and i >= 43)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の→の繰り返し終わり
            end -- 飛、角の終わり

            if HaitiGouhousyu2[i] == 117 or HaitiGouhousyu2[i] == 116 then -- 竜か馬のときの残り
                for j = 33, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 201 and
                                    HaitiGouhousyu2[kouhoti] <= 217)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                        end
                    end
                end -- 竜、馬の残りの繰り返し終わり
            end -- 竜、馬の終わり

        end -- 先手の指し手、終わり
    end -- for終わり

    -- 先手の持ち駒を打つとき
    if GouhouTeban == 1 then -- 先手の時
        if HaitiGouhousyu2[101 + 21] >= 1 then -- 歩のとき
            hunokazu = 0
            HunoIti = {} -- HunoIti[盤面の歩の番号]=歩の番地
            for i = 1, 9 do
                HunoIti[i] = -999 -- HunoIti[盤面の歩の番号]=番地
            end
            for i = 13, 109 do -- 盤面に先手の歩の位置を調べる
                if HaitiGouhousyu2[i] == 101 then
                    hunokazu = hunokazu + 1
                    HunoIti[hunokazu] = i
                end
            end
            HuUteru = {}
            for i = -200, 200 do
                HuUteru[i] = 1 -- HuUteru[番地13-109]=1　歩を打ってOK
            end
            if hunokazu >= 1 then
                for i = 1, 9 do -- iは盤面の歩の数
                    for j = 0, 10 do -- jは、たての数
                        HuUteru[HunoIti[i] + 11 * j] = 0
                        HuUteru[HunoIti[i] - 11 * j] = 0
                    end
                end
            end

            for i = 24, 109 do -- 2段目からの番地を調べる（歩は1段目はダメ）
                if HuUteru[i] == 1 and HaitiGouhousyu2[i] == 0 then -- HuUteru[番地]が1で配置・現在が0なら、歩を打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- 元番地は、先手の番外（200）
                    SasiteGouhousyu[kouhosuu][2] = 101 -- 元の駒種
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 歩を打つのは終わり

        if HaitiGouhousyu2[102 + 21] >= 1 then -- 香のとき
            for i = 24, 109 do -- 2段目からの番地を調べる（香は1段目はダメ）
                if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- 元番地は、先手の番外（200）
                    SasiteGouhousyu[kouhosuu][2] = 102 -- 元の駒種・香
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 香を打つのは終わり

        if HaitiGouhousyu2[103 + 21] >= 1 then -- 桂のとき
            for i = 35, 109 do -- 3段目からの番地を調べる（桂は1-2段目はダメ）
                if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = 200 -- 元番地は、先手の番外（200）
                    SasiteGouhousyu[kouhosuu][2] = 103 -- 元の駒種・桂
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 桂を打つのは終わり

        for x = 0, 3 do
            if HaitiGouhousyu2[104 + 21 + x] >= 1 then -- 銀、金、角、飛のとき
                for i = 13, 109 do -- 3段目からの番地を調べる（桂は1-2段目はダメ）
                    if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                        kouhosuu = kouhosuu + 1
                        SasiteGouhousyu[kouhosuu][1] = 200 -- 元番地は、先手の番外（200）
                        SasiteGouhousyu[kouhosuu][2] = 104 + x -- 元の駒種
                        SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                        SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                        SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                    end
                end
            end
        end -- 銀、金、角、飛を打つのは終わり
    end -- 先手の持ち駒を打つの終わり

    -- 後手の時
    for i = 13, 109 do -- 番地13-109を調べていく
        if GouhouTeban == -1 then -- 後手の時
            if HaitiGouhousyu2[i] == 201 or HaitiGouhousyu2[i] == 203 or
                HaitiGouhousyu2[i] == 204 then -- 歩、桂、銀のとき
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            if kouhoti >= 79 and kouhoti <= 109 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 歩、桂、銀の繰り返し終わり
            end -- 歩、桂、銀、終わり

            if HaitiGouhousyu2[i] == 205 or HaitiGouhousyu2[i] == 208 or
                (HaitiGouhousyu2[i] >= 211 and HaitiGouhousyu2[i] <= 214) then -- 金、王、成金のとき
                for j = 1, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                        end
                    end
                end -- 金、王、成金の繰り返し終わり
            end -- 金、王、成金終わり

            yameru = 0 -- やめるフラグ初期化0
            if HaitiGouhousyu2[i] == 202 then -- 香のとき
                for j = 1, 8 do -- ↑に向かって1から8番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            if kouhoti >= 79 and kouhoti <= 109 then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 香の繰り返し終わり
            end -- 香、終わり

            yameru = 0 -- やめるフラグ初期化0
            if HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] == 217 or
                HaitiGouhousyu2[i] == 206 or HaitiGouhousyu2[i] == 216 then -- 飛、竜、角、馬のとき
                for j = 1, 8 do -- ↑か←↑に向かって1から8番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の↑の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 9, 16 do -- ↓に向かって9から16番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の↑の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 17, 24 do -- ←に向かって17から24番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の←の繰り返し終わり

                yameru = 0 -- やめるフラグ初期化0
                for j = 25, 32 do -- →に向かって25から32番目まで。途中で駒があるとストップ。yameruやめるフラグを1にする。
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 and yameru == 0 then -- ugokeru[こまの種類][j]が0以外で動ける、やめるフラグたってないとき。
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if HaitiGouhousyu2[kouhoti] ~= 0 then -- 駒があるとき、やめるフラグを立てる
                            yameru = 1
                        end
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            -- 飛か角は、元位置か先位置が相手陣地のとき、成る↓
                            if (HaitiGouhousyu2[i] == 207 or HaitiGouhousyu2[i] ==
                                206) and
                                ((kouhoti >= 79 and kouhoti <= 109) or
                                    (i <= 79 and i >= 109)) then
                                SasiteGouhousyu[kouhosuu][5] = 10 -- 成る
                            else
                                SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                            end
                        end
                    end
                end -- 飛、竜の→の繰り返し終わり
            end -- 飛、角の終わり

            if HaitiGouhousyu2[i] == 217 or HaitiGouhousyu2[i] == 216 then -- 竜か馬のときの残り
                for j = 33, 36 do
                    if ugokeru[HaitiGouhousyu2[i]][j] ~= 0 then -- ugokeru[こまの種類][j]が0以外で動ける
                        kouhoti = i + ugokeru[HaitiGouhousyu2[i]][j] -- kouhoti 候補地
                        if kouhoti >= 13 and kouhoti <= 109 and
                            (HaitiGouhousyu2[kouhoti] == 0 or
                                (HaitiGouhousyu2[kouhoti] >= 101 and
                                    HaitiGouhousyu2[kouhoti] <= 117)) then
                            kouhosuu = kouhosuu + 1
                            SasiteGouhousyu[kouhosuu][1] = i -- 元番地
                            SasiteGouhousyu[kouhosuu][2] = HaitiGouhousyu2[i] -- 元の駒種
                            SasiteGouhousyu[kouhosuu][3] = kouhoti -- 先番地
                            SasiteGouhousyu[kouhosuu][4] =
                                HaitiGouhousyu2[kouhoti] -- 先の駒種
                            SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                        end
                    end
                end -- 竜、馬の残りの繰り返し終わり
            end -- 竜、馬の終わり

        end -- 後手の指し手、終わり
    end -- for終わり

    -- 後手の持ち駒を打つとき
    if GouhouTeban == -1 then -- 後手の時      
        if HaitiGouhousyu2[201 - 71] >= 1 then -- 歩のとき
            hunokazu = 0
            HunoIti = {} -- HunoIti[盤面の歩の番号]=歩の番地
            for i = 1, 9 do
                HunoIti[i] = -999 -- HunoIti[盤面の歩の番号]=番地
            end
            for i = 13, 109 do -- 盤面に先手の歩の位置を調べる
                if HaitiGouhousyu2[i] == 201 then
                    hunokazu = hunokazu + 1
                    HunoIti[hunokazu] = i
                end
            end
            HuUteru = {}
            for i = -200, 200 do
                HuUteru[i] = 1 -- HuUteru[番地13-109]=1　歩を打ってOK
            end
            if hunokazu >= 1 then
                for i = 1, 9 do -- iは盤面の歩の数
                    for j = 0, 10 do -- jは、たての数
                        HuUteru[HunoIti[i] + 11 * j] = 0
                        HuUteru[HunoIti[i] - 11 * j] = 0
                    end
                end
            end

            for i = 13, 98 do -- 2段目からの番地を調べる（歩は1段目はダメ）
                if HuUteru[i] == 1 and HaitiGouhousyu2[i] == 0 then -- HuUteru[番地]が1で配置・現在が0なら、歩を打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- 元番地は、後手の番外（-200）
                    SasiteGouhousyu[kouhosuu][2] = 201 -- 元の駒種
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 歩を打つのは終わり

        if HaitiGouhousyu2[202 - 71] >= 1 then -- 香のとき
            for i = 13, 98 do -- 2段目からの番地を調べる（香は1段目はダメ）
                if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- 元番地は、後手の番外（-200）
                    SasiteGouhousyu[kouhosuu][2] = 202 -- 元の駒種・香
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 香を打つのは終わり

        if HaitiGouhousyu2[203 - 71] >= 1 then -- 桂のとき
            for i = 13, 87 do -- 3段目からの番地を調べる（桂は1-2段目はダメ）
                if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                    kouhosuu = kouhosuu + 1
                    SasiteGouhousyu[kouhosuu][1] = -200 -- 元番地は、後手の番外（-200）
                    SasiteGouhousyu[kouhosuu][2] = 203 -- 元の駒種・桂
                    SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                    SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                    SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                end
            end
        end -- 桂を打つのは終わり

        for x = 0, 3 do
            if HaitiGouhousyu2[204 - 71 + x] >= 1 then -- 銀、金、角、飛のとき
                for i = 13, 109 do -- すべての番地を調べる
                    if HaitiGouhousyu2[i] == 0 then -- 配置・現在が0なら、打てる
                        kouhosuu = kouhosuu + 1
                        SasiteGouhousyu[kouhosuu][1] = -200 -- 元番地は、後手の番外（-200）
                        SasiteGouhousyu[kouhosuu][2] = 204 + x -- 元の駒種
                        SasiteGouhousyu[kouhosuu][3] = i -- 先番地
                        SasiteGouhousyu[kouhosuu][4] = 0 -- 先の駒種
                        SasiteGouhousyu[kouhosuu][5] = 0 -- 成らず
                    end
                end
            end
        end -- 銀、金、角、飛を打つのは終わり
    end -- 後手の持ち駒を打つの終わり

    gouhousyukazu = kouhosuu

    -- 2019-05-03　候補番号1の手がおかしくなることを修正
    if gouhousyukazu ~= 0 then
        SasiteGouhousyu[gouhousyukazu + 1][1] = 999 -- 指し手配列の合法手数+1に、配列終わり印の999を入れる。
        --print("5：999を入れた。", gouhousyukazu + 1)
        -- print("999を入れる直前のgouhousyukazu:",gouhousyukazu)
        -- print_sasite(Sasite)
    end
    -- 2019-05-03修正
    --   print("合法手数"..kouhosuu.." / 指し手配列の最後のもの-1から+1までの[1]"..Sasite[gouhousyukazu][1].."/"..Sasite[gouhousyukazu+1][1])
    --  print("KouhoSuu "..kouhosuu)

    -- return 
end

-- 評価関数
-- 駒の損得評価　+王周りの守り評価
-- 引数はHaitiGenzai等の局面
function KyokumenHyouka(HaitiHyouka)
    sentetoku = 0
    gotetoku = 0

    -- 駒の損得評価
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
    -- 駒の損得評価、ここまで

    -- 王周りの守り評価
    -- 1歩得で+200
    gyokumamori = 0
    sentemamorikazu = 0
    gotemamorikazu = 0

    for i = 13, 109 do -- 先後の玉探し
        if HaitiHyouka[i] == 108 then sentegyokuiti = i end
        if HaitiHyouka[i] == 208 then gotegyokuiti = i end
    end

    -- 王周りの金銀探し
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
  for i=13,109 do --王周りの逃げ道探し。相手の利きを考慮することが未処理。
    if HaitiHyouka[i]==108 then sentegyokuiti=i end
    if HaitiHyouka[i]==208 then gotegyokuiti=i end
  end
--]]
    -- 王周りの守り評価、ここまで

    --[[
function YomiHyouka()
  for x=1,600 do
    HaitiYomi[x]={unpack(HaitiHyouka)}
  end
  
  for i=1,kouhosuu do
    HaitiYomi[i][ Sasite[i][1] ]
  end
--]]

    -- 総評価を戻り値に入れる
    return sentetoku + gotetoku + sentemamoriten - gotemamoriten
end

-- 指し手生成祭りの表示（合法手など）
function HyojiMaturi()
    Gouhousyu(Teban, HaitiGenzai, Sasite)
    print(
        "いろはの合法手（[指し手番号]動く前位置13109、動く前の駒、動く先の位置、動く先の駒、成る+10）")
    for i = 1, 600 do
        if Sasite[i][1] == 999 then break end
        io.write(
            "[" .. i .. "]" .. Sasite[i][1] .. "/" .. Sasite[i][2] .. "/" ..
                Sasite[i][3] .. "/" .. Sasite[i][4] .. "/" .. Sasite[i][5] ..
                " ")
    end
    print ""
    print "ちょっと待ってね-終わり文字版"

    -- 時間計測開始
    kurikaesisuu = 10000

    kaisijikoku = os.clock()

    for i = 1, kurikaesisuu do Gouhousyu(Teban, HaitiGenzai, Sasite) end

    syorijikan = os.clock() - kaisijikoku
    print("処理時間(s):" .. syorijikan)
    print("繰り返し数:" .. kurikaesisuu)
    print("秒速(nps):" .. math.floor(kurikaesisuu / syorijikan + 0.5)) -- 小数を四捨五入

    -- 時間計測終了

end

-- 現在の盤面HaitiGenzaiの1手先を読む関数
-- 引数の番号から、SasiteItijiの番号の指し手をHaitiYomiに入れる
function Yomu(index) -- 候補番号
    HaitiYomi = {unpack(HaitiGenzai)} -- 配置読み
    -- テーブルをコピーするときunpackを使わないと連動する。{　}を忘れずに。
    if SasiteItiji[index][1] ~= 999 then
        if SasiteItiji[index][1] ~= 200 or SasiteItiji[index][1] ~= -200 then -- 打たないとき
            HaitiYomi[SasiteItiji[index][1]] = 0 -- 元番地には空である0を代入
            HaitiYomi[SasiteItiji[index][3]] = SasiteItiji[index][2] -- 先番地には元番地の駒種を代入
            if SasiteItiji[index][5] == 10 then -- 成る処理
                HaitiYomi[SasiteItiji[index][3]] = HaitiYomi[SasiteItiji[index][3]] + 10
            end
            if SasiteItiji[index][4] ~= 0 then -- 駒をとるとき
                if SasiteItiji[index][4] <= 200 then -- 先手の駒をとるとき
                    HaitiYomi[SasiteItiji[index][4] + 90 - 71] =
                        HaitiYomi[SasiteItiji[index][4] + 90 - 71] + 1
                end
                if SasiteItiji[index][4] >= 200 then -- 後手の駒をとるとき
                    HaitiYomi[SasiteItiji[index][4] - 110 + 21] =
                        HaitiYomi[SasiteItiji[index][4] - 110 + 21] + 1
                end
            end
        end
    end

end

-- 現在の盤面HaitiGenzaiの2手先を読む関数
-- 1手先の盤面HaitiYomiの1手先を読む
-- SasiteYomi[引数index]のindexの指し手をHaitiYomi2に入れる
function Yomu2(index)
    HaitiYomi2 = {unpack(HaitiYomi)} -- 配置読み
    -- テーブルをコピーするときunpackを使わないと連動する。{　}を忘れずに。
    if SasiteYomi[index][1] ~= 999 then
        if SasiteYomi[index][1] ~= 200 or SasiteYomi[index][1] ~= -200 then -- 打たないとき
            HaitiYomi2[SasiteYomi[index][1]] = 0 -- 元番地には空である0を代入
            HaitiYomi2[SasiteYomi[index][3]] = SasiteYomi[index][2] -- 先番地には元番地の駒種を代入
            if SasiteYomi[index][5] == 10 then -- 成る処理
                HaitiYomi2[SasiteYomi[index][3]] =
                    HaitiYomi2[SasiteYomi[index][3]] + 10
            end
            if SasiteYomi[index][4] ~= 0 then -- 駒をとるとき
                if SasiteYomi[index][4] <= 200 then -- 先手の駒をとるとき
                    HaitiYomi2[SasiteYomi[index][4] + 90 - 71] =
                        HaitiYomi2[SasiteYomi[index][4] + 90 - 71] + 1
                end
                if SasiteYomi[index][4] >= 200 then -- 後手の駒をとるとき
                    HaitiYomi2[SasiteYomi[index][4] - 110 + 21] =
                        HaitiYomi2[SasiteYomi[index][4] - 110 + 21] + 1
                end
            end
        end
    end

end

-- ここから。ADD:3手先読みミニマックス法　2020-11-21
-- テーブルは3次元。3手先まで。
-- 最大合法手局面（一番指しての多い局面）は593通り
-- 1手先の評価値の中での最大値（3手先の読みの最善手）
-- print( "1te,max: ",saizen3["index"], saizen3["hyouka"] )

-- テーブル内の最大値を求める関数
-- max（テーブル名）
-- 戻り値は、keyはindex値、valueは最大値
function max(table_name)
    if #table_name == 0 then return nil, nil end
    local key, value = 1, table_name[1]
    for i = 2, #table_name do
        if value < table_name[i] then key, value = i, table_name[i] end
    end
    return key, value
end

-- テーブル内の最小値を求める関数
-- min（テーブル名）
-- 戻り値は、keyはindex値、valueは最小値
function min(table_name)
    if #table_name == 0 then return nil, nil end
    local key, value = 1, table_name[1]
    for i = 2, #table_name do
        if value > table_name[i] then key, value = i, table_name[i] end
    end
    return key, value
end

-- 局面数 max593。デフォルト：150（luviで5秒）
kyokumen_suu = 10

-- 3手先の評価値を入れるテーブル
-- 行列の生成
hyouka_3tesaki = {}
-- 3手先までの指し手indexを入れるテーブル
-- (1手先[3]2手先[4]3手先[5]の場合、003004005)
-- 行列の生成
sasite_3tesaki = {}
-- 3手先の評価値と指し手indexを入れる
-- 1手先（自分）
for i = 1, kyokumen_suu do
    -- 1行目の作成
    hyouka_3tesaki[i] = {}
    sasite_3tesaki[i] = {}
    -- 2手先（相手）
    for j = 1, kyokumen_suu do
        -- 2行目の作成
        hyouka_3tesaki[i][j] = {}
        sasite_3tesaki[i][j] = {}
        -- 3手先（自分）
        for k = 1, kyokumen_suu do
            -- 「-10^4/2」から「10^4/2」までの乱数を入れる
            hyouka_3tesaki[i][j][k] = math.random(1, 10 ^ 4) - 10 ^ 4 / 2
            sasite_3tesaki[i][j][k] = string.format("%03d%03d%03d", i, j, k)
        end
    end
end

-- 2手先評価値を入れるテーブル
-- (3手先index評価値)
-- 行列の生成
hyouka_2tesaki = {}
-- 2手先までの指し手に、3手先までのindexを入れるテーブル
-- (1手先[3]2手先[4]で、3手先のmaxのindexが5の場合、003004005)
-- 行列の生成
sasite_2tesaki = {}
-- 2手先の評価値と指し手indexを入れる。
-- 3手先の評価値をmaxでふるいにかける。
-- 1手先（自分）
for i = 1, kyokumen_suu do
    -- 1行目の作成
    hyouka_2tesaki[i] = {}
    sasite_2tesaki[i] = {}
    -- 2手先（相手）
    for j = 1, kyokumen_suu do
        hyouka_2tesaki[i][j] = {}
        sasite_2tesaki[i][j] = {}
        -- 3手先の評価値のmaxを2手先に入れる。
        -- hyouka_2tesakiには評価値のみを入れる。
        index3, value3 = max(hyouka_3tesaki[i][j])
        hyouka_2tesaki[i][j] = value3
        -- sasite_2tesakiにはsasite_3tesaki[x][y][z]を入れる
        -- 例）sasite_3tesaki[1][2][3]の場合
        -- 　　001002003
        -- sasite_2tesaki[i][j] = string.format("%03d%03d%03d",i,j,index3)
        sasite_2tesaki[i][j] = sasite_3tesaki[i][j][index3]
    end
end

-- 1手先評価値を入れるテーブル
-- (3手先index評価値)
-- 行列の生成
hyouka_1tesaki = {}
-- 1手先までの指し手に、3手先までのindexを入れるテーブル
-- (1手先[3]で、3手先のmaxのindexが5、2手先のminのindexが4の場合、003004005)
-- 行列の生成
sasite_1tesaki = {}
-- 1手先の評価値と指し手indexを入れる。
-- 2手先の評価値をminでふるいにかける。
-- 1手先（自分）
for i = 1, kyokumen_suu do
    -- 1行目の作成
    hyouka_1tesaki[i] = {}
    sasite_1tesaki[i] = {}
    -- 2手先の評価値のminを1手先に入れる。
    -- hyouka_1tesakiには評価値のみを入れる。
    index2, value2 = min(hyouka_2tesaki[i])
    hyouka_1tesaki[i] = value2
    -- sasite_1tesakiにはsasite_3tesaki[x][y][z]を入れる
    -- 例）sasite_3tesaki[1][2][3]の場合
    -- 　　001002003
    sasite_1tesaki[i] = sasite_2tesaki[i][index2]
end

-- 1手先の評価値の中での最大値
index1, value1 = max(hyouka_1tesaki)
-- 3手先の読みでの最善手（評価値、手筋index）
saizen3 = {}
saizen3["hyouka"] = value1
saizen3["index"] = sasite_1tesaki[index1]

-- ここまで。ADD:3手先読みミニマックス法　2020-11-21

function main() end

-- ここから
print("動作確認する場合は「a」を入力してください")
TourokuMati() -- USIエンジン登録
BanmenSyokika() -- 盤面の初期化
StaPosHaiti() -- HaitiGenzaiにStartPos配置にする
UgokeruTe() -- 動ける手を準備する関数
NyuryokuMati() -- 将棋所からのコマンド待ちの関数

print("end")
