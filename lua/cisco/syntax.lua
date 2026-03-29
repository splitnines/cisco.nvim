local M = {}

local function syn_keyword(group, words)
  vim.cmd("syntax keyword " .. group .. " " .. table.concat(words, " "))
end

local function syn_match(group, pattern)
  vim.cmd("syntax match " .. group .. " /" .. pattern .. "/")
end

function M.apply()
  if vim.b.current_syntax then
    return
  end

  vim.opt_local.iskeyword:append("-")
  vim.opt_local.iskeyword:append("_")
  vim.opt_local.iskeyword:append(":")

  syn_match("ciscoDef", [[\s\u\S\+]])

  syn_keyword("ciscoCond", { "match", "eq", "neq", "gt", "lt", "ge", "le", "range" })

  syn_keyword("ciscoKeyword", {
    "speed", "duplex", "negotiation", "delay", "bandwidth", "preempt", "priority", "timers",
    "logging", "log", "login", "password", "username", "user", "license", "host", "hostname", "system",
    "address", "network", "route", "neighbor", "redistribute", "default-gateway", "community",
    "version", "class", "switchport", "clock", "name", "minimum", "maximum", "level", "size",
    "established", "source", "destination", "allowed",
    "timeout", "threshold", "frequency", "keepalive", "average", "weights", "mtu", "tunnel",
    "privilege", "secret",
  })
  syn_match("ciscoKeyword", [[timestamps\?]])

  syn_keyword("ciscoProtocol", {
    "ipv4", "ipv6", "tcp", "udp", "icmp", "echo",
    "http", "https", "www", "dhcp", "domain", "nameserver", "ssh", "telnet", "ftp", "ftp-data",
    "ntp", "snmp", "snmptrap", "syslog",
    "smtp", "pop2", "pop3",
    "klogin", "kshell", "login", "rlogin", "sunrpc",
    "mpls", "rip", "isis", "ospf", "ospfv3", "eigrp", "bgp", "hsrp", "vrrp", "ipsla",
    "isdn", "dial", "hdlc", "frame-relay", "atm",
    "igmp", "multicast", "broadcast",
    "rsa", "pki", "isakmp", "ipsec", "ike", "esp", "gre", "vpn", "mvpn", "pppoe",
    "qos", "cef", "pim", "ahp", "tacacs",
    "cdp", "lldp", "vtp", "spanning-tree", "lacp", "dot1Q", "l2tun", "ethernet",
    "aaa", "aaa-server",
  })
  syn_match("ciscoProtocol", [[traps\?]])

  syn_keyword("ciscoConfigure", {
    "activate", "set", "default", "redundancy", "prefe", "ron", "tag",
    "inside", "outside", "input", "output", "static", "export", "import",
  })

  syn_keyword("ciscoFunction", {
    "service", "crypto", "encapsulation", "standby", "mode", "in", "out",
    "storm-control", "snmp-server", "group", "nat", "banner", "mask", "seq", "metric",
    "add-route", "shape", "rd", "route-target", "as-path", "remote-as",
    "access-list", "access-class", "access-group", "prefix-list",
    "passive-interface", "distribute-list", "permit", "subnet-zero",
  })
  syn_match("ciscoFunction", [[channel\-\(group\|protocol\)]])

  syn_match("ciscoComment", [[!.*$]])
  syn_match("ciscoComment", [[no\s.*$]])
  syn_match("ciscoComment", [[description.*$]])
  syn_match("ciscoComment", [[remark.*$]])
  syn_match("ciscoComment", [[\s*#.*$]])

  syn_match("ciscoString", [["[^"]*"]])

  syn_match("ciscoInterface", [[^\(interface\|vlan\|line\|router\|track\)\s.*\d$]])
  syn_match("ciscoInterface", [[^ip\s\(sla\|vrf\)\s.*\d$]])
  syn_match("ciscoInterface", [[^monitor\ssession\s\d\+$]])
  syn_match("ciscoInterface", [[^\(class\|policy\|route\)\-map\s.*$]])
  syn_match("ciscoInterface", [[^ip\saccess\-list\s\(standard\|extended\)\s.*$]])
  syn_match("ciscoInterface", [[^vrf\s\(definition\|context\)\s.*$]])
  syn_match("ciscoInterface", [[^address\-family\sipv.*$]])

  syn_keyword("ciscoAction", { "disable", "deny", "shutdown", "down", "none" })

  syn_keyword("ciscoVar", {
    "trunk", "access", "full", "full-duplex", "auto", "active", "monitor",
    "any", "enable", "disable",
    "pvst", "mst", "rapid-pvst", "transparent", "server", "client",
  })
  syn_match("ciscoVar", [[\d\+[mg]\?]])

  syn_match("ciscoIpv4", [[\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\(\/[0-9]\{1,2\}\)\?]])

  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{7}\(\:\|\(\x\{1,4}\)\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{6}\(\:\|\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\|\(\:\x\{1,4}\)\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{5}\(\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)\|\(\(\:\x\{1,4}\)\{1,2}\)\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{4}\(\:\x\{1,4}\)\{0,1}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{4}\(\:\x\{1,4}\)\{0,1}\(\(\:\x\{1,4}\)\{1,2}\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{3}\(\:\x\{1,4}\)\{0,2}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{3}\(\:\x\{1,4}\)\{0,2}\(\(\:\x\{1,4}\)\{1,2}\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{2}\(\:\x\{1,4}\)\{0,3}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\{2}\(\:\x\{1,4}\)\{0,3}\(\(\:\x\{1,4}\)\{1,2}\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\(\:\x\{1,4}\)\{0,4}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)]])
  syn_match("ciscoIpv6", [[\s\(\x\{1,4}\:\)\(\:\x\{1,4}\)\{0,4}\(\(\:\x\{1,4}\)\{1,2}\)]])
  syn_match("ciscoIpv6", [[\s\:\(\:\x\{1,4}\)\{0,5}\(\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)\|\(\(\:\x\{1,4}\)\{1,2}\)\)]])

  vim.cmd("highlight default link ciscoKeyword Statement")
  vim.cmd("highlight default link ciscoProtocol Type")
  vim.cmd("highlight default link ciscoAction Error")
  vim.cmd("highlight default link ciscoFunction Function")
  vim.cmd("highlight default link ciscoLabel Identifier")
  vim.cmd("highlight default link ciscoCond Type")
  vim.cmd("highlight default link ciscoComment Comment")
  vim.cmd("highlight default link ciscoString String")
  vim.cmd("highlight default link ciscoVar String")
  vim.cmd("highlight default link ciscoConfigure Identifier")
  vim.cmd("highlight default link ciscoDef String")
  vim.cmd("highlight default link ciscoInterface Underlined")
  vim.cmd("highlight default link ciscoIpv4 Underlined")
  vim.cmd("highlight default link ciscoIpv6 Underlined")

  vim.b.current_syntax = "cisco"
end

return M
