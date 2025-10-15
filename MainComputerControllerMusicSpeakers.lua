-- Fichier : control_master (V2)
-- Rôle : Envoie des commandes audio aux ordinateurs clients via le modem sans fil.

-- 1. Configuration des côtés (uniquement le Modem)
-- Ajustez "right" ou "left" selon le côté où votre modem est installé sur l'ordinateur MAÎTRE
local modem_side = "right" 

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

-- 3. Définir la liste des IDs Clients (TRÈS IMPORTANT !)
-- REMPLACEZ 101, 102, 103 AVEC LES VRAIS IDs AFFICHÉS PAR VOS CLIENTS !
local client_ids = {
    101, -- ID du Client Haut-Parleur 1
    102, -- ID du Client Haut-Parleur 2
    103  -- ID du Client Haut-Parleur 3
}
print("Cibles : " .. #client_ids .. " clients à contacter.")

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
os.sleep(1)

-- Exemple 1: Un 'pling' (son de cloche)
broadcast_sound("minecraft:block.note_block.pling")
os.sleep(1) -- Attendre 1 seconde

-- Exemple 2: Son d'une explosion douce
broadcast_sound("minecraft:entity.generic.explode")
os.sleep(1)

-- Exemple 3: Son de harpe
broadcast_sound("minecraft:block.note_block.harp")
os.sleep(2)

-- Fin
print("Séquence de démonstration terminée.")
rednet.close(modem_side)
