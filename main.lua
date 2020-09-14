--[[ ThrValue v1.0

https://github.com/udyux/opentx-widget-thrvalue
Copyright 2020 | Nicolas Udy | MIT License

DISCLAIMER
This script does not rely on telemetry. It does not reflect the actual craft's state and should not
be used in situations where reliable data is critical. It is the user's responsibility to check for
correct operation before use.

**IF IN DOUBT DO NOT FLY!**
]]

local inputs = {
  { "ArmSwitch", SOURCE, 115 },
  { "ArmClr", COLOR, WHITE },
  { "DisarmClr", COLOR, LIGHTGREY }
}

local function create(zone, options)
  local thr = getFieldInfo("thr").id
  return { zone = zone, options = options, thr = thr }
end

local function update(widget, options)
  widget.options = options
end

local function background() end

local function refresh(widget)
  local isDisarmed = getValue(widget.options.ArmSwitch) < 0
  local thrValue = isDisarmed and 0 or (getValue(widget.thr) + 1024) / 20.48

  lcd.setColor(CUSTOM_COLOR, widget.options.ArmClr)
  lcd.drawText(widget.zone.x, widget.zone.y, "Throttle", MIDSIZE + CUSTOM_COLOR)

  if isDisarmed then lcd.setColor(CUSTOM_COLOR, widget.options.DisarmClr) end

  lcd.drawNumber(widget.zone.x + widget.zone.w - 6, widget.zone.y, thrValue, RIGHT + DBLSIZE + CUSTOM_COLOR)
  lcd.drawText(widget.zone.x + widget.zone.w + 14, widget.zone.y + 6, "%", RIGHT + MIDSIZE + CUSTOM_COLOR)
end

return {
  name = "ThrValue",
  options = inputs,
  create  = create,
  background = background,
  update = update,
  refresh = refresh
}
