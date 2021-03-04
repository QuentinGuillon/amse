# amse

TP1:

J'ai créé pour le TP1 une application de gestion de musiques avec 3 pages : la page "Home" avec toute les musiques, la page "Playlists" avec différentes playlistes, et la page "Liked" avec les musiques likées.

J'ai également mis l'option "ajouter une musique" avec le bouton "+" en haut à droite. On peut insérer le titre de la musique dans le champ prévu à cet effet, et cette dernière s'ajoute à l'appui sur la touche "entrer". La phrase "Song added !" est censée apparaitre à se moment là mais ça ne fonctionne pas..

Dans l'onglet "Playlists", les différentes playlistes (3 en l'occurence) possèdent des petites vignettes.

Pour le moment l'onglet "Playlist" n'est pas intéractif, les playlists sont celles rentrées dans le code. Je prévoit de développer une fonctionnalité avec laquelle, en appuyant sur le "+", on puisse chooisir si on veut ajouter une musique ou une playliste. De plus, je vais essayer de développer une autre fonctionnalité permettant d'ajouter les musiques aux différentes playlistes, et d'accéder au contenu des playlistes en cliquant sur la ligne correspondante.


TP2:

Le taquin final réalisé pour le TP2 comprend une BottomNavigationBar avec plusieurs boutons. La premier permet de changer l'image à jouer, le deuxième sert à réduire la taille de la grille de jeu, le troisième à agrandir cette grille, et enfin le quatrième sert à annuler le dernier coup joué, puis l'avant-dernier si on reclique dessus, et ainsi de suite.
Le bouton play permet de démarrer le jeu, c'est à dire de mélanger les tiles en effectuant des mouvements aléatoires (des mouvements réels).

Lorsque le joueur gagne la partie, la tile blanche révèle la vraie clipRect qu'elle remplacait. Le joueur peut ainsi contempler l'image dans son intégralité.

Le joueur peut alors soit changer d'image, soit de taille , soit recliquer sur le bouton play pour relancer une partie dans les mêmes conditions.
