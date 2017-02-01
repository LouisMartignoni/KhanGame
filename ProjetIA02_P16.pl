/*declaration*/

board1([[2,3,1,2,2,3],[2,1,3,1,3,1],[1,3,2,3,1,2],[3,1,2,1,3,2],[2,3,1,3,1,3],[2,1,3,2,2,1]]).
board2([[2,2,3,1,2,2],[1,3,1,3,1,3],[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3]]).
board3([[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3],[3,1,3,1,3,1],[2,2,1,3,2,2]]).
board4([[1,2,2,3,1,2],[3,1,3,1,3,2],[2,3,1,2,1,3],[2,1,3,2,3,1],[1,3,1,3,1,2],[3,2,2,1,3,2]]).

/*affichage*/


parcoursli([],U,V).
parcoursli([T|Q],U,V):-test_affich(V,U),write(' ['),write(T),write(']| '),V1 is V+1,parcoursli(Q,U,V1).
parcourstab([],U,V).
parcourstab([T|Q],U,V):-write('     |       |       |       |       |       |       |'),nl,write('     |       |       |       |       |       |       |'),nl,write('     | '),parcoursli(T,U,V),
nl,write('     |       |       |       |       |       |       |'),nl,write('     |_______|_______|_______|_______|_______|_______|'),nl,U1 is U-1,parcourstab(Q,U1,V).
par1(_):-board1(X),write('     ________________________________________________'),nl,parcourstab(X,6,1).
par2(_):-board2(X),write('     ________________________________________________'),nl,parcourstab(X,6,1).
par3(_):-board3(X),write('     ________________________________________________'),nl,parcourstab(X,6,1).
par4(_):-board4(X),write('     ________________________________________________'),nl,parcourstab(X,6,1).
test(1):- par1(_),board1(X).
test(2):- par2(_),board2(X).
test(3):- par3(_),board3(X).
test(4):- par4(_),board4(X).

:-dynamic(cote/1).

test_affich(X,Y):-pions1(X,Y),write('P1'),!.      /*ansi_format([bold,hfg(red)], 'P1', [P1]) pour mettre en couleur*/
test_affich(X,Y):-pions2(X,Y),write('P2'),!.       /*ansi_format([bold,fg(yellow)], 'P2', [P2])*/
test_affich(X,Y):-kalista1(X,Y),write('K1'),!.     /*ansi_format([bold,hfg(red)], 'K1', [K1])  */
test_affich(X,Y):-kalista2(X,Y),write('K2'),!.     /*ansi_format([bold,fg(yellow)], 'K2', [K2])  */
test_affich(X,Y):-write('  ').


/* liste des pions qu'on modifiera dynamiquement*/

:- dynamic(khan/1).
khan(0).

:- dynamic(moveposs1/1).

:- dynamic(moveposs2/1).

:- dynamic(khanreel/1).


/*modifie la valeur du khan*/
replaceKhan(L):- khan(X),retract(khan(X)), asserta(khan(L)).

:- dynamic(pions1/2).
pions1(0,0).
pions1(0,0).
pions1(0,0).
pions1(0,0).
pions1(0,0).
pions1(0,0).
:-dynamic(kalista1/2).
kalista1(0,0).


:- dynamic(pions2/2).
pions2(0,0).
pions2(0,0).
pions2(0,0).
pions2(0,0).
pions2(0,0).
pions2(0,0).
:-dynamic(kalista2/2).
kalista2(0,0).

:- dynamic(listepos1/2).

:- dynamic(listepos2/2).

:- dynamic(poskalista1/2).

:- dynamic(poskalista2/2).

:- dynamic(listeKill1/1).

:- dynamic(listeKill1pos/1).

:- dynamic(listeKill1valid/1).

:- dynamic(randcoord/1).

:- dynamic(respos2/1).

afficher_plat(X):-test(X).

/*retire la kalista ou un pion*/

enlever1(X,Y):-retract(pions1(X,Y)),!.
enlever1(X,Y):-retract(kalista1(X,Y)).

ajouter1(X,Y):-not(kalista1(_,_)),asserta(kalista1(X,Y)),retractall(poskalista1([_,_])),asserta(poskalista1([X,Y])),!.
ajouter1(X,Y):-asserta(pions1(X,Y)),!.

enlever2(X,Y):-retract(pions2(X,Y)),!.
enlever2(X,Y):-retract(kalista2(X,Y)),!.

ajouter2(X,Y):-not(kalista2(_,_)),asserta(kalista2(X,Y)),retractall(poskalista2([_,_])),asserta(poskalista2([X,Y])),!.
ajouter2(X,Y):-asserta(pions2(X,Y)),!.




/*fin de partie*/
termine(_):-not(kalista1(_,_)).
termine(_):-not(kalista2(_,_)).

victoireRouge(_):-termine(_),kalista1(_,_),nl,write('Victoire du joueur Rouge'). /*Rouge est joueur 1 donc*/
victoireOcre(_):-termine(_),kalista2(_,_),nl,write('Victoire du joueur Ocre').


/*placement pieces*/
placement_j1(0,X):-choix_coordk1(_).
placement_j1(N,X):-N>0,N1 is N-1,nl,afficher_plat(X),nl,choix_coord1(_),placement_j1(N1,X).
choix_coord1(_):-write('Piece j1: largeur:'),read(A),write('Piece j1: hauteur:'),read(B),test_insert1(A,B,_).
test_insert1(_,B,Y):-B>2,write('placement impossible'),nl,choix_coord1(_),!.
test_insert1(A,B,Y):-B<3,occupe(A,B),write('place occupée veuillez essayer a nouveau'),nl,choix_coord1(_).
test_insert1(A,B,Y):-B<3,libre(A,B),retract(pions1(0,0)),asserta(pions1(A,B)),Y=[A,B],asserta(listepos1(Y)),write('piece placée'),nl,!.

placement_j2(0,X):-choix_coordk2(_),afficher_plat(X).
placement_j2(N,X):-N>0,N1 is N-1,nl,afficher_plat(X),nl,choix_coord2(_),placement_j2(N1,X).
choix_coord2(_):-write('Piece j2: largeur:'),read(A),write('Piece j2: hauteur:'),read(B),test_insert2(A,B,_).
test_insert2(_,B,Y):-B<5,write('placement impossible'),nl,choix_coord2(_),!.
test_insert2(A,B,Y):-B>4,occupe(A,B),write('place occupée veuillez essayer a nouveau'),nl,choix_coord2(_).
test_insert2(A,B,Y):-B>4,libre(A,B),retract(pions2(0,0)),asserta(pions2(A,B)),Y=[A,B],asserta(listepos2(Y)),write('piece placée'),nl,!.

choix_coordk1(_):-write('kalista1 j1: largeur:'),read(A),write('kalista1 j1: hauteur:'),read(B),test_insertk1(A,B,_).
test_insertk1(_,B,Y):-B>2,write('placement impossible'),nl,choix_coordk1(_),!.
test_insertk1(A,B,Y):-B<3,occupe(A,B),write('place occupée veuillez essayer a nouveau'),nl,choix_coordk1(_).
test_insertk1(A,B,Y):-B<3,libre(A,B),retract(kalista1(0,0)),asserta(kalista1(A,B)),Y=[A,B],asserta(listepos1(Y)),asserta(poskalista1(Y)),write('kalista1 placée'),nl,!.

choix_coordk2(_):-write('kalista2 j2: largeur:'),read(A),write('kalista2 j2: hauteur:'),read(B),test_insertk2(A,B,_).
test_insertk2(_,B,Y):-B<5,write('placement impossible'),nl,choix_coordk2(_),!.
test_insertk2(A,B,Y):-B>4,occupe(A,B),write('place occupée veuillez essayer a nouveau'),nl,choix_coordk2(_).
test_insertk2(A,B,Y):-B>4,libre(A,B),retract(kalista2(0,0)),asserta(kalista2(A,B)),Y=[A,B],asserta(listepos2(Y)),asserta(poskalista2(Y)),write('kalista2 placée'),nl,!.

/*CaseOccupeOuLibre?*/
libre(LARGEUR,HAUTEUR):-test_taille(LARGEUR,HAUTEUR),not(pions1(LARGEUR,HAUTEUR)),not(pions2(LARGEUR,HAUTEUR)),not(kalista1(LARGEUR,HAUTEUR)),not(kalista2(LARGEUR,HAUTEUR)).
occupe(LARGEUR,HAUTEUR):-test_taille(LARGEUR,HAUTEUR),pions1(LARGEUR,HAUTEUR),!.
occupe(LARGEUR,HAUTEUR):-test_taille(LARGEUR,HAUTEUR),pions2(LARGEUR,HAUTEUR),!.
occupe(LARGEUR,HAUTEUR):-test_taille(LARGEUR,HAUTEUR),kalista1(LARGEUR,HAUTEUR),!.
occupe(LARGEUR,HAUTEUR):-test_taille(LARGEUR,HAUTEUR),kalista2(LARGEUR,HAUTEUR),!.


/*tests*/
test_taille(X,Y):-X<7,X>0,Y<7,Y>0.
not(X):-X,!,fail.
not(X).

/*different mouvement possible*/

moveG(X,Y):-X>1,X1 is X-1,libre(X1,Y),!.
moveD(X,Y):-X<6,X1 is X+1,libre(X1,Y),!.
moveH(X,Y):-Y<6,Y1 is Y+1,libre(X,Y1),!.
moveB(X,Y):-Y>1,Y1 is Y-1,libre(X,Y1),!.

/*valeur case*/
:-dynamic(val/1).
val(0).

val_case(X,Y,1):-Y1 is 6-Y,X1 is X-1,board1(A),nth0(Y1,A,B),nth0(X1,B,C),retractall(val(_)),asserta(val(C)),!.
val_case(X,Y,2):-Y1 is 6-Y,X1 is X-1,board2(A),nth0(Y1,A,B),nth0(X1,B,C),retractall(val(_)),asserta(val(C)),!.
val_case(X,Y,3):-Y1 is 6-Y,X1 is X-1,board3(A),nth0(Y1,A,B),nth0(X1,B,C),retractall(val(_)),asserta(val(C)),!.
val_case(X,Y,4):-Y1 is 6-Y,X1 is X-1,board4(A),nth0(Y1,A,B),nth0(X1,B,C),retractall(val(_)),asserta(val(C)),!.

/*vraie si case à la  meme valeur que khan*/

reskhan(X,Y,1):-val_case(X,Y,1),val(1),khan(1),!.
reskhan(X,Y,1):-val_case(X,Y,1),val(2),khan(2),!.
reskhan(X,Y,1):-val_case(X,Y,1),val(3),khan(3),!.

reskhan(X,Y,2):-val_case(X,Y,2),val(1),khan(1),!.
reskhan(X,Y,2):-val_case(X,Y,2),val(2),khan(2),!.
reskhan(X,Y,2):-val_case(X,Y,2),val(3),khan(3),!.

reskhan(X,Y,3):-val_case(X,Y,3),val(1),khan(1),!.
reskhan(X,Y,3):-val_case(X,Y,3),val(2),khan(2),!.
reskhan(X,Y,3):-val_case(X,Y,3),val(3),khan(3),!.

reskhan(X,Y,4):-val_case(X,Y,4),val(1),khan(1),!.
reskhan(X,Y,4):-val_case(X,Y,4),val(2),khan(2),!.
reskhan(X,Y,4):-val_case(X,Y,4),val(3),khan(3),!.

/*vrai si case a la meme valeur que le khan et si il y a bien un pion sur la case*/


compkhan1(X,Y,1):-pions1(X,Y),val_case(X,Y,1),val(1),khan(1),!.
compkhan1(X,Y,1):-pions1(X,Y),val_case(X,Y,1),val(2),khan(2),!.
compkhan1(X,Y,1):-pions1(X,Y),val_case(X,Y,1),val(3),khan(3),!.
compkhan1(X,Y,1):-kalista1(X,Y),val_case(X,Y,1),val(1),khan(1),!.
compkhan1(X,Y,1):-kalista1(X,Y),val_case(X,Y,1),val(2),khan(2),!.
compkhan1(X,Y,1):-kalista1(X,Y),val_case(X,Y,1),val(3),khan(3),!.

compkhan1(X,Y,2):-pions1(X,Y),val_case(X,Y,2),val(1),khan(1),!.
compkhan1(X,Y,2):-pions1(X,Y),val_case(X,Y,2),val(2),khan(2),!.
compkhan1(X,Y,2):-pions1(X,Y),val_case(X,Y,2),val(3),khan(3),!.
compkhan1(X,Y,2):-kalista1(X,Y),val_case(X,Y,2),val(1),khan(1),!.
compkhan1(X,Y,2):-kalista1(X,Y),val_case(X,Y,2),val(2),khan(2),!.
compkhan1(X,Y,2):-kalista1(X,Y),val_case(X,Y,2),val(3),khan(3),!.

compkhan1(X,Y,3):-pions1(X,Y),val_case(X,Y,3),val(1),khan(1),!.
compkhan1(X,Y,3):-pions1(X,Y),val_case(X,Y,3),val(2),khan(2),!.
compkhan1(X,Y,3):-pions1(X,Y),val_case(X,Y,3),val(3),khan(3),!.
compkhan1(X,Y,3):-kalista1(X,Y),val_case(X,Y,3),val(1),khan(1),!.
compkhan1(X,Y,3):-kalista1(X,Y),val_case(X,Y,3),val(2),khan(2),!.
compkhan1(X,Y,3):-kalista1(X,Y),val_case(X,Y,3),val(3),khan(3),!.

compkhan1(X,Y,4):-pions1(X,Y),val_case(X,Y,4),val(1),khan(1),!.
compkhan1(X,Y,4):-pions1(X,Y),val_case(X,Y,4),val(2),khan(2),!.
compkhan1(X,Y,4):-pions1(X,Y),val_case(X,Y,4),val(3),khan(3),!.
compkhan1(X,Y,4):-kalista1(X,Y),val_case(X,Y,4),val(1),khan(1),!.
compkhan1(X,Y,4):-kalista1(X,Y),val_case(X,Y,4),val(2),khan(2),!.
compkhan1(X,Y,4):-kalista1(X,Y),val_case(X,Y,4),val(3),khan(3),!.

compkhan2(X,Y,1):-pions2(X,Y),val_case(X,Y,1),val(1),khan(1),!.
compkhan2(X,Y,1):-pions2(X,Y),val_case(X,Y,1),val(2),khan(2),!.
compkhan2(X,Y,1):-pions2(X,Y),val_case(X,Y,1),val(3),khan(3),!.
compkhan2(X,Y,1):-kalista2(X,Y),val_case(X,Y,1),val(1),khan(1),!.
compkhan2(X,Y,1):-kalista2(X,Y),val_case(X,Y,1),val(2),khan(2),!.
compkhan2(X,Y,1):-kalista2(X,Y),val_case(X,Y,1),val(3),khan(3),!.

compkhan2(X,Y,2):-pions2(X,Y),val_case(X,Y,2),val(1),khan(1),!.
compkhan2(X,Y,2):-pions2(X,Y),val_case(X,Y,2),val(2),khan(2),!.
compkhan2(X,Y,2):-pions2(X,Y),val_case(X,Y,2),val(3),khan(3),!.
compkhan2(X,Y,2):-kalista2(X,Y),val_case(X,Y,2),val(1),khan(1),!.
compkhan2(X,Y,2):-kalista2(X,Y),val_case(X,Y,2),val(2),khan(2),!.
compkhan2(X,Y,2):-kalista2(X,Y),val_case(X,Y,2),val(3),khan(3),!.

compkhan2(X,Y,3):-pions2(X,Y),val_case(X,Y,3),val(1),khan(1),!.
compkhan2(X,Y,3):-pions2(X,Y),val_case(X,Y,3),val(2),khan(2),!.
compkhan2(X,Y,3):-pions2(X,Y),val_case(X,Y,3),val(3),khan(3),!.
compkhan2(X,Y,3):-kalista2(X,Y),val_case(X,Y,3),val(1),khan(1),!.
compkhan2(X,Y,3):-kalista2(X,Y),val_case(X,Y,3),val(2),khan(2),!.
compkhan2(X,Y,3):-kalista2(X,Y),val_case(X,Y,3),val(3),khan(3),!.

compkhan2(X,Y,4):-pions2(X,Y),val_case(X,Y,4),val(1),khan(1),!.
compkhan2(X,Y,4):-pions2(X,Y),val_case(X,Y,4),val(2),khan(2),!.
compkhan2(X,Y,4):-pions2(X,Y),val_case(X,Y,4),val(3),khan(3),!.
compkhan2(X,Y,4):-kalista2(X,Y),val_case(X,Y,4),val(1),khan(1),!.
compkhan2(X,Y,4):-kalista2(X,Y),val_case(X,Y,4),val(2),khan(2),!.
compkhan2(X,Y,4):-kalista2(X,Y),val_case(X,Y,4),val(3),khan(3),!.



/*vrai si pion peut bouger*/

pionBouge1G(X,Y,1):-pions1(X,Y),compkhan1(X,Y,1),moveG(X,Y),!.
pionBouge1G(X,Y,1):-kalista1(X,Y),compkhan1(X,Y,1),moveG(X,Y),!.
pionBouge1G(X,Y,2):-pions1(X,Y),compkhan1(X,Y,2),moveG(X,Y),!.
pionBouge1G(X,Y,2):-kalista1(X,Y),compkhan1(X,Y,2),moveG(X,Y),!.
pionBouge1G(X,Y,3):-pions1(X,Y),compkhan1(X,Y,3),moveG(X,Y),!.
pionBouge1G(X,Y,3):-kalista1(X,Y),compkhan1(X,Y,3),moveG(X,Y),!.
pionBouge1G(X,Y,4):-pions1(X,Y),compkhan1(X,Y,4),moveG(X,Y),!.
pionBouge1G(X,Y,4):-kalista1(X,Y),compkhan1(X,Y,4),moveG(X,Y),!.

pionBouge1D(X,Y,1):-pions1(X,Y),compkhan1(X,Y,1),moveD(X,Y),!.
pionBouge1D(X,Y,1):-kalista1(X,Y),compkhan1(X,Y,1),moveD(X,Y),!.
pionBouge1D(X,Y,2):-pions1(X,Y),compkhan1(X,Y,2),moveD(X,Y),!.
pionBouge1D(X,Y,2):-kalista1(X,Y),compkhan1(X,Y,2),moveD(X,Y),!.
pionBouge1D(X,Y,3):-pions1(X,Y),compkhan1(X,Y,3),moveD(X,Y),!.
pionBouge1D(X,Y,3):-kalista1(X,Y),compkhan1(X,Y,3),moveD(X,Y),!.
pionBouge1D(X,Y,4):-pions1(X,Y),compkhan1(X,Y,4),moveD(X,Y),!.
pionBouge1D(X,Y,4):-kalista1(X,Y),compkhan1(X,Y,4),moveD(X,Y),!.

pionBouge1H(X,Y,1):-pions1(X,Y),compkhan1(X,Y,1),moveH(X,Y),!.
pionBouge1H(X,Y,1):-kalista1(X,Y),compkhan1(X,Y,1),moveH(X,Y),!.
pionBouge1H(X,Y,2):-pions1(X,Y),compkhan1(X,Y,2),moveH(X,Y),!.
pionBouge1H(X,Y,2):-kalista1(X,Y),compkhan1(X,Y,2),moveH(X,Y),!.
pionBouge1H(X,Y,3):-pions1(X,Y),compkhan1(X,Y,3),moveH(X,Y),!.
pionBouge1H(X,Y,3):-kalista1(X,Y),compkhan1(X,Y,3),moveH(X,Y),!.
pionBouge1H(X,Y,4):-pions1(X,Y),compkhan1(X,Y,4),moveH(X,Y),!.
pionBouge1H(X,Y,4):-kalista1(X,Y),compkhan1(X,Y,4),moveH(X,Y),!.

pionBouge1B(X,Y,1):-pions1(X,Y),compkhan1(X,Y,1),moveB(X,Y),!.
pionBouge1B(X,Y,1):-kalista1(X,Y),compkhan1(X,Y,1),moveB(X,Y),!.
pionBouge1B(X,Y,2):-pions1(X,Y),compkhan1(X,Y,2),moveB(X,Y),!.
pionBouge1B(X,Y,2):-kalista1(X,Y),compkhan1(X,Y,2),moveB(X,Y),!.
pionBouge1B(X,Y,3):-pions1(X,Y),compkhan1(X,Y,3),moveB(X,Y),!.
pionBouge1B(X,Y,3):-kalista1(X,Y),compkhan1(X,Y,3),moveB(X,Y),!.
pionBouge1B(X,Y,4):-pions1(X,Y),compkhan1(X,Y,4),moveB(X,Y),!.
pionBouge1B(X,Y,4):-kalista1(X,Y),compkhan1(X,Y,4),moveB(X,Y),!.


pionBouge2G(X,Y,1):-pions2(X,Y),compkhan2(X,Y,1),moveG(X,Y),!.
pionBouge2G(X,Y,1):-kalista2(X,Y),compkhan2(X,Y,1),moveG(X,Y),!.
pionBouge2G(X,Y,2):-pions2(X,Y),compkhan2(X,Y,2),moveG(X,Y),!.
pionBouge2G(X,Y,2):-kalista2(X,Y),compkhan2(X,Y,2),moveG(X,Y),!.
pionBouge2G(X,Y,3):-pions2(X,Y),compkhan2(X,Y,3),moveG(X,Y),!.
pionBouge2G(X,Y,3):-kalista2(X,Y),compkhan2(X,Y,3),moveG(X,Y),!.
pionBouge2G(X,Y,4):-pions2(X,Y),compkhan2(X,Y,4),moveG(X,Y),!.
pionBouge2G(X,Y,4):-kalista2(X,Y),compkhan2(X,Y,4),moveG(X,Y),!.

pionBouge2D(X,Y,1):-pions2(X,Y),compkhan2(X,Y,1),moveD(X,Y),!.
pionBouge2D(X,Y,1):-kalista2(X,Y),compkhan2(X,Y,1),moveD(X,Y),!.
pionBouge2D(X,Y,2):-pions2(X,Y),compkhan2(X,Y,2),moveD(X,Y),!.
pionBouge2D(X,Y,2):-kalista2(X,Y),compkhan2(X,Y,2),moveD(X,Y),!.
pionBouge2D(X,Y,3):-pions2(X,Y),compkhan2(X,Y,3),moveD(X,Y),!.
pionBouge2D(X,Y,3):-kalista2(X,Y),compkhan2(X,Y,3),moveD(X,Y),!.
pionBouge2D(X,Y,4):-pions2(X,Y),compkhan2(X,Y,4),moveD(X,Y),!.
pionBouge2D(X,Y,4):-kalista2(X,Y),compkhan2(X,Y,4),moveD(X,Y),!.

pionBouge2H(X,Y,1):-pions2(X,Y),compkhan2(X,Y,1),moveH(X,Y),!.
pionBouge2H(X,Y,1):-kalista2(X,Y),compkhan2(X,Y,1),moveH(X,Y),!.
pionBouge2H(X,Y,2):-pions2(X,Y),compkhan2(X,Y,2),moveH(X,Y),!.
pionBouge2H(X,Y,2):-kalista2(X,Y),compkhan2(X,Y,2),moveH(X,Y),!.
pionBouge2H(X,Y,3):-pions2(X,Y),compkhan2(X,Y,3),moveH(X,Y),!.
pionBouge2H(X,Y,3):-kalista2(X,Y),compkhan2(X,Y,3),moveH(X,Y),!.
pionBouge2H(X,Y,4):-pions2(X,Y),compkhan2(X,Y,4),moveH(X,Y),!.
pionBouge2H(X,Y,4):-kalista2(X,Y),compkhan2(X,Y,4),moveH(X,Y),!.

pionBouge2B(X,Y,1):-pions2(X,Y),compkhan2(X,Y,1),moveB(X,Y),!.
pionBouge2B(X,Y,1):-kalista2(X,Y),compkhan2(X,Y,1),moveB(X,Y),!.
pionBouge2B(X,Y,2):-pions2(X,Y),compkhan2(X,Y,2),moveB(X,Y),!.
pionBouge2B(X,Y,2):-kalista2(X,Y),compkhan2(X,Y,2),moveB(X,Y),!.
pionBouge2B(X,Y,3):-pions2(X,Y),compkhan2(X,Y,3),moveB(X,Y),!.
pionBouge2B(X,Y,3):-kalista2(X,Y),compkhan2(X,Y,3),moveB(X,Y),!.
pionBouge2B(X,Y,4):-pions2(X,Y),compkhan2(X,Y,4),moveB(X,Y),!.
pionBouge2B(X,Y,4):-kalista2(X,Y),compkhan2(X,Y,4),moveB(X,Y),!.

/*verifie si on peut ressuciter et ensuite ressucite un pion*/

qressucite1(_):-pions1(0,0).
qressucite2(_):-pions2(0,0).

ressucite1(X,Y):-libre(X,Y),retract(pions1(0,0)),asserta(pions1(X,Y)),write('pion ressucité'),nl,!.
ressucite2(X,Y):-libre(X,Y),retract(pions2(0,0)),asserta(pions2(X,Y)),write('pion ressucité'),nl,!.

/*retourne vrai si il y a une piece du joueur P1 ou P2 à la case X Y*/
presP1(X,Y):-pions1(X,Y),!.
presP1(X,Y):-kalista1(X,Y),!.
presP2(X,Y):-pions2(X,Y),!.
presP2(X,Y):-kalista2(X,Y),!.

/*predicat qui permet de dire si un mouvement peut tuer une piece adverse*/

kill1G(X,Y):-X>1,X1 is X-1,presP2(X1,Y).
kill1D(X,Y):-X<6,X1 is X+1,presP2(X1,Y).
kill1H(X,Y):-Y<6,Y1 is Y+1,presP2(X,Y1).
kill1B(X,Y):-Y>1,Y1 is Y-1,presP2(X,Y1).
kill2G(X,Y):-X>1,X1 is X-1,presP1(X1,Y).
kill2D(X,Y):-X<6,X1 is X+1,presP1(X1,Y).
kill2H(X,Y):-Y<6,Y1 is Y+1,presP1(X,Y1).
kill2B(X,Y):-Y>1,Y1 is Y-1,presP1(X,Y1).

/*creation de la liste des moves possibles par joueur

avance1 pour board1*/

avance1(A,B,C,D,1,X,1):-compkhan1(A,B,1),khan(1),pionBouge1G(A,B,1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,2).
avance1(A,B,C,D,1,X,2):-compkhan1(A,B,1),khan(1),kill1G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,3).
avance1(A,B,C,D,1,X,3):-compkhan1(A,B,1),khan(1),pionBouge1D(A,B,1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,4).
avance1(A,B,C,D,1,X,4):-compkhan1(A,B,1),khan(1),kill1D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,5).
avance1(A,B,C,D,1,X,5):-compkhan1(A,B,1),khan(1),pionBouge1H(A,B,1),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,6).
avance1(A,B,C,D,1,X,6):-compkhan1(A,B,1),khan(1),kill1H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,7).
avance1(A,B,C,D,1,X,7):-compkhan1(A,B,1),khan(1),pionBouge1B(A,B,1),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,8).
avance1(A,B,C,D,1,X,8):-compkhan1(A,B,1),khan(1),kill1B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,1,X,9):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,10).
avance1(A,B,C,D,1,X,10):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill1G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,11).
avance1(A,B,C,D,1,X,11):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,12).
avance1(A,B,C,D,1,X,12):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill1H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,13).
avance1(A,B,C,D,1,X,13):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,14).
avance1(A,B,C,D,1,X,14):-compkhan1(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill1B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,15).
avance1(A,B,C,D,1,X,15):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,16).
avance1(A,B,C,D,1,X,16):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill1D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,17).
avance1(A,B,C,D,1,X,17):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,18).
avance1(A,B,C,D,1,X,18):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill1H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,19).
avance1(A,B,C,D,1,X,19):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,20).
avance1(A,B,C,D,1,X,20):-compkhan1(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill1B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,21).
avance1(A,B,C,D,1,X,21):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,22).
avance1(A,B,C,D,1,X,22):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,23).
avance1(A,B,C,D,1,X,23):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,24).
avance1(A,B,C,D,1,X,24):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill1H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,25).
avance1(A,B,C,D,1,X,25):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,26).
avance1(A,B,C,D,1,X,26):-compkhan1(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill1G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,27).
avance1(A,B,C,D,1,X,27):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,28).
avance1(A,B,C,D,1,X,28):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,29).
avance1(A,B,C,D,1,X,29):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,30).
avance1(A,B,C,D,1,X,30):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill1B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,31).
avance1(A,B,C,D,1,X,31):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,32).
avance1(A,B,C,D,1,X,32):-compkhan1(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill1G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,1,X,33):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,34).
avance1(A,B,C,D,1,X,34):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,35).
avance1(A,B,C,D,1,X,35):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,36).
avance1(A,B,C,D,1,X,36):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,37).
avance1(A,B,C,D,1,X,37):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,38).
avance1(A,B,C,D,1,X,38):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,39).
avance1(A,B,C,D,1,X,39):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,40).
avance1(A,B,C,D,1,X,40):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,41).
avance1(A,B,C,D,1,X,41):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,42).
avance1(A,B,C,D,1,X,42):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,43).
avance1(A,B,C,D,1,X,43):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,44).
avance1(A,B,C,D,1,X,44):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,45).
avance1(A,B,C,D,1,X,45):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,46).
avance1(A,B,C,D,1,X,46):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,47).
avance1(A,B,C,D,1,X,47):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,48).
avance1(A,B,C,D,1,X,48):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,49).
avance1(A,B,C,D,1,X,49):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,50).
avance1(A,B,C,D,1,X,50):-compkhan1(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,51).
avance1(A,B,C,D,1,X,51):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,52).
avance1(A,B,C,D,1,X,52):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,53).
avance1(A,B,C,D,1,X,53):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,54).
avance1(A,B,C,D,1,X,54):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,55).
avance1(A,B,C,D,1,X,55):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,56).
avance1(A,B,C,D,1,X,56):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,57).
avance1(A,B,C,D,1,X,57):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,58).
avance1(A,B,C,D,1,X,58):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,59).
avance1(A,B,C,D,1,X,59):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,60).
avance1(A,B,C,D,1,X,60):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,61).
avance1(A,B,C,D,1,X,61):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,62).
avance1(A,B,C,D,1,X,62):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,63).
avance1(A,B,C,D,1,X,63):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,64).
avance1(A,B,C,D,1,X,64):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,65).
avance1(A,B,C,D,1,X,65):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,66).
avance1(A,B,C,D,1,X,66):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,67).
avance1(A,B,C,D,1,X,67):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,68).
avance1(A,B,C,D,1,X,68):-compkhan1(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,69).
avance1(A,B,C,D,1,X,69):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,70).
avance1(A,B,C,D,1,X,70):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,71).
avance1(A,B,C,D,1,X,71):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,72).
avance1(A,B,C,D,1,X,72):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,73).
avance1(A,B,C,D,1,X,73):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,74).
avance1(A,B,C,D,1,X,74):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,75).
avance1(A,B,C,D,1,X,75):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,76).
avance1(A,B,C,D,1,X,76):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,77).
avance1(A,B,C,D,1,X,77):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,78).
avance1(A,B,C,D,1,X,78):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,79).
avance1(A,B,C,D,1,X,79):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,80).
avance1(A,B,C,D,1,X,80):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,81).
avance1(A,B,C,D,1,X,81):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,82).
avance1(A,B,C,D,1,X,82):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,83).
avance1(A,B,C,D,1,X,83):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,84).
avance1(A,B,C,D,1,X,84):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,85).
avance1(A,B,C,D,1,X,85):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,86).
avance1(A,B,C,D,1,X,86):-compkhan1(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,87).
avance1(A,B,C,D,1,X,87):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,88).
avance1(A,B,C,D,1,X,88):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,89).
avance1(A,B,C,D,1,X,89):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,90).
avance1(A,B,C,D,1,X,90):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,91).
avance1(A,B,C,D,1,X,91):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,92).
avance1(A,B,C,D,1,X,92):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,93).
avance1(A,B,C,D,1,X,93):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,94).
avance1(A,B,C,D,1,X,94):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,95).
avance1(A,B,C,D,1,X,95):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,96).
avance1(A,B,C,D,1,X,96):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,97).
avance1(A,B,C,D,1,X,97):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,98).
avance1(A,B,C,D,1,X,98):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,99).
avance1(A,B,C,D,1,X,99):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,100).
avance1(A,B,C,D,1,X,100):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,101).
avance1(A,B,C,D,1,X,101):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,102).
avance1(A,B,C,D,1,X,102):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,103).
avance1(A,B,C,D,1,X,103):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,1,_,104).
avance1(A,B,C,D,1,X,104):-compkhan1(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),!.

/*avance1 pour board2*/

avance1(A,B,C,D,2,X,1):-compkhan1(A,B,2),khan(1),pionBouge1G(A,B,2),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,2).
avance1(A,B,C,D,2,X,2):-compkhan1(A,B,2),khan(1),kill1G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,3).
avance1(A,B,C,D,2,X,3):-compkhan1(A,B,2),khan(1),pionBouge1D(A,B,2),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,4).
avance1(A,B,C,D,2,X,4):-compkhan1(A,B,2),khan(1),kill1D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,5).
avance1(A,B,C,D,2,X,5):-compkhan1(A,B,2),khan(1),pionBouge1H(A,B,2),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,6).
avance1(A,B,C,D,2,X,6):-compkhan1(A,B,2),khan(1),kill1H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,7).
avance1(A,B,C,D,2,X,7):-compkhan1(A,B,2),khan(1),pionBouge1B(A,B,2),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,8).
avance1(A,B,C,D,2,X,8):-compkhan1(A,B,2),khan(1),kill1B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,2,X,9):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,10).
avance1(A,B,C,D,2,X,10):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill1G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,11).
avance1(A,B,C,D,2,X,11):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,12).
avance1(A,B,C,D,2,X,12):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill1H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,13).
avance1(A,B,C,D,2,X,13):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,14).
avance1(A,B,C,D,2,X,14):-compkhan1(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill1B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,15).
avance1(A,B,C,D,2,X,15):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,16).
avance1(A,B,C,D,2,X,16):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill1D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,17).
avance1(A,B,C,D,2,X,17):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,18).
avance1(A,B,C,D,2,X,18):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill1H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,19).
avance1(A,B,C,D,2,X,19):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,20).
avance1(A,B,C,D,2,X,20):-compkhan1(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill1B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,21).
avance1(A,B,C,D,2,X,21):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,22).
avance1(A,B,C,D,2,X,22):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,23).
avance1(A,B,C,D,2,X,23):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,24).
avance1(A,B,C,D,2,X,24):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill1H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,25).
avance1(A,B,C,D,2,X,25):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,26).
avance1(A,B,C,D,2,X,26):-compkhan1(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill1G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,27).
avance1(A,B,C,D,2,X,27):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,28).
avance1(A,B,C,D,2,X,28):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,29).
avance1(A,B,C,D,2,X,29):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,30).
avance1(A,B,C,D,2,X,30):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill1B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,31).
avance1(A,B,C,D,2,X,31):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,32).
avance1(A,B,C,D,2,X,32):-compkhan1(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill1G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,2,X,33):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,34).
avance1(A,B,C,D,2,X,34):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,35).
avance1(A,B,C,D,2,X,35):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,36).
avance1(A,B,C,D,2,X,36):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,37).
avance1(A,B,C,D,2,X,37):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,38).
avance1(A,B,C,D,2,X,38):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,39).
avance1(A,B,C,D,2,X,39):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,40).
avance1(A,B,C,D,2,X,40):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,41).
avance1(A,B,C,D,2,X,41):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,42).
avance1(A,B,C,D,2,X,42):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,43).
avance1(A,B,C,D,2,X,43):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,44).
avance1(A,B,C,D,2,X,44):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,45).
avance1(A,B,C,D,2,X,45):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,46).
avance1(A,B,C,D,2,X,46):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,47).
avance1(A,B,C,D,2,X,47):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,48).
avance1(A,B,C,D,2,X,48):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,49).
avance1(A,B,C,D,2,X,49):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,50).
avance1(A,B,C,D,2,X,50):-compkhan1(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,51).
avance1(A,B,C,D,2,X,51):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,52).
avance1(A,B,C,D,2,X,52):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,53).
avance1(A,B,C,D,2,X,53):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,54).
avance1(A,B,C,D,2,X,54):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,55).
avance1(A,B,C,D,2,X,55):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,56).
avance1(A,B,C,D,2,X,56):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,57).
avance1(A,B,C,D,2,X,57):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,58).
avance1(A,B,C,D,2,X,58):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,59).
avance1(A,B,C,D,2,X,59):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,60).
avance1(A,B,C,D,2,X,60):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,61).
avance1(A,B,C,D,2,X,61):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,62).
avance1(A,B,C,D,2,X,62):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,63).
avance1(A,B,C,D,2,X,63):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,64).
avance1(A,B,C,D,2,X,64):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,65).
avance1(A,B,C,D,2,X,65):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,66).
avance1(A,B,C,D,2,X,66):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,67).
avance1(A,B,C,D,2,X,67):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,68).
avance1(A,B,C,D,2,X,68):-compkhan1(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,69).
avance1(A,B,C,D,2,X,69):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,70).
avance1(A,B,C,D,2,X,70):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,71).
avance1(A,B,C,D,2,X,71):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,72).
avance1(A,B,C,D,2,X,72):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,73).
avance1(A,B,C,D,2,X,73):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,74).
avance1(A,B,C,D,2,X,74):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,75).
avance1(A,B,C,D,2,X,75):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,76).
avance1(A,B,C,D,2,X,76):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,77).
avance1(A,B,C,D,2,X,77):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,78).
avance1(A,B,C,D,2,X,78):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,79).
avance1(A,B,C,D,2,X,79):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,80).
avance1(A,B,C,D,2,X,80):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,81).
avance1(A,B,C,D,2,X,81):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,82).
avance1(A,B,C,D,2,X,82):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,83).
avance1(A,B,C,D,2,X,83):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,84).
avance1(A,B,C,D,2,X,84):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,85).
avance1(A,B,C,D,2,X,85):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,86).
avance1(A,B,C,D,2,X,86):-compkhan1(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,87).
avance1(A,B,C,D,2,X,87):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,88).
avance1(A,B,C,D,2,X,88):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,89).
avance1(A,B,C,D,2,X,89):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,90).
avance1(A,B,C,D,2,X,90):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,91).
avance1(A,B,C,D,2,X,91):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,92).
avance1(A,B,C,D,2,X,92):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,93).
avance1(A,B,C,D,2,X,93):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,94).
avance1(A,B,C,D,2,X,94):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,95).
avance1(A,B,C,D,2,X,95):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,96).
avance1(A,B,C,D,2,X,96):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,97).
avance1(A,B,C,D,2,X,97):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,98).
avance1(A,B,C,D,2,X,98):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,99).
avance1(A,B,C,D,2,X,99):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,100).
avance1(A,B,C,D,2,X,100):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,101).
avance1(A,B,C,D,2,X,101):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,102).
avance1(A,B,C,D,2,X,102):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,103).
avance1(A,B,C,D,2,X,103):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,2,_,104).
avance1(A,B,C,D,2,X,104):-compkhan1(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),!.

/*avance1 pour board3*/

avance1(A,B,C,D,3,X,1):-compkhan1(A,B,3),khan(1),pionBouge1G(A,B,3),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,2).
avance1(A,B,C,D,3,X,2):-compkhan1(A,B,3),khan(1),kill1G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,3).
avance1(A,B,C,D,3,X,3):-compkhan1(A,B,3),khan(1),pionBouge1D(A,B,3),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,4).
avance1(A,B,C,D,3,X,4):-compkhan1(A,B,3),khan(1),kill1D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,5).
avance1(A,B,C,D,3,X,5):-compkhan1(A,B,3),khan(1),pionBouge1H(A,B,3),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,6).
avance1(A,B,C,D,3,X,6):-compkhan1(A,B,3),khan(1),kill1H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,7).
avance1(A,B,C,D,3,X,7):-compkhan1(A,B,3),khan(1),pionBouge1B(A,B,3),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,8).
avance1(A,B,C,D,3,X,8):-compkhan1(A,B,3),khan(1),kill1B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,3,X,9):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,10).
avance1(A,B,C,D,3,X,10):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill1G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,11).
avance1(A,B,C,D,3,X,11):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,12).
avance1(A,B,C,D,3,X,12):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill1H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,13).
avance1(A,B,C,D,3,X,13):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,14).
avance1(A,B,C,D,3,X,14):-compkhan1(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill1B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,15).
avance1(A,B,C,D,3,X,15):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,16).
avance1(A,B,C,D,3,X,16):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill1D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,17).
avance1(A,B,C,D,3,X,17):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,18).
avance1(A,B,C,D,3,X,18):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill1H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,19).
avance1(A,B,C,D,3,X,19):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,20).
avance1(A,B,C,D,3,X,20):-compkhan1(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill1B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,21).
avance1(A,B,C,D,3,X,21):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,22).
avance1(A,B,C,D,3,X,22):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,23).
avance1(A,B,C,D,3,X,23):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,24).
avance1(A,B,C,D,3,X,24):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill1H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,25).
avance1(A,B,C,D,3,X,25):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,26).
avance1(A,B,C,D,3,X,26):-compkhan1(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill1G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,27).
avance1(A,B,C,D,3,X,27):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,28).
avance1(A,B,C,D,3,X,28):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,29).
avance1(A,B,C,D,3,X,29):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,30).
avance1(A,B,C,D,3,X,30):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill1B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,31).
avance1(A,B,C,D,3,X,31):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,32).
avance1(A,B,C,D,3,X,32):-compkhan1(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill1G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,3,X,33):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,34).
avance1(A,B,C,D,3,X,34):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,35).
avance1(A,B,C,D,3,X,35):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,36).
avance1(A,B,C,D,3,X,36):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,37).
avance1(A,B,C,D,3,X,37):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,38).
avance1(A,B,C,D,3,X,38):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,39).
avance1(A,B,C,D,3,X,39):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,40).
avance1(A,B,C,D,3,X,40):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,41).
avance1(A,B,C,D,3,X,41):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,42).
avance1(A,B,C,D,3,X,42):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,43).
avance1(A,B,C,D,3,X,43):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,44).
avance1(A,B,C,D,3,X,44):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,45).
avance1(A,B,C,D,3,X,45):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,46).
avance1(A,B,C,D,3,X,46):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,47).
avance1(A,B,C,D,3,X,47):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,48).
avance1(A,B,C,D,3,X,48):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,49).
avance1(A,B,C,D,3,X,49):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,50).
avance1(A,B,C,D,3,X,50):-compkhan1(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,51).
avance1(A,B,C,D,3,X,51):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,52).
avance1(A,B,C,D,3,X,52):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,53).
avance1(A,B,C,D,3,X,53):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,54).
avance1(A,B,C,D,3,X,54):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,55).
avance1(A,B,C,D,3,X,55):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,56).
avance1(A,B,C,D,3,X,56):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,57).
avance1(A,B,C,D,3,X,57):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,58).
avance1(A,B,C,D,3,X,58):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,59).
avance1(A,B,C,D,3,X,59):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,60).
avance1(A,B,C,D,3,X,60):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,61).
avance1(A,B,C,D,3,X,61):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,62).
avance1(A,B,C,D,3,X,62):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,63).
avance1(A,B,C,D,3,X,63):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,64).
avance1(A,B,C,D,3,X,64):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,65).
avance1(A,B,C,D,3,X,65):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,66).
avance1(A,B,C,D,3,X,66):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,67).
avance1(A,B,C,D,3,X,67):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,68).
avance1(A,B,C,D,3,X,68):-compkhan1(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,69).
avance1(A,B,C,D,3,X,69):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,70).
avance1(A,B,C,D,3,X,70):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,71).
avance1(A,B,C,D,3,X,71):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,72).
avance1(A,B,C,D,3,X,72):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,73).
avance1(A,B,C,D,3,X,73):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,74).
avance1(A,B,C,D,3,X,74):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,75).
avance1(A,B,C,D,3,X,75):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,76).
avance1(A,B,C,D,3,X,76):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,77).
avance1(A,B,C,D,3,X,77):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,78).
avance1(A,B,C,D,3,X,78):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,79).
avance1(A,B,C,D,3,X,79):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,80).
avance1(A,B,C,D,3,X,80):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,81).
avance1(A,B,C,D,3,X,81):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,82).
avance1(A,B,C,D,3,X,82):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,83).
avance1(A,B,C,D,3,X,83):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,84).
avance1(A,B,C,D,3,X,84):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,85).
avance1(A,B,C,D,3,X,85):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,86).
avance1(A,B,C,D,3,X,86):-compkhan1(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,87).
avance1(A,B,C,D,3,X,87):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,88).
avance1(A,B,C,D,3,X,88):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,89).
avance1(A,B,C,D,3,X,89):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,90).
avance1(A,B,C,D,3,X,90):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,91).
avance1(A,B,C,D,3,X,91):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,92).
avance1(A,B,C,D,3,X,92):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,93).
avance1(A,B,C,D,3,X,93):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,94).
avance1(A,B,C,D,3,X,94):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,95).
avance1(A,B,C,D,3,X,95):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,96).
avance1(A,B,C,D,3,X,96):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,97).
avance1(A,B,C,D,3,X,97):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,98).
avance1(A,B,C,D,3,X,98):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,99).
avance1(A,B,C,D,3,X,99):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,100).
avance1(A,B,C,D,3,X,100):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,101).
avance1(A,B,C,D,3,X,101):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,102).
avance1(A,B,C,D,3,X,102):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,103).
avance1(A,B,C,D,3,X,103):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,3,_,104).
avance1(A,B,C,D,3,X,104):-compkhan1(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),!.

/*avance1 pour le board4*/

avance1(A,B,C,D,4,X,1):-compkhan1(A,B,4),khan(1),pionBouge1G(A,B,4),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,2).
avance1(A,B,C,D,4,X,2):-compkhan1(A,B,4),khan(1),kill1G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,3).
avance1(A,B,C,D,4,X,3):-compkhan1(A,B,4),khan(1),pionBouge1D(A,B,4),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,4).
avance1(A,B,C,D,4,X,4):-compkhan1(A,B,4),khan(1),kill1D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,5).
avance1(A,B,C,D,4,X,5):-compkhan1(A,B,4),khan(1),pionBouge1H(A,B,4),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,6).
avance1(A,B,C,D,4,X,6):-compkhan1(A,B,4),khan(1),kill1H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,7).
avance1(A,B,C,D,4,X,7):-compkhan1(A,B,4),khan(1),pionBouge1B(A,B,4),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,8).
avance1(A,B,C,D,4,X,8):-compkhan1(A,B,4),khan(1),kill1B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,4,X,9):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,10).
avance1(A,B,C,D,4,X,10):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill1G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,11).
avance1(A,B,C,D,4,X,11):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,12).
avance1(A,B,C,D,4,X,12):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill1H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,13).
avance1(A,B,C,D,4,X,13):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,14).
avance1(A,B,C,D,4,X,14):-compkhan1(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill1B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,15).
avance1(A,B,C,D,4,X,15):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,16).
avance1(A,B,C,D,4,X,16):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill1D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,17).
avance1(A,B,C,D,4,X,17):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,18).
avance1(A,B,C,D,4,X,18):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill1H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,19).
avance1(A,B,C,D,4,X,19):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,20).
avance1(A,B,C,D,4,X,20):-compkhan1(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill1B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,21).
avance1(A,B,C,D,4,X,21):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,22).
avance1(A,B,C,D,4,X,22):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,23).
avance1(A,B,C,D,4,X,23):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,24).
avance1(A,B,C,D,4,X,24):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill1H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,25).
avance1(A,B,C,D,4,X,25):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,26).
avance1(A,B,C,D,4,X,26):-compkhan1(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill1G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,27).
avance1(A,B,C,D,4,X,27):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,28).
avance1(A,B,C,D,4,X,28):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill1D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,29).
avance1(A,B,C,D,4,X,29):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,30).
avance1(A,B,C,D,4,X,30):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill1B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,31).
avance1(A,B,C,D,4,X,31):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,32).
avance1(A,B,C,D,4,X,32):-compkhan1(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill1G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),!.
avance1(A,B,C,D,4,X,33):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,34).
avance1(A,B,C,D,4,X,34):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,35).
avance1(A,B,C,D,4,X,35):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,36).
avance1(A,B,C,D,4,X,36):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,37).
avance1(A,B,C,D,4,X,37):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,38).
avance1(A,B,C,D,4,X,38):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill1B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,39).
avance1(A,B,C,D,4,X,39):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,40).
avance1(A,B,C,D,4,X,40):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,41).
avance1(A,B,C,D,4,X,41):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,42).
avance1(A,B,C,D,4,X,42):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,43).
avance1(A,B,C,D,4,X,43):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,44).
avance1(A,B,C,D,4,X,44):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,45).
avance1(A,B,C,D,4,X,45):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,46).
avance1(A,B,C,D,4,X,46):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,47).
avance1(A,B,C,D,4,X,47):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,48).
avance1(A,B,C,D,4,X,48):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,49).
avance1(A,B,C,D,4,X,49):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,50).
avance1(A,B,C,D,4,X,50):-compkhan1(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,51).
avance1(A,B,C,D,4,X,51):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,52).
avance1(A,B,C,D,4,X,52):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,53).
avance1(A,B,C,D,4,X,53):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,54).
avance1(A,B,C,D,4,X,54):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,55).
avance1(A,B,C,D,4,X,55):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,56).
avance1(A,B,C,D,4,X,56):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill1B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,57).
avance1(A,B,C,D,4,X,57):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,58).
avance1(A,B,C,D,4,X,58):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,59).
avance1(A,B,C,D,4,X,59):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,60).
avance1(A,B,C,D,4,X,60):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,61).
avance1(A,B,C,D,4,X,61):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,62).
avance1(A,B,C,D,4,X,62):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,63).
avance1(A,B,C,D,4,X,63):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,64).
avance1(A,B,C,D,4,X,64):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,65).
avance1(A,B,C,D,4,X,65):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,66).
avance1(A,B,C,D,4,X,66):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,67).
avance1(A,B,C,D,4,X,67):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,68).
avance1(A,B,C,D,4,X,68):-compkhan1(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,69).
avance1(A,B,C,D,4,X,69):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,70).
avance1(A,B,C,D,4,X,70):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,71).
avance1(A,B,C,D,4,X,71):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,72).
avance1(A,B,C,D,4,X,72):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,73).
avance1(A,B,C,D,4,X,73):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,74).
avance1(A,B,C,D,4,X,74):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,75).
avance1(A,B,C,D,4,X,75):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,76).
avance1(A,B,C,D,4,X,76):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,77).
avance1(A,B,C,D,4,X,77):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,78).
avance1(A,B,C,D,4,X,78):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,79).
avance1(A,B,C,D,4,X,79):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,80).
avance1(A,B,C,D,4,X,80):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,81).
avance1(A,B,C,D,4,X,81):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,82).
avance1(A,B,C,D,4,X,82):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,83).
avance1(A,B,C,D,4,X,83):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,84).
avance1(A,B,C,D,4,X,84):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,85).
avance1(A,B,C,D,4,X,85):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,86).
avance1(A,B,C,D,4,X,86):-compkhan1(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill1H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,87).
avance1(A,B,C,D,4,X,87):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,88).
avance1(A,B,C,D,4,X,88):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,89).
avance1(A,B,C,D,4,X,89):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,90).
avance1(A,B,C,D,4,X,90):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,91).
avance1(A,B,C,D,4,X,91):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,92).
avance1(A,B,C,D,4,X,92):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill1B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,93).
avance1(A,B,C,D,4,X,93):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,94).
avance1(A,B,C,D,4,X,94):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,95).
avance1(A,B,C,D,4,X,95):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,96).
avance1(A,B,C,D,4,X,96):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,97).
avance1(A,B,C,D,4,X,97):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,98).
avance1(A,B,C,D,4,X,98):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill1B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,99).
avance1(A,B,C,D,4,X,99):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,100).
avance1(A,B,C,D,4,X,100):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,101).
avance1(A,B,C,D,4,X,101):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,102).
avance1(A,B,C,D,4,X,102):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,103).
avance1(A,B,C,D,4,X,103):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),avance1(A,B,_,_,4,_,104).
avance1(A,B,C,D,4,X,104):-compkhan1(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill1B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs1(X)),!.




/*avance2 pour board1*/

avance2(A,B,C,D,1,X,1):-compkhan2(A,B,1),khan(1),pionBouge2G(A,B,1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,2).
avance2(A,B,C,D,1,X,2):-compkhan2(A,B,1),khan(1),kill2G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,3).
avance2(A,B,C,D,1,X,3):-compkhan2(A,B,1),khan(1),pionBouge2D(A,B,1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,4).
avance2(A,B,C,D,1,X,4):-compkhan2(A,B,1),khan(1),kill2D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,5).
avance2(A,B,C,D,1,X,5):-compkhan2(A,B,1),khan(1),pionBouge2H(A,B,1),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,6).
avance2(A,B,C,D,1,X,6):-compkhan2(A,B,1),khan(1),kill2H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,7).
avance2(A,B,C,D,1,X,7):-compkhan2(A,B,1),khan(1),pionBouge2B(A,B,1),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,8).
avance2(A,B,C,D,1,X,8):-compkhan2(A,B,1),khan(1),kill2B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,1,X,9):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,10).
avance2(A,B,C,D,1,X,10):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill2G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,11).
avance2(A,B,C,D,1,X,11):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,12).
avance2(A,B,C,D,1,X,12):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill2H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,13).
avance2(A,B,C,D,1,X,13):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,14).
avance2(A,B,C,D,1,X,14):-compkhan2(A,B,1),khan(2),moveG(A,B),A1 is A-1,kill2B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,15).
avance2(A,B,C,D,1,X,15):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,16).
avance2(A,B,C,D,1,X,16):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill2D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,17).
avance2(A,B,C,D,1,X,17):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,18).
avance2(A,B,C,D,1,X,18):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill2H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,19).
avance2(A,B,C,D,1,X,19):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,20).
avance2(A,B,C,D,1,X,20):-compkhan2(A,B,1),khan(2),moveD(A,B),A1 is A+1,kill2B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,21).
avance2(A,B,C,D,1,X,21):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,22).
avance2(A,B,C,D,1,X,22):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,23).
avance2(A,B,C,D,1,X,23):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,24).
avance2(A,B,C,D,1,X,24):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill2H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,25).
avance2(A,B,C,D,1,X,25):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,26).
avance2(A,B,C,D,1,X,26):-compkhan2(A,B,1),khan(2),moveH(A,B),B1 is B+1,kill2G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,27).
avance2(A,B,C,D,1,X,27):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,28).
avance2(A,B,C,D,1,X,28):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,29).
avance2(A,B,C,D,1,X,29):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,30).
avance2(A,B,C,D,1,X,30):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill2B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,31).
avance2(A,B,C,D,1,X,31):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,32).
avance2(A,B,C,D,1,X,32):-compkhan2(A,B,1),khan(2),moveB(A,B),B1 is B-1,kill2G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,1,X,33):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,34).
avance2(A,B,C,D,1,X,34):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,35).
avance2(A,B,C,D,1,X,35):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,36).
avance2(A,B,C,D,1,X,36):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,37).
avance2(A,B,C,D,1,X,37):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,38).
avance2(A,B,C,D,1,X,38):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,39).
avance2(A,B,C,D,1,X,39):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,40).
avance2(A,B,C,D,1,X,40):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,41).
avance2(A,B,C,D,1,X,41):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,42).
avance2(A,B,C,D,1,X,42):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,43).
avance2(A,B,C,D,1,X,43):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,44).
avance2(A,B,C,D,1,X,44):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,45).
avance2(A,B,C,D,1,X,45):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,46).
avance2(A,B,C,D,1,X,46):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,47).
avance2(A,B,C,D,1,X,47):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,48).
avance2(A,B,C,D,1,X,48):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,49).
avance2(A,B,C,D,1,X,49):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,50).
avance2(A,B,C,D,1,X,50):-compkhan2(A,B,1),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,51).
avance2(A,B,C,D,1,X,51):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,52).
avance2(A,B,C,D,1,X,52):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,53).
avance2(A,B,C,D,1,X,53):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,54).
avance2(A,B,C,D,1,X,54):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,55).
avance2(A,B,C,D,1,X,55):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,56).
avance2(A,B,C,D,1,X,56):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,57).
avance2(A,B,C,D,1,X,57):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,58).
avance2(A,B,C,D,1,X,58):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,59).
avance2(A,B,C,D,1,X,59):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,60).
avance2(A,B,C,D,1,X,60):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,61).
avance2(A,B,C,D,1,X,61):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,62).
avance2(A,B,C,D,1,X,62):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,63).
avance2(A,B,C,D,1,X,63):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,64).
avance2(A,B,C,D,1,X,64):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,65).
avance2(A,B,C,D,1,X,65):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,66).
avance2(A,B,C,D,1,X,66):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,67).
avance2(A,B,C,D,1,X,67):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,68).
avance2(A,B,C,D,1,X,68):-compkhan2(A,B,1),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,69).
avance2(A,B,C,D,1,X,69):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,70).
avance2(A,B,C,D,1,X,70):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,71).
avance2(A,B,C,D,1,X,71):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,72).
avance2(A,B,C,D,1,X,72):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,73).
avance2(A,B,C,D,1,X,73):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,74).
avance2(A,B,C,D,1,X,74):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,75).
avance2(A,B,C,D,1,X,75):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,76).
avance2(A,B,C,D,1,X,76):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,77).
avance2(A,B,C,D,1,X,77):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,78).
avance2(A,B,C,D,1,X,78):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,79).
avance2(A,B,C,D,1,X,79):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,80).
avance2(A,B,C,D,1,X,80):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,81).
avance2(A,B,C,D,1,X,81):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,82).
avance2(A,B,C,D,1,X,82):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,83).
avance2(A,B,C,D,1,X,83):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,84).
avance2(A,B,C,D,1,X,84):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,85).
avance2(A,B,C,D,1,X,85):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,86).
avance2(A,B,C,D,1,X,86):-compkhan2(A,B,1),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,87).
avance2(A,B,C,D,1,X,87):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,88).
avance2(A,B,C,D,1,X,88):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,89).
avance2(A,B,C,D,1,X,89):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,90).
avance2(A,B,C,D,1,X,90):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,91).
avance2(A,B,C,D,1,X,91):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,92).
avance2(A,B,C,D,1,X,92):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,93).
avance2(A,B,C,D,1,X,93):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,94).
avance2(A,B,C,D,1,X,94):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,95).
avance2(A,B,C,D,1,X,95):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,96).
avance2(A,B,C,D,1,X,96):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,97).
avance2(A,B,C,D,1,X,97):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,98).
avance2(A,B,C,D,1,X,98):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,99).
avance2(A,B,C,D,1,X,99):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,100).
avance2(A,B,C,D,1,X,100):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,101).
avance2(A,B,C,D,1,X,101):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,102).
avance2(A,B,C,D,1,X,102):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,103).
avance2(A,B,C,D,1,X,103):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,1,_,104).
avance2(A,B,C,D,1,X,104):-compkhan2(A,B,1),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),!.

/*avance2 pour board2*/

avance2(A,B,C,D,2,X,1):-compkhan2(A,B,2),khan(1),pionBouge2G(A,B,2),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,2).
avance2(A,B,C,D,2,X,2):-compkhan2(A,B,2),khan(1),kill2G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,3).
avance2(A,B,C,D,2,X,3):-compkhan2(A,B,2),khan(1),pionBouge2D(A,B,2),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,4).
avance2(A,B,C,D,2,X,4):-compkhan2(A,B,2),khan(1),kill2D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,5).
avance2(A,B,C,D,2,X,5):-compkhan2(A,B,2),khan(1),pionBouge2H(A,B,2),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,6).
avance2(A,B,C,D,2,X,6):-compkhan2(A,B,2),khan(1),kill2H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,7).
avance2(A,B,C,D,2,X,7):-compkhan2(A,B,2),khan(1),pionBouge2B(A,B,2),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,8).
avance2(A,B,C,D,2,X,8):-compkhan2(A,B,2),khan(1),kill2B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,2,X,9):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,10).
avance2(A,B,C,D,2,X,10):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill2G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,11).
avance2(A,B,C,D,2,X,11):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,12).
avance2(A,B,C,D,2,X,12):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill2H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,13).
avance2(A,B,C,D,2,X,13):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,14).
avance2(A,B,C,D,2,X,14):-compkhan2(A,B,2),khan(2),moveG(A,B),A1 is A-1,kill2B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,15).
avance2(A,B,C,D,2,X,15):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,16).
avance2(A,B,C,D,2,X,16):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill2D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,17).
avance2(A,B,C,D,2,X,17):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,18).
avance2(A,B,C,D,2,X,18):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill2H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,19).
avance2(A,B,C,D,2,X,19):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,20).
avance2(A,B,C,D,2,X,20):-compkhan2(A,B,2),khan(2),moveD(A,B),A1 is A+1,kill2B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,21).
avance2(A,B,C,D,2,X,21):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,22).
avance2(A,B,C,D,2,X,22):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,23).
avance2(A,B,C,D,2,X,23):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,24).
avance2(A,B,C,D,2,X,24):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill2H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,25).
avance2(A,B,C,D,2,X,25):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,26).
avance2(A,B,C,D,2,X,26):-compkhan2(A,B,2),khan(2),moveH(A,B),B1 is B+1,kill2G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,27).
avance2(A,B,C,D,2,X,27):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,28).
avance2(A,B,C,D,2,X,28):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,29).
avance2(A,B,C,D,2,X,29):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,30).
avance2(A,B,C,D,2,X,30):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill2B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,31).
avance2(A,B,C,D,2,X,31):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,32).
avance2(A,B,C,D,2,X,32):-compkhan2(A,B,2),khan(2),moveB(A,B),B1 is B-1,kill2G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,2,X,33):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,34).
avance2(A,B,C,D,2,X,34):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,35).
avance2(A,B,C,D,2,X,35):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,36).
avance2(A,B,C,D,2,X,36):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,37).
avance2(A,B,C,D,2,X,37):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,38).
avance2(A,B,C,D,2,X,38):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,39).
avance2(A,B,C,D,2,X,39):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,40).
avance2(A,B,C,D,2,X,40):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,41).
avance2(A,B,C,D,2,X,41):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,42).
avance2(A,B,C,D,2,X,42):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,43).
avance2(A,B,C,D,2,X,43):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,44).
avance2(A,B,C,D,2,X,44):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,45).
avance2(A,B,C,D,2,X,45):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,46).
avance2(A,B,C,D,2,X,46):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,47).
avance2(A,B,C,D,2,X,47):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,48).
avance2(A,B,C,D,2,X,48):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,49).
avance2(A,B,C,D,2,X,49):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,50).
avance2(A,B,C,D,2,X,50):-compkhan2(A,B,2),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,51).
avance2(A,B,C,D,2,X,51):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,52).
avance2(A,B,C,D,2,X,52):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,53).
avance2(A,B,C,D,2,X,53):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,54).
avance2(A,B,C,D,2,X,54):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,55).
avance2(A,B,C,D,2,X,55):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,56).
avance2(A,B,C,D,2,X,56):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,57).
avance2(A,B,C,D,2,X,57):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,58).
avance2(A,B,C,D,2,X,58):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,59).
avance2(A,B,C,D,2,X,59):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,60).
avance2(A,B,C,D,2,X,60):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,61).
avance2(A,B,C,D,2,X,61):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,62).
avance2(A,B,C,D,2,X,62):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,63).
avance2(A,B,C,D,2,X,63):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,64).
avance2(A,B,C,D,2,X,64):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,65).
avance2(A,B,C,D,2,X,65):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,66).
avance2(A,B,C,D,2,X,66):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,67).
avance2(A,B,C,D,2,X,67):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,68).
avance2(A,B,C,D,2,X,68):-compkhan2(A,B,2),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,69).
avance2(A,B,C,D,2,X,69):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,70).
avance2(A,B,C,D,2,X,70):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,71).
avance2(A,B,C,D,2,X,71):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,72).
avance2(A,B,C,D,2,X,72):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,73).
avance2(A,B,C,D,2,X,73):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,74).
avance2(A,B,C,D,2,X,74):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,75).
avance2(A,B,C,D,2,X,75):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,76).
avance2(A,B,C,D,2,X,76):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,77).
avance2(A,B,C,D,2,X,77):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,78).
avance2(A,B,C,D,2,X,78):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,79).
avance2(A,B,C,D,2,X,79):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,80).
avance2(A,B,C,D,2,X,80):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,81).
avance2(A,B,C,D,2,X,81):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,82).
avance2(A,B,C,D,2,X,82):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,83).
avance2(A,B,C,D,2,X,83):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,84).
avance2(A,B,C,D,2,X,84):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,85).
avance2(A,B,C,D,2,X,85):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,86).
avance2(A,B,C,D,2,X,86):-compkhan2(A,B,2),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,87).
avance2(A,B,C,D,2,X,87):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,88).
avance2(A,B,C,D,2,X,88):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,89).
avance2(A,B,C,D,2,X,89):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,90).
avance2(A,B,C,D,2,X,90):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,91).
avance2(A,B,C,D,2,X,91):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,92).
avance2(A,B,C,D,2,X,92):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,93).
avance2(A,B,C,D,2,X,93):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,94).
avance2(A,B,C,D,2,X,94):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,95).
avance2(A,B,C,D,2,X,95):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,96).
avance2(A,B,C,D,2,X,96):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,97).
avance2(A,B,C,D,2,X,97):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,98).
avance2(A,B,C,D,2,X,98):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,99).
avance2(A,B,C,D,2,X,99):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,100).
avance2(A,B,C,D,2,X,100):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,101).
avance2(A,B,C,D,2,X,101):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,102).
avance2(A,B,C,D,2,X,102):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,103).
avance2(A,B,C,D,2,X,103):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,2,_,104).
avance2(A,B,C,D,2,X,104):-compkhan2(A,B,2),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),!.

/*avance2 pour board3*/


avance2(A,B,C,D,3,X,1):-compkhan2(A,B,3),khan(1),pionBouge2G(A,B,3),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,2).
avance2(A,B,C,D,3,X,2):-compkhan2(A,B,3),khan(1),kill2G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,3).
avance2(A,B,C,D,3,X,3):-compkhan2(A,B,3),khan(1),pionBouge2D(A,B,3),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,4).
avance2(A,B,C,D,3,X,4):-compkhan2(A,B,3),khan(1),kill2D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,5).
avance2(A,B,C,D,3,X,5):-compkhan2(A,B,3),khan(1),pionBouge2H(A,B,3),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,6).
avance2(A,B,C,D,3,X,6):-compkhan2(A,B,3),khan(1),kill2H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,7).
avance2(A,B,C,D,3,X,7):-compkhan2(A,B,3),khan(1),pionBouge2B(A,B,3),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,8).
avance2(A,B,C,D,3,X,8):-compkhan2(A,B,3),khan(1),kill2B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,3,X,9):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,10).
avance2(A,B,C,D,3,X,10):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill2G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,11).
avance2(A,B,C,D,3,X,11):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,12).
avance2(A,B,C,D,3,X,12):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill2H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,13).
avance2(A,B,C,D,3,X,13):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,14).
avance2(A,B,C,D,3,X,14):-compkhan2(A,B,3),khan(2),moveG(A,B),A1 is A-1,kill2B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,15).
avance2(A,B,C,D,3,X,15):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,16).
avance2(A,B,C,D,3,X,16):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill2D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,17).
avance2(A,B,C,D,3,X,17):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,18).
avance2(A,B,C,D,3,X,18):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill2H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,19).
avance2(A,B,C,D,3,X,19):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,20).
avance2(A,B,C,D,3,X,20):-compkhan2(A,B,3),khan(2),moveD(A,B),A1 is A+1,kill2B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,21).
avance2(A,B,C,D,3,X,21):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,22).
avance2(A,B,C,D,3,X,22):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,23).
avance2(A,B,C,D,3,X,23):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,24).
avance2(A,B,C,D,3,X,24):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill2H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,25).
avance2(A,B,C,D,3,X,25):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,26).
avance2(A,B,C,D,3,X,26):-compkhan2(A,B,3),khan(2),moveH(A,B),B1 is B+1,kill2G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,27).
avance2(A,B,C,D,3,X,27):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,28).
avance2(A,B,C,D,3,X,28):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,29).
avance2(A,B,C,D,3,X,29):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,30).
avance2(A,B,C,D,3,X,30):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill2B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,31).
avance2(A,B,C,D,3,X,31):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,32).
avance2(A,B,C,D,3,X,32):-compkhan2(A,B,3),khan(2),moveB(A,B),B1 is B-1,kill2G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,3,X,33):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,34).
avance2(A,B,C,D,3,X,34):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,35).
avance2(A,B,C,D,3,X,35):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,36).
avance2(A,B,C,D,3,X,36):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,37).
avance2(A,B,C,D,3,X,37):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,38).
avance2(A,B,C,D,3,X,38):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,39).
avance2(A,B,C,D,3,X,39):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,40).
avance2(A,B,C,D,3,X,40):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,41).
avance2(A,B,C,D,3,X,41):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,42).
avance2(A,B,C,D,3,X,42):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,43).
avance2(A,B,C,D,3,X,43):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,44).
avance2(A,B,C,D,3,X,44):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,45).
avance2(A,B,C,D,3,X,45):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,46).
avance2(A,B,C,D,3,X,46):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,47).
avance2(A,B,C,D,3,X,47):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,48).
avance2(A,B,C,D,3,X,48):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,49).
avance2(A,B,C,D,3,X,49):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,50).
avance2(A,B,C,D,3,X,50):-compkhan2(A,B,3),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,51).
avance2(A,B,C,D,3,X,51):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,52).
avance2(A,B,C,D,3,X,52):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,53).
avance2(A,B,C,D,3,X,53):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,54).
avance2(A,B,C,D,3,X,54):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,55).
avance2(A,B,C,D,3,X,55):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,56).
avance2(A,B,C,D,3,X,56):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,57).
avance2(A,B,C,D,3,X,57):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,58).
avance2(A,B,C,D,3,X,58):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,59).
avance2(A,B,C,D,3,X,59):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,60).
avance2(A,B,C,D,3,X,60):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,61).
avance2(A,B,C,D,3,X,61):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,62).
avance2(A,B,C,D,3,X,62):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,63).
avance2(A,B,C,D,3,X,63):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,64).
avance2(A,B,C,D,3,X,64):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,65).
avance2(A,B,C,D,3,X,65):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,66).
avance2(A,B,C,D,3,X,66):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,67).
avance2(A,B,C,D,3,X,67):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,68).
avance2(A,B,C,D,3,X,68):-compkhan2(A,B,3),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,69).
avance2(A,B,C,D,3,X,69):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,70).
avance2(A,B,C,D,3,X,70):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,71).
avance2(A,B,C,D,3,X,71):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,72).
avance2(A,B,C,D,3,X,72):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,73).
avance2(A,B,C,D,3,X,73):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,74).
avance2(A,B,C,D,3,X,74):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,75).
avance2(A,B,C,D,3,X,75):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,76).
avance2(A,B,C,D,3,X,76):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,77).
avance2(A,B,C,D,3,X,77):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,78).
avance2(A,B,C,D,3,X,78):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,79).
avance2(A,B,C,D,3,X,79):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,80).
avance2(A,B,C,D,3,X,80):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,81).
avance2(A,B,C,D,3,X,81):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,82).
avance2(A,B,C,D,3,X,82):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,83).
avance2(A,B,C,D,3,X,83):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,84).
avance2(A,B,C,D,3,X,84):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,85).
avance2(A,B,C,D,3,X,85):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,86).
avance2(A,B,C,D,3,X,86):-compkhan2(A,B,3),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,87).
avance2(A,B,C,D,3,X,87):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,88).
avance2(A,B,C,D,3,X,88):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,89).
avance2(A,B,C,D,3,X,89):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,90).
avance2(A,B,C,D,3,X,90):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,91).
avance2(A,B,C,D,3,X,91):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,92).
avance2(A,B,C,D,3,X,92):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,93).
avance2(A,B,C,D,3,X,93):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,94).
avance2(A,B,C,D,3,X,94):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,95).
avance2(A,B,C,D,3,X,95):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,96).
avance2(A,B,C,D,3,X,96):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,97).
avance2(A,B,C,D,3,X,97):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,98).
avance2(A,B,C,D,3,X,98):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,99).
avance2(A,B,C,D,3,X,99):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,100).
avance2(A,B,C,D,3,X,100):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,101).
avance2(A,B,C,D,3,X,101):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,102).
avance2(A,B,C,D,3,X,102):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,103).
avance2(A,B,C,D,3,X,103):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,3,_,104).
avance2(A,B,C,D,3,X,104):-compkhan2(A,B,3),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),!.

/*avance2 pour board4*/

avance2(A,B,C,D,4,X,1):-compkhan2(A,B,4),khan(1),pionBouge2G(A,B,4),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,2).
avance2(A,B,C,D,4,X,2):-compkhan2(A,B,4),khan(1),kill2G(A,B),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,3).
avance2(A,B,C,D,4,X,3):-compkhan2(A,B,4),khan(1),pionBouge2D(A,B,4),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,4).
avance2(A,B,C,D,4,X,4):-compkhan2(A,B,4),khan(1),kill2D(A,B),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,5).
avance2(A,B,C,D,4,X,5):-compkhan2(A,B,4),khan(1),pionBouge2H(A,B,4),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,6).
avance2(A,B,C,D,4,X,6):-compkhan2(A,B,4),khan(1),kill2H(A,B),D is B+1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,7).
avance2(A,B,C,D,4,X,7):-compkhan2(A,B,4),khan(1),pionBouge2B(A,B,4),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,8).
avance2(A,B,C,D,4,X,8):-compkhan2(A,B,4),khan(1),kill2B(A,B),D is B-1,C is A,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,4,X,9):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveG(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,10).
avance2(A,B,C,D,4,X,10):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill2G(A1,B),C is A-2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,11).
avance2(A,B,C,D,4,X,11):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveH(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,12).
avance2(A,B,C,D,4,X,12):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill2H(A1,B),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,13).
avance2(A,B,C,D,4,X,13):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,moveB(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,14).
avance2(A,B,C,D,4,X,14):-compkhan2(A,B,4),khan(2),moveG(A,B),A1 is A-1,kill2B(A1,B),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,15).
avance2(A,B,C,D,4,X,15):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveD(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,16).
avance2(A,B,C,D,4,X,16):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill2D(A1,B),C is A+2,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,17).
avance2(A,B,C,D,4,X,17):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveH(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,18).
avance2(A,B,C,D,4,X,18):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill2H(A1,B),C is A+1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,19).
avance2(A,B,C,D,4,X,19):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,moveB(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,20).
avance2(A,B,C,D,4,X,20):-compkhan2(A,B,4),khan(2),moveD(A,B),A1 is A+1,kill2B(A1,B),C is A+1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,21).
avance2(A,B,C,D,4,X,21):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,22).
avance2(A,B,C,D,4,X,22):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,23).
avance2(A,B,C,D,4,X,23):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveH(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,24).
avance2(A,B,C,D,4,X,24):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill2H(A,B1),C is A,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,25).
avance2(A,B,C,D,4,X,25):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,moveG(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,26).
avance2(A,B,C,D,4,X,26):-compkhan2(A,B,4),khan(2),moveH(A,B),B1 is B+1,kill2G(A,B1),C is A-1,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,27).
avance2(A,B,C,D,4,X,27):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveD(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,28).
avance2(A,B,C,D,4,X,28):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill2D(A,B1),C is A+1,D is B1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,29).
avance2(A,B,C,D,4,X,29):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveB(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,30).
avance2(A,B,C,D,4,X,30):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill2B(A,B1),C is A,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,31).
avance2(A,B,C,D,4,X,31):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,moveG(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,32).
avance2(A,B,C,D,4,X,32):-compkhan2(A,B,4),khan(2),moveB(A,B),B1 is B-1,kill2G(A,B1),C is A-1,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),!.
avance2(A,B,C,D,4,X,33):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveG(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,34).
avance2(A,B,C,D,4,X,34):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2G(A2,B),C is A-3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,35).
avance2(A,B,C,D,4,X,35):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveH(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,36).
avance2(A,B,C,D,4,X,36):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2H(A2,B),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,37).
avance2(A,B,C,D,4,X,37):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,moveB(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,38).
avance2(A,B,C,D,4,X,38):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveG(A1,B),A2 is A1-1,kill2B(A2,B),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,39).
avance2(A,B,C,D,4,X,39):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,40).
avance2(A,B,C,D,4,X,40):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,41).
avance2(A,B,C,D,4,X,41):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,42).
avance2(A,B,C,D,4,X,42):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,43).
avance2(A,B,C,D,4,X,43):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,44).
avance2(A,B,C,D,4,X,44):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,45).
avance2(A,B,C,D,4,X,45):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,46).
avance2(A,B,C,D,4,X,46):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,47).
avance2(A,B,C,D,4,X,47):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,48).
avance2(A,B,C,D,4,X,48):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,49).
avance2(A,B,C,D,4,X,49):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,50).
avance2(A,B,C,D,4,X,50):-compkhan2(A,B,4),khan(3),moveG(A,B),A1 is A-1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,51).
avance2(A,B,C,D,4,X,51):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveD(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,52).
avance2(A,B,C,D,4,X,52):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2D(A2,B),C is A+3,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,53).
avance2(A,B,C,D,4,X,53):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveH(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,54).
avance2(A,B,C,D,4,X,54):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2H(A2,B),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,55).
avance2(A,B,C,D,4,X,55):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,moveB(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,56).
avance2(A,B,C,D,4,X,56):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveD(A1,B),A2 is A+2,kill2B(A2,B),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,57).
avance2(A,B,C,D,4,X,57):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,58).
avance2(A,B,C,D,4,X,58):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,59).
avance2(A,B,C,D,4,X,59):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveG(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,60).
avance2(A,B,C,D,4,X,60):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2G(A1,B1),C is A,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,61).
avance2(A,B,C,D,4,X,61):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,62).
avance2(A,B,C,D,4,X,62):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveH(A1,B),B1 is B+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,63).
avance2(A,B,C,D,4,X,63):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveG(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,64).
avance2(A,B,C,D,4,X,64):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2G(A1,B1),C is A,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,65).
avance2(A,B,C,D,4,X,65):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,66).
avance2(A,B,C,D,4,X,66):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,67).
avance2(A,B,C,D,4,X,67):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,68).
avance2(A,B,C,D,4,X,68):-compkhan2(A,B,4),khan(3),moveD(A,B),A1 is A+1,moveB(A1,B),B1 is B-1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,69).
avance2(A,B,C,D,4,X,69):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,70).
avance2(A,B,C,D,4,X,70):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,71).
avance2(A,B,C,D,4,X,71):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,72).
avance2(A,B,C,D,4,X,72):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,73).
avance2(A,B,C,D,4,X,73):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,74).
avance2(A,B,C,D,4,X,74):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,75).
avance2(A,B,C,D,4,X,75):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,76).
avance2(A,B,C,D,4,X,76):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B+1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,77).
avance2(A,B,C,D,4,X,77):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,78).
avance2(A,B,C,D,4,X,78):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,79).
avance2(A,B,C,D,4,X,79):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,80).
avance2(A,B,C,D,4,X,80):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,81).
avance2(A,B,C,D,4,X,81):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveG(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,82).
avance2(A,B,C,D,4,X,82):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2G(A,B2),C is A-1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,83).
avance2(A,B,C,D,4,X,83):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveD(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,84).
avance2(A,B,C,D,4,X,84):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2D(A,B2),C is A+1,D is B+2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,85).
avance2(A,B,C,D,4,X,85):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,moveH(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,86).
avance2(A,B,C,D,4,X,86):-compkhan2(A,B,4),khan(3),moveH(A,B),B1 is B+1,moveH(A,B1),B2 is B+2,kill2H(A,B2),C is A,D is B+3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,87).
avance2(A,B,C,D,4,X,87):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveG(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,88).
avance2(A,B,C,D,4,X,88):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2G(A1,B1),C is A-2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,89).
avance2(A,B,C,D,4,X,89):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveH(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,90).
avance2(A,B,C,D,4,X,90):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2H(A1,B1),C is A-1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,91).
avance2(A,B,C,D,4,X,91):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,moveB(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,92).
avance2(A,B,C,D,4,X,92):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveG(A,B1),A1 is A-1,kill2B(A1,B1),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,93).
avance2(A,B,C,D,4,X,93):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveD(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,94).
avance2(A,B,C,D,4,X,94):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2D(A1,B1),C is A+2,D is B-1,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,95).
avance2(A,B,C,D,4,X,95):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveH(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,96).
avance2(A,B,C,D,4,X,96):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2H(A1,B1),C is A+1,D is B,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,97).
avance2(A,B,C,D,4,X,97):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,moveB(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,98).
avance2(A,B,C,D,4,X,98):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveD(A,B1),A1 is A+1,kill2B(A1,B1),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,99).
avance2(A,B,C,D,4,X,99):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveG(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,100).
avance2(A,B,C,D,4,X,100):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2G(A,B2),C is A-1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,101).
avance2(A,B,C,D,4,X,101):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveD(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,102).
avance2(A,B,C,D,4,X,102):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2D(A,B2),C is A+1,D is B-2,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,103).
avance2(A,B,C,D,4,X,103):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,moveB(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),avance2(A,B,_,_,4,_,104).
avance2(A,B,C,D,4,X,104):-compkhan2(A,B,4),khan(3),moveB(A,B),B1 is B-1,moveB(A,B1),B2 is B-2,kill2B(A,B2),C is A,D is B-3,X=[A,B,C,D],asserta(moveposs2(X)),!.




/*Creation de la liste des mouvements possibles*/
display1(0).
display1(N):-setof(X,listepos1(X),R),N1 is N-1,nth0(N1,R,A),nth0(0,A,X),nth0(1,A,Y),setof(Z,cote(Z),K),nth0(0,K,C),avance1(X,Y,_,_,C,_,_).
listmove1(_):-display1(6).
listmove1(_):-display1(5).
listmove1(_):-display1(4).
listmove1(_):-display1(3).
listmove1(_):-display1(2).
listmove1(_):-display1(1).
listmove1(_).
display2(0).
display2(N):-setof(X,listepos2(X),R),N1 is N-1,nth0(N1,R,A),nth0(0,A,X),nth0(1,A,Y),setof(Z,cote(Z),K),nth0(0,K,C),avance2(X,Y,_,_,C,_,_).
listmove2(_):-display2(6).
listmove2(_):-display2(5).
listmove2(_):-display2(4).
listmove2(_):-display2(3).
listmove2(_):-display2(2).
listmove2(_):-display2(1).
listmove2(_).


/*L'ordinateur prend la Kalista*/

killKalista1(R):-setof(X,poskalista1(X),K),nth0(0,K,K1),nth0(0,K1,KX),nth0(1,K1,KY),length(R,N),N1 is N-1,testKillKalista1(R,KX,KY,N1).

testKillKalista1(R,X,Y,-1):-!,fail.
testKillKalista1(R,X,Y,N):-nth0(N,R,P),nth0(2,P,X1),nth0(3,P,Y1),X==X1,Y==Y1,retractall(kalista1(_,_)),write('l ordinateur a pris la Kalista : Partie Terminée!'),nl,!.
testKillKalista1(R,X,Y,N):-N1 is N-1,testKillKalista1(R,X,Y,N1).

/*Test si le mouvement entraine la prise de la kalista de l'ordi au prochain tour*/

killKalista2(_):-listmove1(_),setof(X,moveposs1(X),R),setof(X,poskalista2(X),K),nth0(0,K,K1),nth0(0,K1,KX),nth0(1,K1,KY),length(R,N),N1 is N-1,testKillKalista2(R,KX,KY,N1).

testKillKalista2(R,X,Y,-1):-retractall(moveposs1([_,_,_,_])),!,fail.
testKillKalista2(R,X,Y,N):-nth0(N,R,P),nth0(2,P,X1),nth0(3,P,Y1),X==X1,Y==Y1,retractall(moveposs1([_,_,_,_])),!.
testKillKalista2(R,X,Y,N):-N1 is N-1,testKillKalista2(R,X,Y,N1).


/*Stockage dans la liste listeKill1 des movements conduisants l'ordi à prendre un pion au J1*/

killPion1(R):-setof(X,listepos1(X),P),length(P,N),N1 is N-1,testKillPion1(R,P,N1).

testKillPion1(R,P,-1):-true,!.
testKillPion1(R,P,N):-nth0(N,P,P1),nth0(0,P1,PX),nth0(1,P1,PY),length(R,M),existKillPion1(R,M,PX,PY),N1 is N-1,testKillPion1(R,P,N1). /*on prend les coordonées du neme pion et on regarde si un mouvement permet de le tuer,puis on regarde le pion suivant*/
testKillPion1(R,P,N):-N1 is N-1,testKillPion1(R,P,N1).

existKillPion1(R,-1,PX,PY):-true,!.
existKillPion1(R,M,PX,PY):-nth0(M,R,P),nth0(2,P,X),nth0(3,P,Y),X==PX,Y==PY,asserta(listeKill1(P)),M1 is M-1,existKillPion1(R,M1,PX,PY).   /* on parcours la liste des mouvements et on regarde si les coord d'arrivées correspondent a un pion existant si oui on l'ajoute a la liste*/
existKillPion1(R,M,PX,PY):-M1 is M-1,existKillPion1(R,M1,PX,PY).

/*Test permetant de voir si le J1 peut prend un pion à l'ordi*/

killPion2(_):-listmove1(_),setof(X,moveposs1(X),R),setof(X,listepos2(X),P),length(P,N),N1 is N-1,testKillPion2(R,P,N1).

testKillPion2(R,P,-1):-!,fail.
testKillPion2(R,P,N):-nth0(N,P,P1),nth0(0,P1,PX),nth0(1,P1,PY),length(R,M),M1 is M-1,existKillPion2(R,M1,PX,PY),!.   /*on prend les coordonées du neme pion et on regarde si un mouvement permet de le tuer si oui on arrete le mouvement n'est plus accepté*/
testKillPion2(R,P,N):-N1 is N-1,testKillPion2(R,P,N1).

existKillPion2(R,-1,PX,PY):-!,fail.
existKillPion2(R,M,PX,PY):-nth0(M,R,J),nth0(2,J,X),nth0(3,J,Y),X==PX,Y==PY,!. /* on parcours la liste des mouvements et on regarde si les coord d'arrivées correspondent a un pion existant*/
existKillPion2(R,M,PX,PY):-M1 is M-1,existKillPion2(R,M1,PX,PY).


/*L'ordinateur prend un pion sans que l adversaire n'en prenne un en retour ou ressucite un pion*/

killPion1Top(R):-killPion1(R),setof(X,listeKill1(X),K),length(K,N),N1 is N-1,testKhanKillPion1(K,N1),setof(Y,listeKill1pos(Y),P),length(P,M),M1 is M-1,testKillBack1(P,M1).


/*on prend les cords d'arrivée du neme pion qui peut en tuer un autre
on prend les cords d'arrivée du neme pion qui peut en tuer un autre
on va parcourir la liste des positions des pions1 et voir si un des pions a la valeur V si oui on stock le mouvement
si cela a echoué on regarde si le pion suivant satisfait la condition*/

testKhanKillPion1(K,-1):-true,!.
testKhanKillPion1(K,N):-nth0(N,K,P),nth0(2,P,X),nth0(3,P,Y),setof(Z,cote(Z),J),nth0(0,J,C),val_case(X,Y,C),setof(G,val(G),H),nth0(0,H,V),setof(A,listepos1(A),L),length(L,M),M1 is M-1,existeValPions1(L,V,M1,C,P),N1 is N-1,testKhanKillPion1(K,N1).   
testKhanKillPion1(K,N):-N1 is N-1,testKhanKillPion1(K,N1). 

/*si on arrive au bout de la liste alors c'est que la condition n'est pas satisfaite
 si une des cases a la valeur V le J1 ne peux pas resuciter de pion on stock le mouvement*/

 
existeValPions1(L,V,-1,C,K):-!,fail.			
existeValPions1(L,V,M,C,K):-nth0(M,L,P),nth0(0,P,X),nth0(1,P,Y),val_case(X,Y,C),(val(V)),asserta(listeKill1pos(K)),!.
existeValPions1(L,V,M,C,K):-M1 is M-1,existeValPions1(L,V,M1,C,K).

/*si on arrive au bout des mouvement a tester c'est que aucun n'est valide
on etablit la nouvelle configuration du plateau pour réaliser le test suivant, si il est bon on la conserve, sinon on reviens en arrière
on réétabli la configuration initiale puis on test la validité du mouvement suivant dans la liste*/

testKillBack1(P,-1):-!,fail. 
testKillBack1(P,M):-nth0(M,P,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(A,B),retract(listepos2([A,B])),enlever1(C,D),retract(listepos1([C,D])),
				ajouter2(C,D),asserta(listepos2([C,D])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(C,D,S),setof(Z,val(Z),H),nth0(0,H,V),replaceKhan(V),
				not(killPion2(_)),retractall(listeKill1pos([_,_,_,_])),retractall(listeKill1([_,_,_,_])),!.
testKillBack1(P,M):-nth0(M,P,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(C,D),retract(listepos2([C,D])),ajouter1(C,D),asserta(listepos1([C,D])),
				ajouter2(A,B),asserta(listepos2([A,B])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(A,B,S),setof(Z,val(Z),H),nth0(0,H,V),replaceKhan(V),M1 is M-1,testKillBack1(P,M1).
				
				
testKillBackavancer1(P,-1):-!,fail. 
testKillBackavancer1(P,M):-nth0(M,P,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(A,B),retract(listepos2([A,B])),
				ajouter2(C,D),asserta(listepos2([C,D])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(C,D,S),setof(Z,val(Z),H),nth0(0,H,V),replaceKhan(V),
				not(killPion2(_)),retractall(listeKill1pos([_,_,_,_])),retractall(listeKill1([_,_,_,_])),!.
testKillBackavancer1(P,M):-nth0(M,P,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(C,D),retract(listepos2([C,D])),
				ajouter2(A,B),asserta(listepos2([A,B])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(A,B,S),setof(Z,val(Z),H),nth0(0,H,V),replaceKhan(V),M1 is M-1,testKillBackavancer1(P,M1).
				
/* Test si aucune piece correspond au khan*/

testres(_):-setof(X,listepos2(X),R),length(R,N),N<6,N1 is N-1,testrespiece(R,N1).
testrespiece(R,-1):-true,!.
testrespiece(R,N):-nth0(N,R,Z),nth0(0,Z,X),nth0(1,Z,Y),setof(A,cote(A),K),nth0(0,K,C),val_case(X,Y,C),setof(G,val(G),H),nth0(0,H,V),(khan(V)),!,fail.  /* si jamais la valeur d'une piece est celle du khan, faux et on sort*/ 
testrespiece(R,N):-N1 is N-1,testrespiece(R,N1).

/* resusciter un pion et le placer sans que l'averse ne prenne la kalista au tour suivant*/

ressuciter(_):-testres(_),not(killKalista2(_)),testressuciter(11),setof(A,respos2(A),L),nth0(0,L,Z),nth0(0,Z,X),nth0(1,Z,Y),retractall(respos2([_,_])),(asserta(pions2(X,Y))),asserta(listepos2([X,Y])).

testressuciter(-1):-true,!.
testressuciter(N):-L=[[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],[1,6],[2,6],[3,6],[4,6],[5,6],[6,6]],nth0(N,L,Z),nth0(0,Z,X),nth0(1,Z,Y),libre(X,Y),
				setof(B,cote(B),K),nth0(0,K,C),val_case(X,Y,C),setof(A,val(A),H),nth0(0,H,V),khan(V),
				asserta(respos2([X,Y])),N1 is N-1,testressuciter(N1).
testressuciter(N):-N1 is N-1,testressuciter(N1).

/*ressuciter un pion et le placer sans qu'il ne se fasse prendre au prochain tour*/

ressuciterTop(_):-testres(_),not(killKalista2(_)),testressuciter(11),testressuciterTop(11).
testressuciterTop(-1):-!,fail.
testressuciterTop(N):-setof(A,respos2(A),L),N1 is 11-N,nth0(N1,L,Z),nth0(0,Z,X),nth0(1,Z,Y),not(killPion2(_)),retractall(respos2([_,_])),(asserta(pions2(X,Y))),asserta(listepos2([X,Y])),!.
testressuciterTop(N):-N1 is N-1,testressuciterTop(N1).

/*Avancer un pion sans que l'adversaire ne puisse ressuciter ou prendre un pion*/

avancerTop(R):-length(R,N),N1 is N-1,testKhanKillPion1(R,N1),setof(Y,listeKill1pos(Y),P),length(P,M),M1 is M-1,testKillBackavancer1(P,M1).


/*l'ordi prend un pion et protège sa Kalista au tour suivant*/

killPion1Bof(R):-killPion1(R),setof(X,listeKill1(X),K),length(K,N),N1 is N-1,killsafe(K,N1).

killsafe(K,-1):-!,fail.
killsafe(K,N):-nth0(N,R,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(A,B),retract(listepos2([A,B])),enlever1(C,D),retract(listepos1([C,D])),ajouter1(C,D),asserta(listepos2([C,D])),
				setof(Z,cote(Z),J),nth0(0,J,S),val_case(C,D,S),setof(G,val(G),H),nth0(0,H,V),replaceKhan(V),not(killKalista2(_)),retractall(listeKill1([_,_,_,_])),!.
killsafe(K,N):-nth0(N,R,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(C,D),retract(listepos2([C,D])),ajouter2(A,B),asserta(listepos2([A,B])),ajouter1(C,D),asserta(listepos1([C,D])),
				setof(Z,cote(Z),J),nth0(0,J,S),val_case(A,B,S),setof(G,val(G),H),nth0(0,H,V),replaceKhan(V),N1 is N-1,killsafe(K,N1).
				
/*Avancer un pion et juste proteger la Kalista au tour suivant*/

avancerBof(R):-length(R,N),N1 is N-1,testAvancerBof(R,N1).

testAvancerBof(R,-1):-!,fail.
testAvancerBof(R,N):-nth0(N,R,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(A,B),retract(listepos2([A,B])),ajouter2(C,D),assertz(listepos2([C,D])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(C,D,S),setof(G,val(G),H),nth0(0,H,V),replaceKhan(V),not(killKalista2(_)),!.
testAvancerBof(R,N):-nth0(N,R,X),nth0(0,X,A),nth0(1,X,B),nth0(2,X,C),nth0(3,X,D),enlever2(C,D),retract(listepos2([C,D])),ajouter2(A,B),assertz(listepos2([A,B])),setof(Z,cote(Z),K),nth0(0,K,S),val_case(A,B,S),setof(G,val(G),H),nth0(0,H,V),replaceKhan(V),N1 is N-1,testAvancerBof(R,N1).
				
/*Mouvement random si y'a plus rien*/

randommove(R):-length(R,N),N1 is N-1,testrandom(R,N1).

testrandom(R,-1):-!,fail.
testrandom(R,N):-nth0(N,R,X),nth0(0,X,A),nth0(1,X,B),setof(Z,cote(Z),K),compkhan2(A,B,K),nth0(2,X,C),nth0(3,X,D),
				enlever2(A,B),retract(listepos2([A,B])),ajouter2(C,D),assertz(listepos2([C,D])),val_case(C,D,S),setof(G,val(G),H),nth0(0,H,V),replaceKhan(V),!.
testrandom(R,N):-N1 is N-1,testrandom(R,N1).
				
/*Tour de l'ordinateur*/

afficheboard(_):-setof(A,cote(A),K),nth0(0,K,C),test(C).

generateMove(_):-write('Au tour de l Ordi'),nl,listmove2(_),setof(X,moveposs2(X),R),tourordi(R),retractall(moveposs2([_,_,_,_])),!.
generateMove(_):-setof(X,khan(X),K),nth0(0,K,V),asserta(khanreel(V)),autremoves(_),!.

tourordi(R):-killKalista1(R),!.
tourordi(R):-killPion1Top(R),write('L ordinateur prend un pion'),nl,!.
tourordi(R):-avancerTop(R),write('L ordinateur avance un pion'),nl,!.
tourordi(R):-killPion1Bof(R),write('L ordinateur prend un pion'),nl,!.
tourordi(R):-avancerBof(R),write('L ordinateur avance un pion'),nl,!.
tourordi(R):-randommove(R),write('L ordinateur avance un pion'),nl,!.

autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),killKalista1(R),retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),killKalista1(R),retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),killKalista1(R),retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),killPion1Top(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),killPion1Top(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),killPion1Top(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-setof(X,khanreel(X),K),nth0(0,K,V),replaceKhan(V),ressuciterTop(_),write('L ordinateur ressucite un pion'),nl,!.
autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),avancerTop(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),avancerTop(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),avancerTop(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),killPion1Bof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),killPion1Bof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),killPion1Bof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-setof(X,khanreel(X),K),nth0(0,K,V),replaceKhan(V),ressuciter(_),write('L ordinateur ressucite un pion'),nl,!.
autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),avancerBof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),avancerBof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),avancerBof(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(1),listmove2(_),setof(X,moveposs2(X),R),randommove(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(2),listmove2(_),setof(X,moveposs2(X),R),randommove(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
autremoves(_):-replaceKhan(3),listmove2(_),setof(X,moveposs2(X),R),randommove(R),write('L ordinateur avance un pion'),nl,retractall(moveposs2([_,_,_,_])),!.
				
/* génération de coordonée aléatoires pour le placement de piece de J2 */
	
randomcoord(_):-retractall(randcoord([_,_])),randset(1,6,X),randset(1,2,Y),nth0(0,X,X1),nth0(0,Y,Y1),Y2 is 7-Y1,asserta(randcoord([X1,Y2])).


placement_ordi(0,X):-choix_coordkordi(_),afficher_plat(X).
placement_ordi(N,X):-N>0,afficher_plat(X),choix_coordordi(_),N1 is N-1,placement_ordi(N1,X).

choix_coordordi(_):-randset(1,6,X),randset(1,2,Y),nth0(0,X,A),nth0(0,Y,Y1),B is 7-Y1,test_insertordi(A,B,_).

test_insertordi(_,B,Y):-B<5,choix_coordordi(_),!.
test_insertordi(A,B,Y):-B>4,occupe(A,B),choix_coordordi(_).
test_insertordi(A,B,Y):-B>4,libre(A,B),retract(pions2(0,0)),asserta(pions2(A,B)),Y=[A,B],asserta(listepos2(Y)),write('pieceordi placée'),nl,!.

choix_coordkordi(_):-randset(1,6,X),randset(1,2,Y),nth0(0,X,A),nth0(0,Y,Y1),B is 7-Y1,test_insertkordi(A,B,_).
test_insertkordi(_,B,Y):-B<5,choix_coordkordi(_),!.
test_insertkordi(A,B,Y):-B>4,occupe(A,B),choix_coordkordi(_).
test_insertkordi(A,B,Y):-B>4,libre(A,B),retract(kalista2(0,0)),asserta(kalista2(A,B)),Y=[A,B],asserta(listepos2(Y)),asserta(poskalista2(Y)),write('kalistaordi placée'),nl,!.

/*premier tour de la partie*/

round1(A,C):-write('A vous de jouer! choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			assoc(A,C,X,Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),listmove1(_),
			  A=[X,Y,NX,NY],moveposs1(A),testp_k1(X,Y,NX,NY,C),!.
round1(A,C):-write('erreur! votre mouvement n''est pas possible! veuillez recommencer!'),round1(A,C).

/*associe khan à la case*/

assoc(A,C,X,Y):-val_case(X,Y,C),val(1),replaceKhan(1).
assoc(A,C,X,Y):-val_case(X,Y,C),val(2),replaceKhan(2).			  
assoc(A,C,X,Y):-val_case(X,Y,C),val(3),replaceKhan(3).		

/*prédicat qui gère ressuscite*/

rez1(1,C):-write('à quel position voulez vous ressuciter votre pion?'),read(X),read(Y),reskhan(X,Y,C),ressucite1(X,Y),!.
rez1(1,C):-write('vous ne pouvez pas ressuciter un pion sur cette case!'),rez1(1,C).
rez1(2,C):-write('choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),assoc(A,C,X,Y),listmove1(_),
			   A=[X,Y,NX,NY],moveposs1(A),testp_k1(X,Y,NX,NY,C),!.	
rez1(2):-write('erreur! votre mouvement n''est pas possible! veuillez recommencer!'),rez1(2,C).


rez2(1,C):-write('à quel position voulez vous ressuciter votre pion?'),read(X),read(Y),reskhan(X,Y,C),ressucite2(X,Y),!.
rez2(1,C):-write('vous ne pouvez pas ressuciter un pion sur cette case!'),rez2(1,C).
rez2(2,C):-write('choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),assoc(A,C,X,Y),listmove2(_),
			   A=[X,Y,NX,NY],moveposs2(A),testp_k2(X,Y,NX,NY,C),!.	
rez2(2,C):-write('erreur! votre mouvement n''est pas possible! veuillez recommencer!'),rez2(2,C).			   
			  
			  
/*gere un tour de joueur 1*/		  
			  			  
testmove1(A,C):-listmove1(_),setof(V,moveposs1(V),R),write('A vous de jouer! choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),
			  A=[X,Y,NX,NY],moveposs1(A),testp_k1(X,Y,NX,NY,C),!.
testmove1(A,C):-qressucite1(_),write('Pas compatible avec le Khan!'),write('voulez vous ressuciter un pion(1) ou jouer(2)?'),read(R),rez1(R,C),!.
testmove1(A,C):-write('Pas compatible avec le Khan! choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),assoc(A,C,X,Y),listmove1(_),
			   A=[X,Y,NX,NY],moveposs1(A),testp_k1(X,Y,NX,NY,C),!.
testmove1(A,C):-write('erreur1! votre mouvement n''est pas possible! veuillez recommencer!'),testmove1(A,C).

/* gere un tour de joueur2*/

testmove2(A,C):-write('A vous de jouer! choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),listmove2(_),
			  A=[X,Y,NX,NY],moveposs2(A),testp_k2(X,Y,NX,NY,C),!.
testmove2(A,C):-qressucite2(_),write('Pas compatible avec le Khan!'),write('voulez vous ressuciter un pion(1) ou jouer(2)?'),read(R),rez2(R,C),!.			  
testmove2(A,C):-write('Pas compatible avec le Khan! choisissez l''abscisse de la piece à bouger!'),read(X),write('choisissez l''ordonnee de la piece à bouger!'),read(Y),
			  write('choisissez l''abscisse où vous déplacez votre piece!'),read(NX),write('choisissez l''ordonnee où vous déplacez votre piece!'),read(NY),assoc(A,C,X,Y),listmove2(_),
			   A=[X,Y,NX,NY],moveposs2(A),testp_k2(X,Y,NX,NY,C),!.
testmove2(A,C):-write('erreur2! votre mouvement n''est pas possible! veuillez recommencer!'),testmove2(A,C).

/*consequences d'un mouvement*/

testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions1(X,Y),libre(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions1(X,Y),libre(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions1(X,Y),libre(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions1(X,Y),pions2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions1(X,Y),pions2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions1(X,Y),pions2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions1(X,Y),kalista2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions1(X,Y),kalista2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions1(X,Y),kalista2(NX,NY),retract(pions1(X,Y)),retract(listepos1([X,Y])),asserta(pions1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista1(X,Y),libre(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista1(X,Y),libre(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista1(X,Y),libre(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista1(X,Y),pions2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista1(X,Y),pions2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista1(X,Y),pions2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(pions2(NX,NY)),asserta(pions2(0,0)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista1(X,Y),kalista2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista1(X,Y),kalista2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).
testp_k1(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista1(X,Y),kalista2(NX,NY),retract(kalista1(X,Y)),retract(listepos1([X,Y])),asserta(kalista1(NX,NY)),Z=[NX,NY],asserta(listepos1(Z)),retract(kalista2(NX,NY)).

testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions2(X,Y),libre(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions2(X,Y),libre(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions2(X,Y),libre(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions2(X,Y),pions1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions2(X,Y),pions1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions2(X,Y),pions1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),pions2(X,Y),kalista1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),pions2(X,Y),kalista1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),pions2(X,Y),kalista1(NX,NY),retract(pions2(X,Y)),retract(listepos2([X,Y])),asserta(pions2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista2(X,Y),libre(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista2(X,Y),libre(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista2(X,Y),libre(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista2(X,Y),pions1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista2(X,Y),pions1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista2(X,Y),pions1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(pions1(NX,NY)),asserta(pions1(0,0)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(1),replaceKhan(1),kalista2(X,Y),kalista1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(2),replaceKhan(2),kalista2(X,Y),kalista1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).
testp_k2(X,Y,NX,NY,C):-val_case(NX,NY,C),val(3),replaceKhan(3),kalista2(X,Y),kalista1(NX,NY),retract(kalista2(X,Y)),retract(listepos2([X,Y])),asserta(kalista2(NX,NY)),Z=[NX,NY],asserta(listepos2(Z)),retract(kalista1(NX,NY)).

/*predicat principal*/

jeudeKhan(_):-write('Tapez (1) pour faire une partie à deux joueurs ou Tapez (2) pour faire une partie contre l ordinateur'),nl,
			write('Entre votre choix :  '),read(X),choixpartie(X).

choixpartie(X):-X==1,initJcJ(_),!.
choixpartie(X):-X==2,initJcO(_),!.
choixpartie(X):-write('Erreur'),!.

/*initialisation joueur contre joueur*/

initJcJ(_):-write('voulez vous commencer en haut(1), à gauche (2), à droite (3), en bas (4) ?'),
		read(C),asserta(cote(C)),
		placement_j1(5,C),placement_j2(5,C),round1(_,C),afficher_plat(C),roundsuivJcJ(_,C).
		
/*boucle joueur contre joueur*/			
		
roundsuivJcJ(_,C):-repeat,testmove2(_,C),(afficher_plat(C),victoireOcre(_);testmove1(_,C),afficher_plat(C),victoireRouge(_)).	

/*initialisation joueur contre IA*/

initJcO(_):-write('voulez vous commencer en haut(1), à gauche (2), à droite (3), en bas (4) ?'),
		read(C),asserta(cote(C)),
		placement_j1(5,C),placement_ordi(5,C),round1(_,C),afficher_plat(C),roundsuivJcO(_,C).
		
/*boucle joueur contre IA*/		
		
roundsuivJcO(_,C):-repeat,generateMove(_),(afficher_plat(C),victoireOcre(_);testmove1(_,C),afficher_plat(C),victoireRouge(_)).

