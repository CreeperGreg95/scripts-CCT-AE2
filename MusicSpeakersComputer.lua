-- Fichier : speaker_client (CORRIGÉ)

-- 1. Configuration des côtés (à ajuster si nécessaire !)
-- MODEM : Choisissez "right" (droit) ou "left" (gauche) selon votre installation
local modem_side = "right" 
-- HAUT-PARLEUR : Votre haut-parleur est à l'avant
local speaker_side = "front" 

-- 2. Initialisation des périphériques
print("Initialisation du Client Haut-Parleur...")

-- Vérification du Modem
if not peripheral.isPresent(modem_side) or peripheral.getType(modem_side) ~= "modem" then
    print("Erreur: Modem sans fil non trouvé sur le côté " .. modem_side)
    os.sleep(5)
    return
end

-- Vérification du Haut-parleur
if not peripheral.isPresent(speaker_side) or peripheral.getType(speaker_side) ~= "speaker" then
    print("Erreur: Haut-parleur non trouvé sur le côté " .. speaker_side)
    os.sleep(5)
    return
end

local speaker = peripheral.wrap(speaker_side)

-- 3. Initialiser Rednet
rednet.open(modem_side)
local my_id = os.getComputerID() -- <<< LIGNE CORRIGÉE : Utilisation de os.getComputerID()
print("---------------------------------------")
print("Client PRÊT. ID Rednet : " .. my_id)
print("NOTEZ CET ID pour le programme Maître!")
print("---------------------------------------")

-- 4. Boucle de Réception des Messages
while true do
    -- Le message vient de n'importe quel ID (rednet.receive())
    local id_from, message = rednet.receive()
    
    if message and type(message) == "string" then
        print("Reçu de " .. id_from .. " : " .. message)
        
        -- Le message est l'instruction du son à jouer
        local sound_name = message
        
        -- Lecture du son (utiliser playSound qui est plus adapté pour des événements courts)
        local success, error_message = speaker.playSound(sound_name)
        
        if success then
            print("Son joué : " .. sound_name)
        else
            print("Erreur de lecture du son : " .. error_message)
        end
    end
end
