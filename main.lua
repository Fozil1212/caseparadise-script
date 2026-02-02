-- LocalScript wewnątrz ScreenGui
local player = game.Players.LocalPlayer
local screenGui = script.Parent

-- === GLOWNA RAMKA GUI ===
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainGuiFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 450) -- Zwiększamy rozmiar
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -225) -- Centrowanie
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true -- Włącza przeciąganie ramki
mainFrame.Parent = screenGui

-- UICorner dla zaokrąglonych rogów głównej ramki
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 12)
mainFrameCorner.Parent = mainFrame

-- === TOP BAR (nagłówek i napis "by Fozil") ===
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
titleLabel.Position = UDim2.new(0.02, 0, 0, 0)
titleLabel.Text = "Game Automation Panel"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local fozilLabel = Instance.new("TextLabel")
fozilLabel.Name = "FozilLabel"
fozilLabel.Size = UDim2.new(0.3, 0, 1, 0)
fozilLabel.Position = UDim2.new(0.68, 0, 0, 0)
fozilLabel.Text = "by Fozil"
fozilLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
fozilLabel.Font = Enum.Font.SourceSansLight
fozilLabel.TextSize = 16
fozilLabel.BackgroundTransparency = 1
fozilLabel.TextXAlignment = Enum.TextXAlignment.Right
fozilLabel.Parent = topBar

-- === MENU BOCZNE ===
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 180, 1, -35) -- Szerokość i wysokość pomniejszona o TopBar
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 8)
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Top
sidebarLayout.Parent = sidebar

-- Funkcja do tworzenia przycisków menu bocznego
local function createSidebarButton(name, iconId)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Button"
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Text = "" -- Tekst będzie w labelu, żeby zrobić miejsce na ikonę
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0.08, 0, 0.5, -12)
    icon.Image = "rbxassetid://" .. iconId -- ID Ikony
    icon.BackgroundTransparency = 1
    icon.Parent = btn

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(0.7, 0, 1, 0)
    text.Position = UDim2.new(0.25, 0, 0, 0)
    text.Text = name
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Font = Enum.Font.SourceSansSemibold
    text.TextSize = 16
    text.BackgroundTransparency = 1
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Parent = btn

    return btn, icon, text
end

-- Przyciski menu
local autoQuestBtn, autoQuestIcon, autoQuestText = createSidebarButton("Auto Quest", "6034176250") -- Przykładowa ikona kuli ziemskiej
local autoOpeningBtn, autoOpeningIcon, autoOpeningText = createSidebarButton("Auto Opening", "6034169543") -- Przykładowa ikona skrzynki
-- Dodaj więcej przycisków jeśli potrzebujesz, np. Inventory, Win/Lose & Spy, Manual Control, Settings

-- === GLOWNA SEKCJA KONTENTU ===
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -180, 1, -35) -- Reszta przestrzeni
contentFrame.Position = UDim2.new(0, 180, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- UICorner dla zaokrąglonych rogów prawej sekcji (tylko prawy górny i dolny róg)
local contentFrameCorner = Instance.new("UICorner")
contentFrameCorner.CornerRadius = UDim.new(0, 12)
contentFrameCorner.Parent = contentFrame

-- === SEKCJE KONTENTU (ukryte/pokazywane) ===
local currentSection = nil

local function createSectionFrame(name)
    local section = Instance.new("Frame")
    section.Name = name
    section.Size = UDim2.new(1, 0, 1, 0)
    section.Position = UDim2.new(0, 0, 0, 0)
    section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    section.BorderSizePixel = 0
    section.Visible = false -- Domyślnie ukryte
    section.Parent = contentFrame
    return section
end

local autoQuestSection = createSectionFrame("AutoQuestSection")
local autoOpeningSection = createSectionFrame("AutoOpeningSection")

-- Funkcja do przełączania sekcji
local function showSection(sectionToShow, buttonActivated)
    if currentSection then
        currentSection.Visible = false
        -- Zresetuj kolor poprzedniego przycisku
        if currentSection == autoQuestSection then
            autoQuestBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        elseif currentSection == autoOpeningSection then
            autoOpeningBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end

    sectionToShow.Visible = true
    currentSection = sectionToShow
    
    -- Zmień kolor aktywnego przycisku
    if buttonActivated then
        buttonActivated.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end

-- === AUTO QUEST SECTION LOGIC ===
local autoQuestTitle = Instance.new("TextLabel")
autoQuestTitle.Size = UDim2.new(1, 0, 0, 30)
autoQuestTitle.Position = UDim2.new(0, 0, 0, 10)
autoQuestTitle.Text = "Auto Quest"
autoQuestTitle.TextColor3 = Color3.new(1, 1, 1)
autoQuestTitle.Font = Enum.Font.SourceSansBold
autoQuestTitle.TextSize = 24
autoQuestTitle.BackgroundTransparency = 1
autoQuestTitle.Parent = autoQuestSection

local autoQuestStatusLabel = Instance.new("TextLabel")
autoQuestStatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
autoQuestStatusLabel.Position = UDim2.new(0.1, 0, 0, 50)
autoQuestStatusLabel.Text = "Status: Idle"
autoQuestStatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
autoQuestStatusLabel.Font = Enum.Font.SourceSans
autoQuestStatusLabel.TextSize = 16
autoQuestStatusLabel.BackgroundTransparency = 1
autoQuestStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
autoQuestStatusLabel.Parent = autoQuestSection

local autoQuestToggleButton = Instance.new("TextButton")
autoQuestToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
autoQuestToggleButton.Position = UDim2.new(0.1, 0, 0, 90)
autoQuestToggleButton.Text = "START AUTO QUEST"
autoQuestToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
autoQuestToggleButton.TextColor3 = Color3.new(1, 1, 1)
autoQuestToggleButton.Font = Enum.Font.SourceSansBold
autoQuestToggleButton.TextSize = 18
autoQuestToggleButton.BorderSizePixel = 0
autoQuestToggleButton.Parent = autoQuestSection

local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(0, 8)
toggleButtonCorner.Parent = autoQuestToggleButton

local autoQuestActive = false
local autoQuestLoop = nil

local function updateQuestStatus(text, color)
    autoQuestStatusLabel.Text = "Status: " .. text
    autoQuestStatusLabel.TextColor3 = color or Color3.fromRGB(150, 150, 150)
end

-- PRZYKŁADOWE FUNKCJE DLA QUESTÓW (dostosuj do swojej gry!)
local function openCasesForQuest(amount)
    updateQuestStatus("Otwieranie " .. amount .. " skrzynek...", Color3.fromRGB(255, 170, 0))
    for i = 1, amount do
        if not autoQuestActive then break end
        -- Zastąp to Twoim RemoteEventem do otwierania skrzynek
        -- game.ReplicatedStorage.Events.OpenCase:FireServer("StarterCase")
        print("Symulacja: Otwarto skrzynkę " .. i .. "/" .. amount)
        task.wait(0.5)
    end
end

local function joinBattleForQuest()
    updateQuestStatus("Dołączanie do bitwy...", Color3.fromRGB(0, 170, 255))
    -- Zastąp to Twoim RemoteEventem do dołączania do bitwy
    -- game.ReplicatedStorage.Events.JoinBattle:FireServer()
    print("Symulacja: Dołączono do bitwy.")
    task.wait(5) -- Czas na rozegranie bitwy
end

local function claimQuestReward()
    -- Zastąp to Twoim RemoteEventem do odbierania nagród
    -- game.ReplicatedStorage.Events.ClaimReward:FireServer()
    print("Symulacja: Odebrano nagrodę za quest!")
end


local function startAutoQuestLoop()
    while autoQuestActive do
        -- TUTAJ ZINTEGRUJ Z TWOIM SYSTEMEM QUESTÓW
        -- Poniżej jest tylko PRZYKŁAD, jak to może działać
        local currentQuestName = "Open45Cases" -- game.Players.LocalPlayer.PlayerGui.QuestBoard.CurrentQuest.Name -- PRZYKŁAD!
        local questProgress = 0 -- game.Players.LocalPlayer.PlayerGui.QuestBoard.CurrentQuest.Progress.Value -- PRZYKŁAD!
        local questTarget = 45 -- game.Players.LocalPlayer.PlayerGui.QuestBoard.CurrentQuest.Target.Value -- PRZYKŁAD!


        if currentQuestName == "Open45Cases" then
            if questProgress < questTarget then
                openCasesForQuest(questTarget - questProgress) -- Otwórz tyle, ile brakuje
            else
                claimQuestReward()
                updateQuestStatus("Quest ukończony, nagroda odebrana!", Color3.fromRGB(0, 255, 0))
            end
        elseif currentQuestName == "PlayBattles" then
             if questProgress < questTarget then
                joinBattleForQuest()
             else
                claimQuestReward()
                updateQuestStatus("Quest ukończony, nagroda odebrana!", Color3.fromRGB(0, 255, 0))
            end
        end

        task.wait(3) -- Sprawdzaj co 3 sekundy
        updateQuestStatus("Czekam na następny quest...", Color3.fromRGB(150, 150, 150))
    end
end

autoQuestToggleButton.MouseButton1Click:Connect(function()
    autoQuestActive = not autoQuestActive
    if autoQuestActive then
        autoQuestToggleButton.Text = "STOP AUTO QUEST"
        autoQuestToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        updateQuestStatus("Uruchomiono...", Color3.fromRGB(0, 170, 0))
        autoQuestLoop = task.spawn(startAutoQuestLoop)
    else
        autoQuestToggleButton.Text = "START AUTO QUEST"
        autoQuestToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        updateQuestStatus("Zatrzymano.", Color3.fromRGB(255, 0, 0))
        if autoQuestLoop then
            task.cancel(autoQuestLoop)
            autoQuestLoop = nil
        end
    end
end)

-- === AUTO OPENING SECTION LOGIC ===
local autoOpeningTitle = Instance.new("TextLabel")
autoOpeningTitle.Size = UDim2.new(1, 0, 0, 30)
autoOpeningTitle.Position = UDim2.new(0, 0, 0, 10)
autoOpeningTitle.Text = "Auto Opening"
autoOpeningTitle.TextColor3 = Color3.new(1, 1, 1)
autoOpeningTitle.Font = Enum.Font.SourceSansBold
autoOpeningTitle.TextSize = 24
autoOpeningTitle.BackgroundTransparency = 1
autoOpeningTitle.Parent = autoOpeningSection

local autoOpeningStatus = Instance.new("TextLabel")
autoOpeningStatus.Size = UDim2.new(0.8, 0, 0, 20)
autoOpeningStatus.Position = UDim2.new(0.1, 0, 0, 50)
autoOpeningStatus.Text = "Status: Level Rewards Disabled"
autoOpeningStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
autoOpeningStatus.Font = Enum.Font.SourceSans
autoOpeningStatus.TextSize = 16
autoOpeningStatus.BackgroundTransparency = 1
autoOpeningStatus.TextXAlignment = Enum.TextXAlignment.Left
autoOpeningStatus.Parent = autoOpeningSection

-- Wybór skrzynki (Dropdown - ułatwiony)
local selectCaseLabel = Instance.new("TextLabel")
selectCaseLabel.Size = UDim2.new(0.3, 0, 0, 20)
selectCaseLabel.Position = UDim2.new(0.1, 0, 0, 80)
selectCaseLabel.Text = "Select Case:"
selectCaseLabel.TextColor3 = Color3.new(1, 1, 1)
selectCaseLabel.Font = Enum.Font.SourceSans
selectCaseLabel.TextSize = 16
selectCaseLabel.BackgroundTransparency = 1
selectCaseLabel.TextXAlignment = Enum.TextXAlignment.Left
selectCaseLabel.Parent = autoOpeningSection

local caseDropdown = Instance.new("TextButton") -- Symulacja dropdown
caseDropdown.Size = UDim2.new(0.4, 0, 0, 25)
caseDropdown.Position = UDim2.new(0.4, 0, 0, 80)
caseDropdown.Text = "LEVEL10" -- Domyślny wybór
caseDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
caseDropdown.TextColor3 = Color3.new(1, 1, 1)
caseDropdown.Font = Enum.Font.SourceSans
caseDropdown.TextSize = 16
caseDropdown.BorderSizePixel = 0
caseDropdown.Parent = autoOpeningSection

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 6)
dropdownCorner.Parent = caseDropdown

local caseOptions = {"LEVEL10", "STARTER_CASE", "EPIC_CASE"} -- Dostępne skrzynki
local currentCaseIndex = 1

caseDropdown.MouseButton1Click:Connect(function()
    currentCaseIndex = currentCaseIndex % #caseOptions + 1
    caseDropdown.Text = caseOptions[currentCaseIndex]
end)


-- Slider "Amount at once (Spam)"
local amountLabel = Instance.new("TextLabel")
amountLabel.Size = UDim2.new(0.5, 0, 0, 20)
amountLabel.Position = UDim2.new(0.1, 0, 0, 120)
amountLabel.Text = "Amount at once (Spam): 1"
amountLabel.TextColor3 = Color3.new(1, 1, 1)
amountLabel.Font = Enum.Font.SourceSans
amountLabel.TextSize = 16
amountLabel.BackgroundTransparency = 1
amountLabel.TextXAlignment = Enum.TextXAlignment.Left
amountLabel.Parent = autoOpeningSection

local amountSlider = Instance.new("Slider") -- Niestety Roblox nie ma wbudowanego Slidera GUI.
-- Musielibyśmy zbudować go od zera, co jest bardziej złożone.
-- Na potrzeby demonstracji, użyjemy TextButton do zwiększania/zmniejszania wartości.
local currentAmount = 1
local maxAmount = 10

local amountIncreaseBtn = Instance.new("TextButton")
amountIncreaseBtn.Size = UDim2.new(0, 30, 0, 25)
amountIncreaseBtn.Position = UDim2.new(0.7, 0, 0, 120)
amountIncreaseBtn.Text = "+"
amountIncreaseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
amountIncreaseBtn.TextColor3 = Color3.new(1, 1, 1)
amountIncreaseBtn.Font = Enum.Font.SourceSansBold
amountIncreaseBtn.TextSize = 18
amountIncreaseBtn.BorderSizePixel = 0
amountIncreaseBtn.Parent = autoOpeningSection

local amountDecreaseBtn = Instance.new("TextButton")
amountDecreaseBtn.Size = UDim2.new(0, 30, 0, 25)
amountDecreaseBtn.Position = UDim2.new(0.6, 0, 0, 120)
amountDecreaseBtn.Text = "-"
amountDecreaseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
amountDecreaseBtn.TextColor3 = Color3.new(1, 1, 1)
amountDecreaseBtn.Font = Enum.Font.SourceSansBold
amountDecreaseBtn.TextSize = 18
amountDecreaseBtn.BorderSizePixel = 0
amountDecreaseBtn.Parent = autoOpeningSection

amountIncreaseBtn.MouseButton1Click:Connect(function()
    currentAmount = math.min(currentAmount + 1, maxAmount)
    amountLabel.Text = "Amount at once (Spam): " .. currentAmount
end)

amountDecreaseBtn.MouseButton1Click:Connect(function()
    currentAmount = math.max(currentAmount - 1, 1)
    amountLabel.Text = "Amount at once (Spam): " .. currentAmount
end)


-- Wild Mode (Boost) - ToggleButton
local wildModeLabel = Instance.new("TextLabel")
wildModeLabel.Size = UDim2.new(0.5, 0, 0, 20)
wildModeLabel.Position = UDim2.new(0.1, 0, 0, 160)
wildModeLabel.Text = "Wild Mode (Boost)"
wildModeLabel.TextColor3 = Color3.new(1, 1, 1)
wildModeLabel.Font = Enum.Font.SourceSans
wildModeLabel.TextSize = 16
wildModeLabel.BackgroundTransparency = 1
wildModeLabel.TextXAlignment = Enum.TextXAlignment.Left
wildModeLabel.Parent = autoOpeningSection

local wildModeToggle = Instance.new("TextButton")
wildModeToggle.Size = UDim2.new(0, 50, 0, 25)
wildModeToggle.Position = UDim2.new(0.65, 0, 0, 160)
wildModeToggle.Text = "OFF"
wildModeToggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
wildModeToggle.TextColor3 = Color3.new(1, 1, 1)
wildModeToggle.Font = Enum.Font.SourceSansBold
wildModeToggle.TextSize = 16
wildModeToggle.BorderSizePixel = 0
wildModeToggle.Parent = autoOpeningSection

local wildModeCorner = Instance.new("UICorner")
wildModeCorner.CornerRadius = UDim.new(0, 6)
wildModeCorner.Parent = wildModeToggle

local wildModeEnabled = false
wildModeToggle.MouseButton1Click:Connect(function()
    wildModeEnabled = not wildModeEnabled
    if wildModeEnabled then
        wildModeToggle.Text = "ON"
        wildModeToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        wildModeToggle.Text = "OFF"
        wildModeToggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)


-- START AUTO OPEN button
local startAutoOpenButton = Instance.new("TextButton")
startAutoOpenButton.Size = UDim2.new(0.8, 0, 0, 40)
startAutoOpenButton.Position = UDim2.new(0.1, 0, 0, 200)
startAutoOpenButton.Text = "START AUTO OPEN"
startAutoOpenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
startAutoOpenButton.TextColor3 = Color3.new(1, 1, 1)
startAutoOpenButton.Font = Enum.Font.SourceSansBold
startAutoOpenButton.TextSize = 18
startAutoOpenButton.BorderSizePixel = 0
startAutoOpenButton.Parent = autoOpeningSection

local startAutoOpenCorner = Instance.new("UICorner")
startAutoOpenCorner.CornerRadius = UDim.new(0, 8)
startAutoOpenCorner.Parent = startAutoOpenButton

local autoOpenActive = false
local autoOpenLoop = nil

local function updateAutoOpeningStatus(text, color)
    autoOpeningStatus.Text = "Status: " .. text
    autoOpeningStatus.TextColor3 = color or Color3.fromRGB(150, 150, 150)
end

local function startAutoOpenLoop()
    while autoOpenActive do
        updateAutoOpeningStatus("Otwieram " .. currentAmount .. "x " .. caseDropdown.Text .. " (Boost: " .. tostring(wildModeEnabled) .. ")", Color3.fromRGB(255, 170, 0))
        for i = 1, currentAmount do
            if not autoOpenActive then break end
            -- Zastąp to Twoim RemoteEventem do otwierania skrzynek
            -- game.ReplicatedStorage.Events.OpenCase:FireServer(caseDropdown.Text)
            print("Symulacja: Otwarto " .. caseDropdown.Text .. " (" .. i .. "/" .. currentAmount .. ")")
            task.wait(0.2 / (wildModeEnabled and 2 or 1)) -- Szybciej w Wild Mode
        end
        task.wait(1) -- Krótka przerwa między "spamowaniem"
    end
end

startAutoOpenButton.MouseButton1Click:Connect(function()
    autoOpenActive = not autoOpenActive
    if autoOpenActive then
        startAutoOpenButton.Text = "STOP AUTO OPEN"
        startAutoOpenButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        updateAutoOpeningStatus("Uruchomiono Auto Opening...", Color3.fromRGB(0, 170, 0))
        autoOpenLoop = task.spawn(startAutoOpenLoop)
    else
        startAutoOpenButton.Text = "START AUTO OPEN"
        startAutoOpenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        updateAutoOpeningStatus("Zatrzymano Auto Opening.", Color3.fromRGB(255, 0, 0))
        if autoOpenLoop then
            task.cancel(autoOpenLoop)
            autoOpenLoop = nil
        end
    end
end)


-- Aktywuj domyślnie sekcję Auto Quest
showSection(autoQuestSection, autoQuestBtn)

-- Połączenie przycisków bocznych z sekcjami
autoQuestBtn.MouseButton1Click:Connect(function()
    showSection(autoQuestSection, autoQuestBtn)
end)

autoOpeningBtn.MouseButton1Click:Connect(function()
    showSection(autoOpeningSection, autoOpeningBtn)
end)
