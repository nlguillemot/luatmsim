local M  = { }

_debugLevel = 2

_ansiRed = '\027[91m'
_ansiEnd = '\027[0m'

local function _tapeToString (tape, mark)
    local keys = { }
    for k,_ in pairs(tape) do
        keys[#keys + 1] = k
    end
    table.sort(keys)

    local pieces = { }
    for _,k in ipairs(keys) do
        local v = tape[k]
        if mark and mark == k then
            pieces[#pieces + 1] = _ansiRed
        end
        pieces[#pieces + 1] = v
        if mark and mark == k then
            pieces[#pieces + 1] = _ansiEnd
        end
    end
    return table.concat(pieces)
end

function M.NewAcceptor(q0, delta)
    local stateToTransition = { }
    for _,transition in pairs(delta) do
        local fromState = transition[1][1]
        local withInput = transition[1][2]
        stateToTransition[fromState] = stateToTransition[fromState] or { }
        stateToTransition[fromState][withInput] = {
            nextState = transition[2][1],
            action = transition[2][2]
        }
    end

    return function (originalInput, maxSteps)
        maxSteps = maxSteps or 999
        local currentState = q0

        local inputTape = { }
        for i = 1, #originalInput do
            inputTape[i] = originalInput:sub(i,i)
        end

        local minTapeHead = 1
        local numSteps = 0
        local tapeHead = #inputTape + 1
        inputTape[tapeHead] = '#'

        if _debugLevel >= 2 then
            print("Initial tape:")
            print(_tapeToString(inputTape))
            print(string.rep("~", tapeHead - minTapeHead) .. "^")
        end

        while currentState ~= 'h' do
            if numSteps >= maxSteps then
                return false, "Didn't halt after " .. numSteps .. " steps"
            end

            inputTape[tapeHead] = inputTape[tapeHead] or '#'
            local currentInput = inputTape[tapeHead] or '#'
            local transition = stateToTransition[currentState][currentInput]

            if not transition then
                return false, "No transition on input " .. currentInput .. " from state " .. currentState
            end

            if _debugLevel >= 1 then
                print("From state " .. currentState .. " to state " .. transition.nextState ..
                      " on input " .. currentInput .. " with action " .. transition.action)
            end

            local action = transition.action
            local wasWriteAction = false
            if action == 'L' or action == 'R' then
                tapeHead = tapeHead + (action == 'L' and -1 or 1)
                inputTape[tapeHead] = inputTape[tapeHead] or '#'
                minTapeHead = tapeHead < minTapeHead and tapeHead or minTapeHead
            else
                wasWriteAction = true
                inputTape[tapeHead] = action
            end

            if _debugLevel >= 2 then
                print(_tapeToString(inputTape, wasWriteAction and tapeHead or nil))
                print(string.rep("~", tapeHead - minTapeHead) .. "^")
            end

            currentState = transition.nextState
            
            numSteps = numSteps + 1
        end

        return true, "Halted after " .. numSteps .. " steps"
    end
end

return M
