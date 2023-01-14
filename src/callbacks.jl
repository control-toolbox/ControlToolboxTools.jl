# --------------------------------------------------------------------------------------------------
# General abstract type for callbacks
abstract type ControlToolboxCallback end
const ControlToolboxCallbacks = Tuple{Vararg{ControlToolboxCallback}}

# --------------------------------------------------------------------------------------------------
# Print callback
mutable struct PrintCallback <: ControlToolboxCallback
    callback::Function
    priority::Integer
    function PrintCallback(cb::Function; priority::Integer=1)
        new(cb, priority)
    end
end
# todo: essayer de mettre args... pour éviter de fixer ici les arguments
function (cb::PrintCallback)(i, sᵢ, dᵢ, xᵢ, gᵢ, fᵢ)
    return cb.callback(i, sᵢ, dᵢ, xᵢ, gᵢ, fᵢ)
end
const PrintCallbacks = Tuple{Vararg{PrintCallback}}

#
function get_priority_print_callbacks(cbs::ControlToolboxCallbacks)
    callbacks_print = ()
    priority = -Inf

    # search highest priority
    for cb in cbs
        if typeof(cb) === PrintCallback && cb.priority ≥ priority
            priority = cb.priority
        end
    end

    # add callbacks
    for cb in cbs
        if typeof(cb) === PrintCallback && cb.priority == priority
            callbacks_print = (callbacks_print..., cb)
        end
    end
    return callbacks_print
end

# Stop callback
mutable struct StopCallback <: ControlToolboxCallback
    callback::Function
    priority::Integer
    function StopCallback(cb::Function; priority::Integer=1)
        new(cb, priority)
    end
end
function (cb::StopCallback)(i, sᵢ, dᵢ, xᵢ, gᵢ, fᵢ, ng₀, optimalityTolerance, absoluteTolerance, 
            stagnationTolerance, iterations)
    return cb.callback(i, sᵢ, dᵢ, xᵢ, gᵢ, fᵢ, ng₀, optimalityTolerance, absoluteTolerance, 
            stagnationTolerance, iterations)
end
const StopCallbacks = Tuple{Vararg{StopCallback}}

#
function get_priority_stop_callbacks(cbs::ControlToolboxCallbacks)
    callbacks_stop = ()
    priority = -Inf

    # search highest priority
    for cb in cbs
        if typeof(cb) === StopCallback && cb.priority ≥ priority
            priority = cb.priority
        end
    end

    # add callbacks
    for cb in cbs
        if typeof(cb) === StopCallback && cb.priority == priority
            callbacks_stop = (callbacks_stop..., cb)
        end
    end
    return callbacks_stop
end
