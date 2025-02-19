local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StoryView = require(ReplicatedStorage.Packages.StoryComponents.StoryView)
local StoryItem = require(ReplicatedStorage.Packages.StoryComponents.StoryItem)

local storyRoot = script.Parent
local ToastRoot = storyRoot.Parent
local DialogRoot = ToastRoot.Parent
local AppRoot = DialogRoot.Parent
local UIBloxRoot = AppRoot.Parent
local Packages = UIBloxRoot.Parent

local Roact = require(Packages.Roact)

local Images = require(UIBloxRoot.App.ImageSet.Images)
local InformativeToast = require(ToastRoot.InformativeToast)
local ToastContainer = require(ToastRoot.ToastContainer)

local function InformativeToastContainer()
	return Roact.createElement(StoryItem, {
		size = UDim2.new(1, 0, 1, 0),
		title = "InteractiveToastContainer",
		subTitle = "<<internal>>",
	}, {
		ToastContainer = Roact.createElement(ToastContainer, {
			anchorPoint = Vector2.new(0.5, 0),
			iconImage = Images["icons/status/warning"],
			position = UDim2.new(0.5, 0, 0, 20),
			renderToast = function(props)
				return Roact.createElement(InformativeToast, props)
			end,
			toastSubtitle = "Some details here",
			toastTitle = "Title Case",
		}),
	})
end

return function(target)
	local story = Roact.createElement(StoryView, {}, {
		Roact.createElement(InformativeToastContainer)
	})
	local handle = Roact.mount(story, target, "InformativeToast")
	return function()
		Roact.unmount(handle)
	end
end