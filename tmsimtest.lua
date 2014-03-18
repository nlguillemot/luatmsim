local tmsim = require "tmsim"

q0 = 's'
delta = {
    { { 's', '#' } , { 't', 'L' } },
    { { 't', '0' } , { 'u', '#' } },
    { { 'u', '#' } , { 'v', 'R' } },
    { { 'v', '#' } , { 'v', '0' } },
    { { 'v', '0' } , { 's', 'L' } },
    { { 't', '1' } , { 'w', '#' } },
    { { 'w', '#' } , { 'x', 'R' } },
    { { 'x', '#' } , { 'x', '1' } },
    { { 'x', '1' } , { 's', 'L' } },
    { { 't', '#' } , { 'y', 'R' } },
    { { 'y', '#' } , { 'z', 'R' } },
    { { 'z', '0' } , { 'z', 'R' } },
    { { 'z', '1' } , { 'z', 'R' } },
    { { 'z', '#' } , { 'h', '#' } }
}

acceptor = tmsim.NewAcceptor(q0, delta)

tests = {
    '001'
}

for _,test in ipairs(tests) do
    local result, reason = acceptor(test, 100)
    local message = result and 'accepted' or 'not accepted'
    print(test .. ' was ' .. message .. ': ' .. reason)
end
