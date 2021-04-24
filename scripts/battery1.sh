#!/usr/bin/bash
BATTERY=0
BATTERY_STATE=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o 'Discharging|Charging')
BATTERY_POWER=$(echo "${BATTERY_INFO}" | acpi -b | grep -E -o '[0-9][0-9]?%|[0-1][0-9][0-9]?%' | cut -d "%" -f1)

if [[ "${BATTERY_POWER}" -gt 87 ]]; then
    BATTERY_ICON="🔋"
elif [[ "${BATTERY_POWER}" -gt 70 ]]; then
    BATTERY_ICON="🔋"
elif [[ "${BATTERY_POWER}" -gt 50 ]]; then
    BATTERY_ICON="🔋"
elif [[ "${BATTERY_POWER}" -gt 15 ]]; then
    BATTERY_ICON="🔋"
elif [[ "${BATTERY_POWER}" -gt 0 ]]; then
    BATTERY_ICON="🔋"
fi
if [[ "${BATTERY_STATE}" = "Discharging" ]]; then
    echo " ${BATTERY_ICON} ${BATTERY_POWER}%"
    echo " ${BATTERY_ICON} ${BATTERY_POWER}%"
    echo "#ffffff"
    echo "#000000"
    echo "#000000"
    echo ""
else
    echo " 🔌 ${BATTERY_POWER}%"
    echo " 🔌 ${BATTERY_POWER}%"
    echo "#ffffff"
    echo "#000000"
    echo "#000000"
    echo ""
fi
