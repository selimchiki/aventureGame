#
# Programmeur : Sélim Chiki
# Jeu d'aventure aléatoire en mode texte.
#

def creer_piece
  "Vous êtes dans une #{taille} #{type_piece} #{couleur}. Il y a une sortie dans le mur #{direction}."
end

def taille
  ["immense", "grande", "longue", "large", "petite", "minuscule"].sample
end

def type_piece
  ["cave", "chambre", "caverne", "tombe", "salle", "cabane"].sample
end

def couleur
  ["rouge", "bleue", "verte", "sombre", "blanche", "noire"].sample
end

def direction
  ["nord", "sud", "est", "ouest"].sample
end

def est_monstre?
  if lance_des(2, 6) >= 8
    true
  else
    false
  end
end

def lance_des(nb_des, nb_faces)
  total = 0
  1.upto(nb_des) do
    total = total + rand(nb_faces) + 1
  end
  return total
end

def est_echappe?
  if lance_des(2,6) >= 11
    true
  else
    false
  end
end

def monstre_attaque?
  if lance_des(2, 6) >= 9
    true
  else
    false
  end
end

def monstre_battu?
  if lance_des(2, 6) >= 4
    true
  else
    false
  end
end

def est_tresor?
  if lance_des(2, 6) >= 8
    true
  else
    false
  end
end

def tresor
  ["des pièces d'or", "des rubis", "une baguette magique", "une épée enchantée"].sample
end

nb_pieces_explorees = 1
nb_tresors = 0
points_vie = 5
echappe = false
monstre = false
piece_courante = creer_piece

puts "Vous êtes enfermé dans un donjon. Collectez les trésors et essayer de vous échapper"
puts "avant qu'un monstre diabolique ne vous attrape !"
puts "Pour jouer, taper un des choix possibles à chaque tour."
puts ""

while points_vie > 0 and not echappe do
  actions = ["d - se déplacer", "r - rechercher"]
  puts "Pièce numéro #{nb_pieces_explorees}"
  puts piece_courante
  if monstre
    puts "OH NON ! Il y a un terrible monstre dans la pièce !"
    actions << "c - combattre"
  end
  print "Que voulez-vous faire ? (#{actions.join(', ')}): "
  joueur_action = gets.chomp
  if monstre and monstre_attaque?
    points_vie = points_vie - 1
    puts "OUCH, le monstre vous a touché !"
  end
  if joueur_action == "d"
    piece_courante = creer_piece
    nb_pieces_explorees = nb_pieces_explorees + 1
    monstre = est_monstre?
    echappe = est_echappe?
  elsif joueur_action == "r"
    if est_tresor?
      puts "Vous avez trouvé #{tresor}!"
      nb_tresors = nb_tresors + 1
    else
      puts "Désolé, mais il n'y a rien à trouver ici."
    end
    # En cherchant un trésor,
    # Vous pourriez bien attirer un autre monstre !
    if not monstre
      monstre = est_monstre?
    end
  elsif joueur_action == "c"
    if monstre_battu?
      monstre = false
      puts "Vous avez vaincu le terrible monstre!"
    else
      puts "Vous avez bien combattu, mais vous l'avez manqué !!!"
    end
  else
    puts "Je ne comprends pas ce que vous voulez faire ! "
  end
  puts ""
end

if points_vie > 0
  puts "Vous vous êtes échappé !"
  puts "Vous avez exploré #{nb_pieces_explorees} pièces"
  puts "et trouvé #{nb_tresors} trésors."
else
  puts "OH NON ! Vous avez perdu !"
  puts "Vous avez exploré #{nb_pieces_explorees} pièces"
  puts "avant de périr."
end
