local os = require("os")

local demoTimer = hl.timer(function()
    hl.exec_cmd(
        "notify-send -r 444 -t 3000 -i ~/.themes/Colloid-Green-Dark/actions/symbolic/cross-small-symbolic.svg 'Time' "
        .. os.date('%H:%M')
    )
    hl.exec_cmd(
        "notify-send -r 445 -t 3000 -i ~/.themes/Colloid-Green-Dark/actions/symbolic/cross-small-symbolic.svg 'Battery' $($HOME/.local/bin/scripts/battery.sh percentage)"
    )
end, { timeout = 5 * 60 * 1000, type = "repeat" })

demoTimer:set_enabled(true)
