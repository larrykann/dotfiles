#!/usr/bin/env lua

-- Colors
local colors = {
    red = "\27[31m",
    orange = "\27[33m",
    yellow = "\27[93m",
    white = "\27[97m",
    cyan = "\27[36m",
    blue = "\27[34m",
    green = "\27[32m",
    purple = "\27[35m",
    reset = "\27[0m"
}

-- Helper function to execute shell commands and get output
local function exec(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return string.gsub(result, "^%s+", ""):gsub("%s+$", "")
end

-- Get system information with fallbacks
local hostname = exec("hostname 2>/dev/null || cat /etc/hostname 2>/dev/null || echo $HOSTNAME")
if hostname == "" then
    hostname = "Unknown"
end

local os_name = exec("grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '=\"'")
local kernel = exec("uname -r")
local uptime = exec("uptime -p | sed 's/up //g'")
local packages = exec("if command -v dpkg > /dev/null; then dpkg --get-selections | wc -l; elif command -v rpm > /dev/null; then rpm -qa | wc -l; else echo \"N/A\"; fi")

-- CPU Info
local cpu_model = exec("grep -m 1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ *//'")
local cpu_cores = exec("grep -c 'processor' /proc/cpuinfo")

-- Memory
local mem_data = exec("free -h | grep Mem")
local mem_total = exec("echo '" .. mem_data .. "' | awk '{print $2}'")
local mem_used = exec("echo '" .. mem_data .. "' | awk '{print $3}'")

-- Disk
local disk_data = exec("df -h --total | grep total")
local disk_total = exec("echo '" .. disk_data .. "' | awk '{print $2}'")
local disk_used = exec("echo '" .. disk_data .. "' | awk '{print $3}'")
local disk_percent = exec("echo '" .. disk_data .. "' | awk '{print $5}'")

-- GPU - Simple approach with a single command
local gpu_info = exec("lspci | grep -i 'vga\\|3d\\|2d' | head -n 1 | sed 's/.*: //'")
if gpu_info == "" then
    gpu_info = "N/A"
end

-- Network connection (moved here after other info)
local connection_info = "Offline"
local wifi_info = exec("iwgetid -r 2>/dev/null")
if wifi_info ~= "" then
    connection_info = "WiFi: " .. wifi_info
else
    -- Check for active ethernet connections
    local eth_check = exec("ip link | grep 'state UP' | grep -v 'lo' | cut -d: -f2 | head -n1 | tr -d ' '")
    if eth_check ~= "" then
        connection_info = "Ethernet: " .. eth_check
    end
end

print("")
-- System information display with vertical text
print(colors.green .. "S │" .. colors.reset .. " " .. colors.purple .. "Host:" .. colors.reset .. "      " .. hostname)
print(colors.green .. "Y │" .. colors.reset .. " " .. colors.purple .. "OS:" .. colors.reset .. "        " .. os_name)
print(colors.green .. "S │" .. colors.reset .. " " .. colors.purple .. "Kernel:" .. colors.reset .. "    " .. kernel)
print(colors.green .. "T │" .. colors.reset .. " " .. colors.purple .. "Uptime:" .. colors.reset .. "    " .. uptime)
print(colors.green .. "E │" .. colors.reset .. " " .. colors.purple .. "Packages:" .. colors.reset .. "  " .. packages)
print(colors.green .. "M │" .. colors.reset .. " " .. colors.purple .. "Net:" .. colors.reset .. "       " .. connection_info)
print(colors.green .. "  │" .. colors.reset)
print(colors.green .. "I │" .. colors.reset .. " " .. colors.purple .. "CPU:" .. colors.reset .. "       " .. cpu_model .. " (" .. cpu_cores .. " cores)")
print(colors.green .. "N │" .. colors.reset .. " " .. colors.purple .. "Memory:" .. colors.reset .. "    " .. mem_used .. " / " .. mem_total)
print(colors.green .. "F │" .. colors.reset .. " " .. colors.purple .. "Disk:" .. colors.reset .. "      " .. disk_used .. " / " .. disk_total .. " (" .. disk_percent .. ")")
print(colors.green .. "O │" .. colors.reset .. " " .. colors.purple .. "GPU:" .. colors.reset .. "       " .. gpu_info)
print("")
