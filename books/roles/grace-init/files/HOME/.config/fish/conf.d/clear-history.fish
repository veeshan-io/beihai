function clear-history --on-process-exit %self
    builtin history clear
    echo Session history scrubbed.  Goodbye
end
