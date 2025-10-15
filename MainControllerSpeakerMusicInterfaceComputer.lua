-- Fichier : control_master_gui (V3)
-- Rôle : Diffuse des commandes et affiche l'état sur un Advanced Monitor.

-- 1. Configuration des côtés (IMPORTANT : À VÉRIFIER)
local modem_side = "right"  -- Côté du Modem Sans Fil
local monitor_side = "top"  -- Côté de l'Advanced Monitor (souvent 'top' ou 'back')

-- 2. Initialisation des périphériques
print("Initialisation du Maître Contrôleur...")

-- Vérification du Modem
if not peripheral.isPresent(modem_side) or peripheral.getType(modem_side) ~= "modem" then
    print("Erreur: Modem sans fil non trouvé sur le côté " .. modem_side)
    os.sleep(5)
    return
end

-- Vérification du Moniteur
if not peripheral.isPresent(monitor_side) then
    print("Erreur: Advanced Monitor non trouvé sur le côté " .. monitor_side)
    os.sleep(5)
    return
end

local monitor = peripheral.wrap(monitor_side)
rednet.open(modem_side)

-- 3. Définir la liste des IDs Clients
-- REMPLACEZ AVEC VOS VRAIS IDs !
local client_ids = {
    101, -- ID du Client 1
    102, -- ID du Client 2
    103  -- ID du Client 3
}

-- 4. Fonctions d'Affichage du Moniteur

-- Fonction pour nettoyer et mettre à jour l'affichage
function update_monitor(title_text, status_text)
    local width, height = monitor.getSize()
    
    monitor.setTextScale(1) -- Réinitialiser la taille du texte
    monitor.clear()
    
    -- Afficher le Titre
    monitor.setCursorPos(2, 2)
    monitor.setBackgroundColor(colors.blue)
    monitor.write(string.rep(" ", width - 2)) -- Ligne bleue
    monitor.setCursorPos(2, 2)
    monitor.setBackgroundColor(colors.blue)
    monitor.setTextColor(colors.white)
    monitor.write(" AUDIO MAÎTRE SANS FIL (Clients: " .. #client_ids .. ") ")
    
    -- Afficher le Statut
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 4)
    monitor.write(title_text)
    
    -- Afficher le Son en cours de lecture
    monitor.setTextColor(colors.lime) -- Couleur verte flashy
    monitor.setCursorPos(2, 5)
    monitor.write(status_text)
end

-- 5. Fonction pour diffuser le son à tous les clients
function broadcast_sound(sound_command)
    print(">>> Diffusion de la commande : " .. sound_command)
    update_monitor("Statut : Diffusion en cours...", "Son: " .. sound_command)
    
    local sent_count = 0
    for _, id in ipairs(client_ids) do
        rednet.send(id, sound_command)
        sent_count = sent_count + 1
    end
    print("Transmis à " .. sent_count .. " haut-parleurs.")
end

-- 6. Séquence de démonstration
update_monitor("Statut : Démarrage de la séquence...", "Prêt à envoyer le premier son.")
os.sleep(2)

-- Exemple 1: Un 'pling'
broadcast_sound("minecraft:block.note_block.pling")
os.sleep(1.5) -- Attendre un peu plus pour laisser le temps au son de jouer

-- Exemple 2: Son d'une flèche
broadcast_sound("minecraft:entity.arrow.shoot")
os.sleep(1)

-- Exemple 3: Son de harpe
broadcast_sound("minecraft:block.note_block.harp")
os.sleep(2)

-- Fin
update_monitor("Statut : Séquence terminée.", "En attente d'une nouvelle commande (pour un programme plus long).")
print("Séquence de démonstration terminée.")
-- Optionnel : Fermer la connexion rednet si le programme se termine
-- rednet.close(modem_side)
