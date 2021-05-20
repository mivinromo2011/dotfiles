#!/usr/bin/bash
BATTERY=0
BATTERY_STATE=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o 'Discharging|Charging')
BATTERY_POWER=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o '[0-9][0-9]?%|[0-1][0-9][0-9]?%' | cut -d "%" -f1)

if [[ "${BATTERY_POWER}" -eq 100 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 70 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 50 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 15 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 0 ]]; then
    BATTERY_ICON=""
fi
if [[ "${BATTERY_STATE}" = "Discharging" ]]; then
    echo "${BATTERY_ICON} ${BATTERY_POWER}% "
    echo "${BATTERY_ICON} ${BATTERY_POWER}% "
    echo "#ffff00"
    echo "${get_xres dark_black:}"
    echo "${get_xres dark_black:}"
    echo ""
else
    echo " ${BATTERY_POWER}% "
    echo " ${BATTERY_POWER}% "
    echo "#00ff7f"
    echo "${get_xres dark_black:}"
    echo "${get_xres dark_black:}"
    echo ""
fi
