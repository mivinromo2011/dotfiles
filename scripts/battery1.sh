#!/usr/bin/bash
BATTERY=0
BATTERY_STATE=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o 'Discharging|Charging')
BATTERY_POWER=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o '[0-9][0-9]?%|[0-1][0-9][0-9]?%' | cut -d "%" -f1)

DEFAULT_COLOR=${DEFAULT_COLOR:-"#d8dee9"}

if [[ "${BATTERY_POWER}" -gt 87 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 70 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 50 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -gt 15 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER}" -le 10 ]]; then
    BATTERY_ICON=""
else
    BATTERY_ICON=""
fi
if [[ "${BATTERY_STATE}" = "Discharging" ]]; then
    echo " ${BATTERY_ICON} ${BATTERY_POWER}% "
    echo " ${BATTERY_ICON} ${BATTERY_POWER}% "
    echo "#d8dee9"    
    echo "#2b2b2b"
    echo "#2b2b2b"
    echo ""
else
    echo "  ${BATTERY_POWER}% "
    echo "  ${BATTERY_POWER}% "
    echo "#d8dee9"
    echo "#2b2b2b"
    echo "#2b2b2b"
    echo ""
fi
