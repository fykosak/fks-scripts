#!/bin/bash

# seznam zkratek, za kterými má být vlnka
ZKRATCZ="
	tj. tzn. tzv. pozn. např. popř. př. kupř. č. obr.
"
ZKRATSK="
	tj. tzn. tzv. pozn. napr. popr. pr. kupr. č. obr.
"


# seznam slov před a za matematikou
PZMATCZ="
	bod bodu bode bodě bodem body bodů bodům body bodech
	úhel úhlu úhel úhle úhlem úhlů úhlům úhly úhlech
	sklon sklonu sklone sklonem sklony sklonů sklonům sklonech
	vzdálenost vzdálenosti vzdáleností vzdálenostem vzdálenostech vzdálenostmi
	síla síly síle sílu sílo silou sílou síly sil silám sílám silách sílách silami sílami
	moment momentu momente momentě momentem momenty momentů momentům momentech
	velikost velikosti velikostí velikostem velikostech velikostmi
	vztah vztahu vztahem vztahy vztahů vztahům vztazích
	vzorec vzorce vzorci vzorcem vzorců vzorcům vzorcích
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	rovnice rovnici rovnicí rovnic rovnicích rovnicemi
	rovnost rovnosti rovností rovnostem rovnostech rovnostmi
	energie energii energií energiím energiích energiemi
	hmotnost hmotnosti hmotností hmotnostem hmotnostech hmotnostmi
	rychlost rychlosti rychlostí rychlostem rychlostech rychlostmi
	zrychlení zrychlením zrychleních zrychleními
	hybnost hybnosti hybností hybnostem hybnostech hybnostmi
	součet součtu součte součtem součty součtů součtům součtech
	rozdíl rozdílu rozdíle rozdílem rozdíly rozdílů rozdílům rozdílech
	podíl posílu počíle podílem podíly podílů podílům podílech
	součin součinu součine součinem součiny součinů součinům součinech
	konstanta konstanty konstantě konstantu konstanto konstantou konstant konstanám konstantách konstantami
	exponent exponentu exponente exponentem exponenty exponentům exponentech
	číslo čísla číslu čísle číslem čísel číslům číslech čísly
	veličina veličiny veličině veličinu veličino veličinou veličin veličinám veličinách veličinami
	proměnná proměnné poměnnou proměnných proměnným proměnnými
	neznámá neznámé neznámou neznánými neznámým
	poloměr poloměru poloměre poloměrem poloměry poloměrů poloměrům poloměrech
	průměr průměru průměre průměrem průměry průměrů průměrům průměrech
	průmět průmětu průměte průmětem průměty průmětům průmětech
	délka délky délce délku délko délkou délek délkám délkách délkami dlouhý dlouhá dlouhé
	šířka šířky šířce šírku šířko šířkou šířek šířkám šířkách šířkami široký široká široké
	výška výšky výšce výšku výško výškou výšky výšek výškám výškách výškami vysoký vysoká vysoké
	hloubka hloubky hloubce hloubku hloubko hloubce hloubkou hloubek hloubkám hloubkách hloubkami hluboký hluboká hluboké
	hustota hustoty hustotě hustotu hustoto hustotou hustot hustotám hustotách hustotami
	napětí napětím napětích napětími
	proud proudu proude proudem proudy proudů proudům proudech
	náboj náboje náboji nábojem nábojům nábojích náboji
	čas času čase časem časy časů časům časech
	doba doby době dobu dobo době dobou dob dobám dobách dobami
	teplota teploty teplotě teplotu teploto teplotou teplot teplotám teplotách teplotami
	objem objemu objeme objemem objemy objemů objemům objemech
	je
	jsou
"

PZMATSK="
	bod bodu bode bode bodom body bodov bodom body bodoch
	uhol uhla uhol uhla uhlom uhlov uhlom uhly uhloch
	sklon sklonu sklon sklonom sklony sklonov sklonom sklonoch
	vzdialenosť vzdialenosti vzdialenosťou vzdialenostiam vzdialenostiach vzdialenosťami
	sila sily sile silu sila silou silou sily síl silám silám silách hrúbkach silami silami
	moment momentu momente momente momentom momenty momentov momentom momentoch
	veľkosť veľkosti veľkostí veľkostiam veľkostiach veľkosťami
	vzťah vzťahu vzťahom vzťahy vzťahov vzťahom vzťahoch
	vzorec vzorca vzorci vzorcom vzorcov vzorcom vzorkách
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	rovnice rovnicu rovnicou rovníc rovniciach rovnicami
	rovnosť rovnosti rovnosťou rovnosť rovnosť rovnosť
	energie energiu energiou energiám energiách energiami
	hmotnosť hmotnosti hmotnosťou hmotnosť hmotnosť hmotnosťami
	rýchlosť rýchlosti rýchlosťou rýchlostiam rýchlostiach rýchlosťami
	zrýchlenie zrýchlením zrýchleniach zrýchleniami
	hybnosť hybnosti hybnosťou hybnosť hybnosť hybnosť
	súčet súčtu Souci súčtom súčty súčtov súčtov súčtoch
	rozdiel rozdielu Rozdiel Rozdiel rozdiely rozdielov rozdielom rozdieloch
	podiel posilami počíle podielom podiely podielov podielom podieloch
	súčin súčinu súčin súčinom súčiny súčinov součinům kombináciách
	konštanta konštanty konštante konštantu konštanty konštantou konštánt konstanám konštantách konštantami
	exponent exponentu exponente exponentom exponentov exponentom exponentoch
	číslo čísla číslu čísle číslom čísel číslam číslach číslami
	veličina veličiny veličine veličinu veličiny veličinou veličín veličinám veličinách veličinami
	premenná premenné poměnnou premenných premenným premennými
	neznáma neznáme neznámu neznánými neznámym
	polomer polomeru polomer polomerom polomery polomerov polomerom polomeroch
	priemer priemeru Rozmer Rozmer priemery priemerov priemerov priemeroch
	priemet priemetu priem priemetom priemety priemetom Priemet
	dĺžka dĺžky dĺžke dľžka dľžka dľžka dĺžok dĺžkam dĺžkach dĺžkami dlhý dlhá dlhé
	šírka šírky šírke šírka šírka šírkou šírok šírkam šírkach šírkami široký široká široké
	výška výšky výške výška výška výška výška výšok výškam výškach výškami vysoký vysoká vysoké
	hĺbka hĺbky hĺbke hĺbku hĺbko hĺbke hĺbkou hĺbok hĺbkam hĺbkach hĺbkami hlboký hlboká hlboké
	hustota hustoty hustote hustotu hustoty hustotou hustôt hustoty hustotách hustotami
	napätie napätím napätiach napätiami
	prúd prúdu Prúd prúdom prúdy prúdov prúdom prúdoch
	náboj náboja náboji nábojom nábojom nábojoch nábojmi
	čas času čase časom časy časov časom časoch
	čas doby dobe dobu dobo dobe dobou čias dobám dobách dobami
	teplota teploty teplote teplotu Teplota Teplota teplôt teplotám teplotách teplotami
	objem objemu objem objemom objemy objemov objemom objemoch
	je
	sú
"

# seznam slov před matematikou
PRMATCZ="
	podělíme podělili
	vydělíme vydělili
	přičteme přičetli
	položíme položili
	označíme označili
	porovnáme porovnali
	číselně
	dosazení
	dosadíme dosadili
	rovno rovna rovná rovny rovnají
	tedy
	na
	pro
	asi
	zrhuba
	přibližně
	téměř
	skoro
	než
	průměrně
"
PRMATS="
	podelíme podelili
	vydelíme vydelili
	prirátame pripočítali
	položíme položili
	označíme označili
	porovnáme porovnali
	číselne
	dosadení
	dosadíme dosadili
	presne rovná rovná rovny rovnajú
	teda
	na
	pre
	asi
	zrhuba
	približne
	takmer
	skoro
	než
	priemerne
"

# seznam slov za matematikou
ZAMATCZ="
	je jsou
"
ZAMATSK="
	je sú
"

# seznam názvů odkazů, za kterými má být vlnka
PRODKCZ="
	obrázek obrázku obrázky obrázkům
	tabulka tabulce tabulky tabulkách tabulkám
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	vztah vztahu vztahem vztahy vztahů vztahům vztazích
	vzorec vzorce vzorci vzorcem vzorců vzorcům vzorcích
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	rovnice rovnici rovnicí rovnic rovnicích rovnicemi
	podle
	dle
	viz
"
PRODKSK="
	obrázok obrázku obrázky obrázkom
	tabuľka tabuľke tabuľky tabuľkách tabuľkám
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	vzťah vzťahu vzťahom vzťahy vzťahov vzťahom vzťahoch
	vzorec vzorca vzorci vzorcom vzorcov vzorcom vzorkách
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	rovnice rovnicu rovnicou rovníc rovniciach rovnicami
	podľa
	podľa
	pozri
"



ZKRAT="$ZKRATCZ $ZKRATSK"
ZKRAT="$(echo $ZKRAT | sed -r -e 's/ +/|/g')"
ZKRAT="$(echo $ZKRAT | sed -r -e 's/\./[\.]/g')"
PRMAT="$PZMATCZ $PZMATSK $PRMATCZ $PRMATSK"
PRMAT=$(echo $PRMAT | sed -r -e 's/ +/|/g')
ZAMAT="$PZMATCZ $PZMATSK $ZAMATCZ $ZAMATSK"
ZAMAT=$(echo $ZAMAT | sed -r -e 's/ +/|/g')
PRODK="$PRODKCZ $PRODKSK"
PRODK=$(echo $PRODK | sed -r -e 's/ +/|/g')

for file in "$@"
do
	vlna -l -n -s -m -r -v aAiIkKoOsSuUvVzZ "$file" # vlna - jednopísmenová slova na konci řádku
	sed -r -i -e "N;s/([[:alpha:]])[ \n\t]+--[ \n\t]+([[:alpha:]])/\1~--~\2/gI;P;D;" "$file" # kolem pomlčky
	sed -r -i -e "N;s/([ \n\t~]+)($ZKRAT)([ \n\t]+)/\3\1\2~/gI;P;D;" "$file" # zkratky
	sed -r -i -e "N;s/([ \n\t~]+)($PRMAT)([ \n\t]+)[\$]/\3\1\2~\$/gI;P;D;" "$file" # před matematikou
	sed -r -i -e "N;s/[\$]([ \n\t]+)($ZAMAT)([ \n\t~]+)/\$~\2\3\1/gI;P;D;" "$file" # za matematikou
	sed -r -i -e "N;s/([ \n\t~]+)($PRODK)[ \n\t~]+([\\]ref|[\\]eqref|\([\\]ref)/\1\2~\3/gI;P;D;" "$file" # před odkazy
	sed -r -i -e "N;s/~{2,}/~/gI;P;D;" "$file" # opravit násobné vlnky
	sed -r -i -e "N;s/[ \n\t]*~[ \n\t]*/~/gI;P;D;" "$file" # opravit mezery kolem vlnek
done