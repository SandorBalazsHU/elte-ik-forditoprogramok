
A beadandóhoz használandó programozási nyelv leírása (While, 2019 tavasz)

A félév során az alábbi programozási nyelvhez kell fordítóprogramot írni flex és bisonc++ segítségével.

A nyelv az oktatási célokra gyakran felhasznált While nyelv egy változata.

Az alábbi példaprogram a bemeneten kapott nemnegatív egész szám legkisebb valódi osztóját számolja ki.

Tesztfájlok letölthetőek!

program oszto
  natural a;
  natural i;
  natural oszto;
  boolean vanoszto;
begin
  read( a );
  vanoszto := false;
  i := 2;
  while not vanoszto and i < a do
    if a mod i = 0 then
      vanoszto := true;
      oszto := i;
    endif
    i := i+1;
  done
  if vanoszto then
    write( vanoszto );
    write( oszto );
  else
    write( vanoszto );
  endif
end

A nyelv definíciója
Karakterek

A forrásfájlok a következő ASCII karaktereket tartalmazhatják:

    az angol abc kis és nagybetűi
    számjegyek (0-9)
    ():+-*<>=_;#
    szóköz, tab, sorvége
    megjegyzések belsejében pedig tetszőleges karakterek állhatnak

Minden más karakter esetén hibajelzést kell adnia a fordítónak, kivéve megjegyzések belsejében, mert ott tetszőleges karakter megengedett. A nyelv case-sensitive, azaz számít a kis és nagybetűk közötti különbség.
Kulcsszavak

A nyelv kulcsszavai a következők: program, begin, end, natural, boolean, true, false, div, mod, and, or, not, skip, if, then, else, elseif, endif, while, do, done, read, write
Azonosítók

A változók nevei betűkből, számjegyekből és _ jelből állhatnak, betűvel kell kezdődniük, és nem ütközhetnek egyik kulcsszóval sem.
Típusok

    natural: négy bájtos, előjel nélküli egészként kell megvalósítani; konstansai számjegyekből állnak és nincs előttük előjel
    boolean: egy bájton kell ábrázolni; értékei: false, true

Megjegyzések

A # karaktertől kezdve a következő # karakterig. Megjegyzések a program tetszőleges pontján előfordulhatnak, és tetszőleges számú sorra kiterjedhetnek. A fordítást és a keletkező programkódot nem befolyásolják.
A program felépítése

A program szignatúrából, deklarációs részből, törzsből és befejezésből áll. A szignatúra tartalma: program név, ahol a név tetszőleges azonosító. A szignatúrát a deklarációs rész követi, majd begin kulcsszó vezeti be a törzset. A deklarációs rész lehet üres is. A törzs legalább egy utasítást tartalmaz. A befejezést az end kulcsszó jelzi.
Változódeklarációk

Minden változót típus név ; alakban kell deklarálni, több azonos típusú változó esetén mindegyiket külön-külön.
Kifejezések

    natural típusú kifejezések: számkonstansok, natural típusú változók és az ezekből a + (összedás), - (kivonás), * (szorzás), div (egészosztás), mod (maradékképzés) infix operátorokkal és zárójelekkel felépített kifejezések.
    boolean típusú kifejezések: true és false, boolean típusú változók, és két natural típusú kifejezésből az = (egyenlőség), < (kisebb), > (nagyobb) infix operátorral, valamint a boolean típusú kifejezésekből az and (konjunkció), or (diszjunkció), = (egyenlőség) infix és a not (negáció) prefix operátorral és zárójelekkel felépített kifejezések.
    Az infix operátorok mind balasszociatívak és a precedenciájuk növevő sorrendben a következő:
        and or
        =
        < >
        + -
        * div mod

Utasítások

    skip utasítás: a változók értékeinek megváltoztatása nélküli továbblépés.
    Értékadás: az := operátorral. Baloldalán egy változó, jobboldalán egy - a változóéval megegyező típusú - kifejezés állhat.
    Olvasás: A read( változó ); utasítás a megadott változóba olvas be egy megfelelő típusú értéket a konzolról. (Megvalósítása: meg kell hívni a be_egesz (vagy a be_logikai) eljárást, amit a 4. beadandó leírásához mellékelt C fájl tartalmaz. A beolvasott érték natural típus esetén az eax, logikai típus esetén az al regiszterben lesz.)
    Írás: A write( kifejezés ); utasítás a megadott kifejezés értékét a képernyőre írja (és egy sortöréssel fejezi be). (Megvalósítása: meg kell hívni a ki_egesz (vagy a ki_logikai) eljárást, amit a 4. beadandó leírásához mellékelt C fájl tartalmaz. Paraméterként a kiírandó értéket (mindkét esetben 4 bájtot) kell a verembe tenni.)
    While ciklus: while feltétel do utasítások done A feltétel logikai kifejezés, a ciklusmag legalább egy utasítást tartalmaz. A megszokott módon, elöltesztelős ciklusként működik.
    Elágazás: if feltétel then utasítások elseif feltétel then utasítások … else utasítások endif alakú. A feltételek logikai kifejezések, az ágak legalább egy utasítást tartalmaznak. Elseif ágból akárhány lehet (akár nulla is), az else ágból legfeljebb egy lehet, de el is hagyható. Az elágazások a megszokott módon működnek.

