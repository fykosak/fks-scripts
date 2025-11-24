#!/bin/bash

# seznam zkratek, za kterými má být vlnka
ZKRATCZ="
	tj. tzn. tzv. pozn. pozn.: např. např.: popř. př. kupř. č. obr. resp.
"
ZKRATSK="
	tj. tzn. tzv. pozn. pozn.: napr. napr.: popr. pr. kupr. č. obr. resp.
"

ZKRATEN="
	i.e. e.g.
"

# seznam slov před a za matematikou
PZMATCZ="
	bod bodu bode bodě bodem body bodů bodům body bodech
	čas času čase časem časy časů časům časech
	číslo čísla číslu čísle číslem čísel číslům číslech čísly
	definovat definujeme definujme definovali definice definicí
	délka délky délce délku délko délkou délek délkám délkách délkami dlouhý dlouhá dlouhé
	doba doby době dobu dobo době dobou dob dobám dobách dobami
	energie energii energií energiím energiích energiemi
	existuje
	exponent exponentu exponente exponentem exponenty exponentům exponentech
	frekvence  frekvenci frekvencí frekvencím frekvencích frekvencemi
	hloubka hloubky hloubce hloubku hloubko hloubce hloubkou hloubek hloubkám hloubkách hloubkami hluboký hluboká hluboké
	hmotnost hmotnosti hmotností hmotnostem hmotnostech hmotnostmi
	hodnota hodnoty hodnotě hodnotu hodnoto hodnotou hodnot hodnotám hodnotách hodnotami
	hrana hrany hraně hranu hrano hranou hran hranám hranách hranami
	hustota hustoty hustotě hustotu hustoto hustotou hustot hustotám hustotách hustotami
	hybnost hybnosti hybností hybnostem hybnostech hybnostmi
	index indexu indexe indexem indexy indexům indexech
	interval intervalu intervale intervalem intervaly intervalů intervalům intervalech
	je bude
	jej ho
	jsou
	kladný kladná kladné kladnému kladným kladných
	konstanta konstanty konstantě konstantu konstanto konstantou konstant konstantám konstantách konstantami
	moment momentu momente momentě momentem momenty momentů momentům momentech
	náboj náboje náboji nábojem nábojům nábojích náboji
	napětí napětím napětích napětími
	kapacita kapacity kapacitě kapacitu kapacitou kapacity kapacit kapacitám kapacitách kapacitami
	neplatí
	neznámá neznámé neznámou neznámými neznámým
	objem objemu objeme objemem objemy objemů objemům objemech
	parametr parametru parametre parametrem parametry parametrům parametrech
	platí platit
	podíl podílu podíle podílem podíly podílů podílům podílech
	pole polí poli polem polím polích
	poloha polohy poloze polohu poloho polohou poloh polohám polohách polohami
	poloměr poloměru poloměre poloměrem poloměry poloměrů poloměrům poloměrech
	proměnná proměnné proměnnou proměnných proměnným proměnnými
	proud proudu proude proudem proudy proudů proudům proudech
	průměr průměru průměre průměrem průměry průměrů průměrům průměrech
	průmět průmětu průměte průmětem průměty průmětům průmětech
	přepočet přepočtu přepočte přepočtem přepočty přepočtů přepočtům přepočtech
	rovnice rovnici rovnicí rovnic rovnicích rovnicemi
	rovnost rovnosti rovností rovnostem rovnostech rovnostmi
	rozdíl rozdílu rozdíle rozdílem rozdíly rozdílů rozdílům rozdílech
	rozměr rozměru rozměre rozměrem rozměry rozměrů rozměrům rozměrech
	rychlost rychlosti rychlostí rychlostem rychlostech rychlostmi
	síla síly síle sílu sílo silou sílou síly sil silám sílám silách sílách silami sílami
	sklon sklonu sklone sklonem sklony sklonů sklonům sklonech
	složka složky složce složku složko složkou složek složkách složkami
	svítivost
	směr směru směre směrem směry směrů směrům směrech
	součet součtu součte součtem součty součtů součtům součtech
	součin součinu součine součinem součiny součinů součinům součinech vynásobení vynásobené vynásobená vynásobena
	souřadnice souřadnici souřadnicí souřadnic souřadnicím souřadnicích souřadnicemi
	strana strany straně stranu strano stranou stran stranám stranách stranami
	střed středu střede středem středy středů středům středech
	substituce substituci substitucí substitucím substitucích substitucemi
	šířka šířky šířce šířku šířko šířkou šířek šířkám šířkách šířkami široký široká široké širokou
	teplota teploty teplotě teplotu teploto teplotou teplot teplotám teplotách teplotami
	tlak tlaku tlakem tlaky tlaků tlakům tlacích
	tloušťka tloušťky tloušťce tloušťku tloušťko tloušťkou tlouštěk tloušťkám tloušťkách tloušťkami
	trvat trvá trvalo trvala
	úhel úhlu úhel úhle úhlem úhlů úhlům úhly úhlech
	veličina veličiny veličině veličinu veličino veličinou veličin veličinám veličinách veličinami
	velikost velikosti velikostí velikostem velikostech velikostmi
	vychází
	vyjde
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	výkon výkonu výkonem
	výška výšky výšce výšku výško výškou výšky výšek výškám výškách výškami vysoký vysoká vysoké
	vzdálenost vzdálenosti vzdáleností vzdálenostem vzdálenostech vzdálenostmi vzdálen vzdálena vzdáleno
	vzorec vzorce vzorci vzorcem vzorců vzorcům vzorcích
	vztah vztahu vztahem vztahy vztahů vztahům vztazích
	záporný záporná záporné zápornému záporným záporných
	zrychlení zrychlením zrychleních zrychleními
	intenzita intenzity intenzitě intenzitou
	perioda periody periodou
	odpor odporu odporem odpory odporů odporům odporech
	průtok průtoku průtokem průtoky průtoků průtokům průtocích
	tuhost tuhosti tuhostí tuhostech tuhostmi
	tok toku tokem toky toků tokům tocích
	práci práce
	teplo tepla teplu teple teplem
	změna změny změně změnou změn změnám změnách změnami
	dráha dráhu dráhy dráze dráhou drah drahám drahách dráhami
	plocha plochy ploše plochou ploch plochám plochách plochami
	výchylka výchylky výchylce výchylku výchylce výchylkou výchylek výchylkám výchylkách výchylkami
	podstava podstavy podstavám podstav
	tření
	polarice
	násobek
	záření
	amplituda amplitudy amplitudě amplitudu amplitudou amplitud amplitudám amplitudách amplitudami
"

PZMATSK="
	bod bodu bode bode bodom body bodov bodom body bodoch
	čas času čase časom časy časov časom časoch
	číslo čísla číslu čísle číslom čísel číslam číslach číslami
	definovať definujeme definujme definovali definície definíciou
	dĺžka dĺžky dĺžke dľžka dľžka dľžka dĺžok dĺžkam dĺžkach dĺžkami dlhý dlhá dlhé
	čas doby dobe dobu dobo dobe dobou čias dobám dobách dobami
	energie energiu energiou energiám energiách energiami
	existuje
	exponent exponentu exponente exponentom exponentov exponentom exponentoch
	frekvencia frekvenciu frekvenciou frekvenciám frekvenciách frekvenciami
	hĺbka hĺbky hĺbke hĺbku hĺbko hĺbke hĺbkou hĺbok hĺbkam hĺbkach hĺbkami hlboký hlboká hlboké
	hmotnosť hmotnosti hmotnosťou hmotnosť hmotnosť hmotnosťami
	hodnota hodnoty hodnote hodnota Hodnota hodnotou hodnôt hodnotám hodnotách hodnotami
	hrana hrany hrane hranu hrano hranou hrán hranám hranách hranami
	hustota hustoty hustote hustotu hustoty hustotou hustôt hustoty hustotách hustotami
	hybnosť hybnosti hybnosťou hybnosť hybnosť hybnosť
	index Index Index indexom indexy indexom indexoch
	interval intervalu intervale intervalom intervaly intervalov intervalom intervaloch
	ich bude
	ho ho
	sú
	kladný kladná kladné kladnému kladným kladných
	konštanta konštanty konštante konštantu konštanty konštantou konštánt konštantám konštantách konštantami
	moment momentu momente momente momentom momenty momentov momentom momentoch
	náboj náboja náboji nábojom nábojom nábojoch nábojmi
	napätie napätím napätiach napätiami
	neplatí
	neznáma neznáme neznámu neznámymi neznámym
	objem objemu objem objemom objemy objemov objemom objemoch
	parameter parametra parametre parametrom parametrami parametrom parametroch
	platí platiť
	podiel podielu Podiel Podiel podiely podielov podielom podieloch
	pole polí poli poľom poliam poliach
	poloha polohy polohe polohu Position Umiestnenie polôh polohám polohách polohami
	polomer polomeru polomer polomerom polomery polomerov polomerom polomeroch
	premenná premenné premennou premenných premenným premennými
	prúd prúdu Prúd prúdom prúdy prúdov prúdom prúdoch
	priemer priemeru Rozmer Rozmer priemery priemerov priemerov priemeroch
	priemet priemetu priem priemetom priemety priemetom Priemet
	prepočet prepočte prepočíta prepočtom prepočty prepočtov prepočtom prepočtoch
	rovnice rovnicu rovnicou rovníc rovniciach rovnicami
	rovnosť rovnosti rovnosťou rovnosť rovnosť rovnosť
	rozdiel rozdielu Rozdiel Rozdiel rozdiely rozdielov rozdielom rozdieloch
	rozmer rozmeru rozmery Rozmery rozmery rozmerov rozmerom rozmeroch
	rýchlosť rýchlosti rýchlosťou rýchlostiam rýchlostiach rýchlosťami
	sila sily sile silu sila silou silou sily síl silám silám silách hrúbkach silami silami
	sklon sklonu sklon sklonom sklony sklonov sklonom sklonoch
	zložka zložky zložke zložku zložku zložkou zložiek zložkách zložkami
	smer smeru smere smerom smermi smerov líniám smeroch
	súčet súčtu súčtom súčty súčtov súčtov súčtoch
	súčin súčinu súčin súčinom súčiny súčinov součinům kombináciách vynásobení vynásobenej vynásobená vynásobená
	súradnice súradnicu súradnicou súradníc súradniciam súradniciach súradnicami
	strana strany strane strana Strana stranou strán stranám stranách stranami
	stred stredu strede stredom stredy stredov stredom stredoch
	substitúcia substitúciu substitúciou substitucím substitúciou substitúciami
	šírka šírky šírke šírku šírka šírka šírok šírkam šírkach šírkami široký široká široké
	teplota teploty teplote teplotu Teplota Teplota teplôt teplotám teplotách teplotami
	tlak tlaku tlakem tlaky tlakov tlakom tlakoch
	hrúbka hrúbky hrúbke hrúbku hrúbku hrúbkou hrúbok hrúbkam hrúbkach hrúbkami
	trvať trvá trvalo trvala
	uhol uhla uhol uhla uhlom uhlov uhlom uhly uhloch
	veličina veličiny veličine veličinu veličiny veličinou veličín veličinám veličinách veličinami
	veľkosť veľkosti veľkostí veľkostiam veľkostiach veľkosťami
	vychádza
	vyjde
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	výška výšky výške výška výška výška výška výšok výškam výškach výškami vysoký vysoká vysoké
	vzdialenosť vzdialenosti vzdialenosťou vzdialenostiam vzdialenostiach vzdialenosťami
	vzorec vzorca vzorcu vzorci vzorcom vzorcov vzorcom vzorkách
	vzťah vzťahu vzťahom vzťahy vzťahov vzťahom vzťahoch
	záporný záporná záporné zápornému záporným záporných
	zrýchlenie zrýchlením zrýchleniach zrýchleniami
	obsah obsahu obsahy obsahů obsahům obsazích
	koeficient koeficientu koeficienty koeficientů koeficientům koeficientech
	částice částici částicí částicím částicích částicemi
	příkon příkonu příkonem příkony příkonů příkonům příkonech
"

PZMATEN="
	is represents mass weight height width velocity time length angle constant constants unit
	rate charge pressure voltage voltages rezistance variable variables ratio
	current axis frequency radius distance distances approximation area density depth
	speed capacitance amplitude amplitudes inductance period coordinate term
	volume volumes field fields quantity surface acceleration temperature
	thickness heat torque coefficients coefficient diameter path flow number
	relation relations force direction substitute function functions power approximately
	deflection remaining trajectory tension radiation substitution substitutes long
	energy energies system systems reaction magnitude stiffness becomes
"

# seznam slov před matematikou
PRMATCZ="
	asi
	až
	být
	cca
	číselně
	do
	dosadíme dosadili
	dosazení
	dosazení dosazením
	jako
	na
	než
	od
	označíme označili značí značíme označme
	pak
	podělíme podělili
	položíme položili
	pomocí
	porovnáme porovnali
	pro
	průměrně
	předpoklad
	přesně přesněji nejpřesněji přesnější nejpřesnější
	přibližně
	přičteme přičetli
	přičemž
	psát
	rok roku roce rokem roky roků rokům rocích
	rovno rovna rovná rovny rovnají
	různý
	skoro
	tedy
	téměř
	uvažovat uvažujeme uvažujme
	volíme zvolíme zvolili zvolme
	vydělíme vydělili
	vyjádříme vyjádřili vyjádřením vyjádření vyjádřeními
	výsledek výsledku výsledkem výsledky výsledků výsledkům výsledcích
	za
	zároveň
	zhruba
	že
	osa osách osy ose osu osou os osám osách osami
	rovina roviny rovině rovinu rovinou roviny rovin rovinám rovinách rovinami
	jednotka jednotkou jednotek
	měří měříme měříte
	naměřím naměříš naměří naměříme naměříte
	reakci
	rozdělení rozdělením rozděleních
	je bude byl byla bylo
	váží vážící
	podmínka podmínky podmínce podmínku podmínkou podmínek podmínkám podmínkách podmínkami
	vyjádřit vyjádřil vyjádřila vyjádřila vyjádřili
"

PRMATSK="
	asi
	byť
	cca
	číselne
	do
	dosadíme dosadili
	dosadení
	dosadení dosadením
	ako
	na
	než
	od
	označíme označili značí značíme označme
	potom
	podelíme podelili
	položíme položili
	pomocou
	porovnáme porovnali
	pre
	priemerne
	predpoklad
	presne presnejšie najpresnejšie presnejšie najpresnejší
	približne
	prirátame pripočítali
	písať
	rok roka roku rokom roky rokov rokom rokoch
	presne rovná rovná rovny rovnajú
	rôzny
	skoro
	teda
	takmer
	uvažovať uvažujeme uvažujme
	volíme zvolíme zvolili zvoľme
	vydelíme vydelili
	výsledok výsledku výsledkom výsledky výsledkov výsledkom výsledkoch
	za
	zároveň
	zhruba
	že
"

PRMATEN="
	of as derive by to at get for about from than be so with express is was weigh weighs weighing
	travels travel denote denotes lands value values
"

# seznam slov za matematikou
ZAMATCZ="
	je jsou
	jeho její
	značí
"
ZAMATSK="
	je sú
	jeho jej
"

ZAMATEN=""

# seznam názvů odkazů, za kterými má být vlnka
PRODKCZ="
	dle
	podle
	rovnice rovnici rovnicí rovnic rovnicích rovnicemi
	tabulka tabulce tabulky tabulkách tabulkám
	viz
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	výraz výrazu výraze výrazem výrazy výrazů výrazům výrazech
	vzorec vzorce vzorci vzorcem vzorců vzorcům vzorcích
	vztah vztahu vztahem vztahy vztahů vztahům vztazích
	obrázek obrázku obrázky obrázkům
"
PRODKSK="
	podľa
	podľa
	rovnice rovnicu rovnicou rovníc rovniciach rovnicami
	tabuľka tabuľke tabuľky tabuľkách tabuľkám
	pozri
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	výraz výrazu výrazoch výrazom výrazy výrazov výrazom výrazoch
	vzorec vzorca vzorci vzorcom vzorcov vzorcom vzorkách
	vzťah vzťahu vzťahom vzťahy vzťahov vzťahom vzťahoch
	obrázok obrázku obrázky obrázkom
"

PRODKEN=""

# seznam slov před čísly
PRCISCZ="
	rok roku roka roce rokem roky roků rokům rocích
	den dne dni dnu dnem dny dnů dnům dnech
	do
	od
	po
	před
"
PRCISSK="
	rok roka roka roku rokom roky rokov rokom rokoch
	deň dňa dňu dnu dňom dni dní dňom dňoch
	do
	od
	po
	pred
"

PRCISEN=""

# názvy měsíců
MESICCZ="
	leden ledna lednu ledne lednem ledny lednů lednům lednech
	únor února únoru únore únorem únory únorů únorům únory únorech
	březen března březnu březne březnem březny březnům březnech březny
	duben dubna dubnu dubne dubnem dubnů dubnům dubnech dubny
	květen května květnu květne květnem květny květnů květnům květnech
	červen června červnu červne červnem červny červnů červnům červnech
	červenec července červenci červencem červenců červencům červencích červenci
	srpen srpna srpnu srpne srpnem srpny srpnů srpnům srpnech
	září zářím
	říjen října říjnu říjne říjnem říjny říjnů říjnům říjnech
	listopad listopadu listopade listopadem listopady listopadů listopadům listopadech
	prosinec prosince prosinci prosincem prosince prosinců prosincům prosincích prosinci
"
MESICSK="
	január januára januári januára januárom januára januára lednům januára
	február februára februári februára februárom Február Február únorům Február Február
	marec marca marci Brezeň marcom marca březnům marca marca
	apríl apríla apríli apríla aprílom apríla dubnům Dubno Dubno
	máj mája máji mája májom mája Kvetnej květnům Kvetnej
	jún júna júni Lipeň júnom júna júna červnům júna
	júl júla júli júlom júla červencům júla júli
	august augusta auguste augusta augustom augusta augusta srpnům augusta
	septembra septembrom
	október októbra októbri októbra októbrom októbra októbra říjnům októbra
	november novembra novembra novembra novembra listopadům novembra
	december decembra decembri decembrom decembra decembra prosincům decembra decembri
"

ZKRAT="$ZKRATCZ $ZKRATSK $ZKRATEN"
ZKRAT="$(echo $ZKRAT | sed -r -e 's/ +/|/g')"
ZKRAT="$(echo $ZKRAT | sed -r -e 's/\./[\.]/g')"
PRMAT="$PZMATCZ $PZMATSK $PZMATEN $PRMATCZ $PRMATSK $PRMATEN $ZKRATCZ $ZKRATSK $ZKRATEN"
PRMAT=$(echo $PRMAT | sed -r -e 's/[ \t]+/|/g')
ZAMAT="$PZMATCZ $PZMATSK $PZMATEN $ZAMATEN $ZAMATCZ $ZAMATSK"
ZAMAT=$(echo $ZAMAT | sed -r -e 's/[ \t]+/|/g')
PRODK="$PRODKCZ $PRODKSK $PRODKEN"
PRODK=$(echo $PRODK | sed -r -e 's/[ \t]+/|/g')
PRCIS="$PRCISCZ $PRCISSK $PRCISEN $MESICCZ $MESICSK"
PRCIS=$(echo $PRCIS | sed -r -e 's/[ \t]+/|/g')
MESIC="$MESICCZ $MESICSK"
MESIC=$(echo $MESIC | sed -r -e 's/[ \t]+/|/g')

# /^\s*%! -- ignoruj řádky, které začínají libovolným počtem mezer a procentem
#   => ignoruj řádkové komentáře s libovolným odsazením
for file in "$@"
do
	vlna -l -n -s -m -r -v aAiIkKoOsSuUvVzZ "$file" # vlna - jednopísmenová slova na konci řádku
	sed -r -i -e "/^\s*%/!s/([[:alpha:]])[ \n\t]+--[ \n\t]+([[:alpha:]])/\1~-- \2/gI;P;D;" "$file" # kolem pomlčky
	sed -r -i -e "s/~--~/~-- /g" "$file" # kolem pomlčky
  	sed -r -i -e "s/\xe2\x80\x94/---/g" "$file" # nahradit utf-8 pomlčku za tři spojovníky
	sed -r -i -e "/^[\s]*%/!N;s/([ \n\t~]+)($ZKRAT)([ \n\t]+)/\3\1\2~/gI;P;D;" "$file" # zkratky
	sed -r -i -e "/^[\s]*%/!N;s/([ \n\t~]+)($PRMAT)([ \n\t]+)[\$]/\3\1\2~\$/gI;P;D;" "$file" # před matematikou
	sed -r -i -e "/^[\s]*%/!N;s/([ \n\t~]+)($PRMAT)([ \n\t~]+)([[:alpha:]]+)([ \n\t]+)[\$]/\1\3\5\2\3\4~\$/gI;P;D;" "$file" # před matematikou + 1 další slovo
	sed -r -i -e "/^[\s]*%/!N;s/[\$]([ \n\t]+)($ZAMAT)([ \n\t~]+)/\$~\2\3\1/gI;P;D;" "$file" # za matematikou
	sed -r -i -e "/^[\s]*%/!N;s/([ \n\t~]+)($PRODK)[ \n\t~]+([\\]ref|[\\]eqref|\([\\]ref)/\1\2~\3/gI;P;D;" "$file" # před odkazy
	sed -r -i -e "/^[\s]*%/!N;s/([ \n\t~]+)($PRCIS)([ \n\t]+)([[:digit:]])/\3\1\2~\4/gI;P;D;" "$file" # před čísly
	sed -r -i -e "/^[\s]*%/!N;s/([[:digit:]]{1,2}\.)[ \n\t~]+([[:digit:]]{1,2}\.|$MESIC)[ \n\t~]+([[:digit:]]{4})/\1~\2~\3/gI;P;D;" "$file" # v datumech s rokem
	sed -r -i -e "/^[\s]*%/!N;s/([[:digit:]]{1,2}\.)[ \n\t~]+([[:digit:]]{1,2}\.|$MESIC)/\1~\2/gI;P;D;" "$file" # v datumech bez roku
	sed -r -i -e "/^[\s]*%/!N;s/\([\\]ref\{([^\}]*)\}\)/\\\eqref\{\1\}/gI;P;D;" "$file" # nahradit ošklivé odkazy na rovnice
	sed -r -i -e "/^[\s]*%/!N;s/(~){2,}/\1/gI;P;D;" "$file" # opravit násobné vlnky
	sed -r -i -e "/^[\s]*%/!N;s/[ \n\t]*~[ \n\t]*/~/gI;P;D;" "$file" # smazat mezery kolem vlnek
	sed -r -i -e "/^[\s]*%/!N;s/\n            /\n\t\t\t/gI;P;D;" "$file" # mezery na 3 odsazení
	sed -r -i -e "/^[\s]*%/!N;s/\n        /\n\t\t/gI;P;D;" "$file" # mezery na 2 odsazení
	sed -r -i -e "/^[\s]*%/!N;s/\n    /\n\t/gI;P;D;" "$file" # mezery na 1 odsazení
	sed -r -i -e "/^[\s]*%/!N;s/ {2,}/ /gI;P;D;" "$file" # opravit násobné mezery
	sed -r -i -e "/^[\s]*%/!N;s/ *\n/\n/gI;P;D;" "$file" # smazat mezery na konci řádku
	sed -r -i -e "/^[\s]*%/!N;s/\n */\n/gI;P;D;" "$file" # smazat mezery na začátku řádku
  	sed -r -i -e "s/\xe2\x80\x99/'/g" "$file" # nahradit jednoduchou uvozovku za apostrof
done

echo "Opravit dělení čísel:"
grep --color=always -nE '[[:digit:]]{4,}' $@ # vypsat všechny čtveřice čísel (pro oddělení po 3)
echo "Smazat spojovník před slovem krát:"
grep --color=always -nE '\-krát' $@ #  # vypsat výskyty spojovníku před slovem krát
