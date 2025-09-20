--[[
    GUIの作成から機能まで、すべてをこのスクリリプト1つで行います。
    クレジット表記を追加しました。
]]

-- プレイヤーとカメラの情報を取得
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- GUI要素の作成
-- 1. ScreenGui: GUIの土台
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FovChangerGui"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false -- リスポーンしてもGUIが消えないようにする

-- 2. Frame: GUIの背景フレーム
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 背景色: 白
mainFrame.BorderColor3 = Color3.fromRGB(0, 180, 80) -- 枠線の色: 緑
mainFrame.BorderSizePixel = 3
mainFrame.AnchorPoint = Vector2.new(1, 0) -- 位置の基準を右上に設定
mainFrame.Position = UDim2.new(1, -15, 0, 15) -- 画面の右上から少し内側に配置
mainFrame.Size = UDim2.new(0, 200, 0, 130) -- 高さを少し広げてクレジットのスペースを確保

-- 3. TextBox: 視野角を入力するボックス
local fovInput = Instance.new("TextBox")
fovInput.Name = "FovInput"
fovInput.Parent = mainFrame
fovInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
fovInput.BorderColor3 = Color3.fromRGB(200, 200, 200)
fovInput.Position = UDim2.new(0.5, 0, 0.3, 0)
fovInput.AnchorPoint = Vector2.new(0.5, 0.5) -- 中央を基準に配置
fovInput.Size = UDim2.new(0.8, 0, 0.25, 0)
fovInput.Font = Enum.Font.SourceSans
fovInput.Text = tostring(math.floor(camera.FieldOfView)) -- 現在の視野角を表示
fovInput.PlaceholderText = "視野角 (1-120)"
fovInput.TextScaled = true
fovInput.ClearTextOnFocus = false -- 入力時にテキストを消さない

-- 4. TextButton: 確定ボタン
local confirmButton = Instance.new("TextButton")
confirmButton.Name = "ConfirmButton"
confirmButton.Parent = mainFrame
confirmButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- ボタンの色: 青
confirmButton.BorderColor3 = Color3.fromRGB(0, 80, 180)
confirmButton.BorderSizePixel = 2
confirmButton.Position = UDim2.new(0.5, 0, 0.65, 0) -- 少し上に配置
confirmButton.AnchorPoint = Vector2.new(0.5, 0.5) -- 中央を基準に配置
confirmButton.Size = UDim2.new(0.8, 0, 0.3, 0)
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.Text = "確定"
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- テキストの色: 白
confirmButton.TextScaled = true

-- 5. Label: タイトルラベル
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0.5, 0, 0, 0)
titleLabel.AnchorPoint = Vector2.new(0.5, 0)
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "視野角チェンジャー"
titleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)

-- 6. Label: クレジット表記 (ここを追加)
local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Parent = mainFrame
creditLabel.BackgroundTransparency = 1 -- 背景を透明に
creditLabel.Position = UDim2.new(0.5, 0, 0.9, 0) -- 確定ボタンの下に配置
creditLabel.AnchorPoint = Vector2.new(0.5, 0.5)
creditLabel.Size = UDim2.new(1, 0, 0.15, 0)
creditLabel.Font = Enum.Font.SourceSans
creditLabel.Text = "by tonakari814"
creditLabel.TextColor3 = Color3.fromRGB(180, 180, 180) -- 文字の色を薄いグレーに
creditLabel.TextSize = 12 -- 文字のサイズを固定


-- ボタンがクリックされたときの処理
confirmButton.MouseButton1Click:Connect(function()
	-- 入力されたテキストを数値に変換
	local fovValue = tonumber(fovInput.Text)

	-- 数値であり、nilでないことを確認
	if fovValue then
		-- 視野角を1から120の間に制限する
		fovValue = math.clamp(fovValue, 1, 120)
		
		-- カメラの視野角を変更
		camera.FieldOfView = fovValue
		
		-- 入力ボックスのテキストを制限後の値に更新
		fovInput.Text = tostring(math.floor(fovValue))
	else
		-- 無効な入力だった場合、現在の視野角を再表示
		fovInput.Text = tostring(math.floor(camera.FieldOfView))
	end
end)
