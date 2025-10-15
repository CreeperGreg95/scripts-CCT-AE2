-- Fichier : control_master

-- 1. Configuration des côtés (uniquement le Modem)
local modem_side = "right" -- Assurez-vous que c'est le côté où votre modem est installé.

-- 2. Initialisation des périphériques
print("Initialisation du Maître Contrôleur...")

if not peripheral.isPresent(modem_side) or peripheral.getType(modem_side) ~= "modem" then
    print("Erreur: Modem sans fil non trouvé sur le côté " .. modem_side)
    os.sleep(5)
    return
end

rednet.open(modem_side)
print("---------------------------------------")
print("Maître PRÊT. Envoi de commandes en cours.")
print("---------------------------------------")

-- 3. Définir la liste des IDs Clients
-- TRÈS IMPORTANT : REMPLACEZ CES NUMÉROS AVEC LES VRAIS IDs AFFICHÉS PAR VOS CLIENTS
local client_ids = {
    101, -- Exemple ID pour le haut-parleur 1
    102, -- Exemple ID pour le haut-parleur 2
    103  -- Exemple ID pour le haut-parleur 3
}

-- 4. Fonction pour diffuser le son à tous les clients
function broadcast_sound(sound_command)
    print(">>> Diffusion de la commande : " .. sound_command)
    local sent_count = 0
    for _, id in ipairs(client_ids) do
        -- Envoyer le message (ID, message)
        rednet.send(id, sound_command)
        sent_count = sent_count + 1
    end
    print("Transmis à " .. sent_count .. " haut-parleurs.")
end

-- 5. Séquence de démonstration
print("Début de la séquence...")

-- Exemple 1: Un 'pling'
broadcast_sound("minecraft:block.note_block.pling")
os.sleep(1) -- Attendre 1 seconde

-- Exemple 2: Son d'une flèche
broadcast_sound("minecraft:entity.arrow.shoot")
os.sleep(1)

-- Exemple 3: Son de harpe
broadcast_sound("minecraft:block.note_block.harp")
os.sleep(2)

-- Fin
print("Séquence de démonstration terminée.")
rednet.close(modem_side)
