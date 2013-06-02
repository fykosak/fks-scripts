#!/bin/bash

# seznam zkratek, za kterými má být vlnka
ZKRAT="tj. tzn. tzv. pozn. např. popř. př. kupř. č. obr."

# seznam slov před a za matematikou
PZMAT="
	bod bodu bode bodě bodem body bodů bodům body bodech
	úhel úhlu úhel úhle úhlem úhlů úhlům úhly úhlech
	vzdálenost vzdálenosti vzdáleností vzdálenostem vzdálenostech vzdálenostmi
	síla síly síle sílu sílo silou sílou síly sil silám sílám silách sílách silami sílami
	moment momentu momente momentě momentem momenty momentů momentům momentech
	velikost velikosti velikostí velikostem velikostech velikostmi
	vztah vztahu vztahem vztahy vztahů vztahům vztazích
	vzorec vzorce vzorci vzorcem vzorců vzorcům vzorcích
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
	je
	jsou
"

PRMAT="$PZMAT
	podělíme
	vydělíme
	přičteme
	položíme
	označíme
	číselně
	dosazení
	rovno rovna rovná rovny rovnají
	tedy
	na
"

# seznam slov za matematikou
ZAMAT="$PZMAT
	je jsou
"

# seznam názvů odkazů, za kterými má být vlnka
PRODK="
	obrázek obrázku obrázky obrázkům
	tabulka tabulce tabulky tabulkách tabulkám
"

for file in "$@"
do

	# vlna - jednopísmenová slova na konci řádku
	/usr/bin/vlna -l -n -s -m -r -v aAiIkKoOsSuUvVzZ "$file"
	
	# kolem pomlčky
	for slovo in "--"
	do
		sed -r -i -e "N;s/([[:alpha:]])[ \n\t]+--[ \n\t]+([[:alpha:]])/\1~--~\2/g;P;D;" "$file"
	done
	
	# zkratky
	for slovo in $ZKRAT
	do
		sed -r -i -e "N;s/([ \n\t~]+$slovo)([ \n\t]+)[\$]/\2\1~\$/g;P;D;" "$file"
	done
	
	# před matematikou
	for slovo in $PRMAT
	do
		sed -r -i -e "N;s/([ \n\t~]+$slovo)([ \n\t]+)[\$]/\2\1~\$/g;P;D;" "$file"
	done

	# za matematikou
	for slovo in $ZAMAT
	do
		sed -r -i -e "N;s/[\$]([ \n\t]+)($slovo[ \n\t~]+)/\$~\2\1/g;P;D;" "$file"
	done
	
	# před odkazy
	for slovo in $PRODK
	do
		sed -r -i -e "N;s/([ \n\t~]+$slovo)[ \n\t~]+\ref/\1~\ref/g;P;D;" "$file"
		sed -r -i -e "N;s/([ \n\t~]+$slovo)[ \n\t~]+\([ \n\t~]\ref/\1~\(\ref/g;P;D;" "$file"
		sed -r -i -e "N;s/([ \n\t~]+$slovo)[ \n\t~]+\eqref/\1~\eqref/g;P;D;" "$file"
	done
	
	# opravit násobné vlnky a mezery kolem nich
	sed -r -i -e ";s/~{2,}/~/g" "$file"
	sed -r -i -e ";s/ +~/~/g" "$file"
	sed -r -i -e ";s/~ +/~/g" "$file"
	
done