-- Nom du fichier : autoCraft.lua

-- Périphérique : ME Bridge d’Advanced Peripherals
local me = peripheral.find("meBridge")

if not me then
  error("Aucun meBridge trouvé ! Vérifie la connexion.")
end

-- Nom de l'item à surveiller (namespace:nom_item)
local itemToCheck = "minecraft:iron_ingot"  -- Exemple
-- Nom de l'item à autocrafter
local itemToCraft = "minecraft:iron_block"  -- Exemple
-- Quantité à vérifier
local threshold = 8
-- Quantité à crafter automatiquement
local craftAmount = 1

while true do
  -- Récupérer la quantité de l’item dans le ME
  local item = me.getItem({name=itemToCheck})
  local count = 0
  if item then
    count = item.amount
  end

  print("Quantité actuelle de "..itemToCheck..": "..count)

  -- Vérifier si on a assez pour crafter
  if count >= threshold then
    print("Lancement de l'autocraft de "..itemToCraft.." x"..craftAmount)
    local success = me.craftItem({
      name=itemToCraft,
      count=craftAmount
    })
    if success then
      print("Autocraft lancé avec succès !")
    else
      print("⚠ Impossible de lancer l'autocraft ! Vérifie les patterns et la config AE2.")
    end
  else
    print("Pas assez de "..itemToCheck.." pour lancer le craft.")
  end

  -- Pause entre deux vérifications (éviter de spam le ME)
  sleep(10)
end
